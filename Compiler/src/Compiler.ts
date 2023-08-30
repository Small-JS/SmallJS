import { ClassCompiler } from "./ClassCompiler.js";
import { CompiledModule } from "./CompiledModule.js";
import { CompiledClass } from "./CompiledClass.js";

import { exit } from "process";
import { SourceNode } from "source-map";
import * as fs from "fs";

export class Compiler
{
	noSourceMaps: boolean = false;
	modules: CompiledModule[] = [];
	classes: CompiledClass[] = [];

	start()
	{
		let args: string[] = process.argv.slice( 2 );

		if( args.length > 0 && args[ 0 ] == '-s' ) {
			this.noSourceMaps = true;
			args.shift();
		}

		if( args.length < 2 )
			this.usage();

		let outputFolder = <string> args.pop();
		this.compile( args, outputFolder );
	}

	usage()
	{
		console.log(
			"SmallJS compiler usage: node Compiler/out/App.js [-s] <ST source folder>... <JS output folder>\n" +
			"	-s: Don't generate source map files and remove existing ones." );

		exit( 1 );
	}

	compile( inputFolders: string[], outputFolder: string )
	{
		console.log( "SmallJS compiling: " + inputFolders.join( ", " ) + " to: " + outputFolder );
		if( this.noSourceMaps )
			console.log( 'Source maps will not be generated.' );

		this.compileFolders( inputFolders, outputFolder );

		console.log( "Successfully compiled modules: " + this.modules.length + " classes: " + this.classes.length );
	}

	compileFolders( inputFolders: string[], outputFolder: string )
	{
		this.modules = [];
		this.classes = [];

		for( let inputFolder of inputFolders )
			this.loadClasses( inputFolder );

		this.orderClasses();
		new ClassCompiler().compileClasses( this.classes, outputFolder );
		this.generateModules( outputFolder );
		this.generateRuntime( outputFolder );
	}

	// Load *.st class input files from input folder and subfolders.

	loadClasses( inputFolder: string )
	{
		let inputFiles: string[] = fs.readdirSync( inputFolder );

		let inputFile: string;
		for( inputFile of inputFiles ) {
			let inputPath: string = inputFolder + "/" + inputFile;
			if( fs.statSync( inputPath ).isDirectory() )
				this.loadClasses( inputPath );
			else if( inputFile.endsWith( CompiledModule.inputFileExtension ) )
				this.loadClass( inputPath );
		}
	}

	loadClass( filename: string )
	{
		let source: string = fs.readFileSync( filename ).toString();
		let newClass = new ClassCompiler().loadClass( filename, source );

		this.addClass( newClass, filename );
		this.addModule( newClass.moduleName );
	}

	// Add compiled class. Throw error if the class name already exists.

	addClass( newClass: CompiledClass, inputPath: string )
	{
		if( this.classes.find( _class => _class.name == newClass.name ) != undefined )
			throw new Error( "Duplicate class name: '" + newClass.name + "' in file: '" + inputPath + "'" );

		this.classes.push( newClass );
	}

	// Add named module is if is new.

	addModule( moduleName: string )
	{
		if( !this.modules.find( module => module.name == moduleName ) )
			this.modules.push( new CompiledModule( moduleName ) );
	}

	// Return a list of classes in inheritance order and with superclasses set.
	// This is needed to let JS resolve class "extends" references.

	orderClasses()
	{
		let unorderedClasses: CompiledClass[] = this.classes;
		let orderedClasses: CompiledClass[] = [];

		// Class Object must go first, because of inheritance dependencies.

		let index: number = unorderedClasses.findIndex( ( _class ) => _class.name == "Object" );
		if( index < 0 )
			throw new Error( "Can't find class: Object." );
		let objectClass: CompiledClass = unorderedClasses[ index ];
		orderedClasses.push( objectClass );
		unorderedClasses.splice( index, 1 );

		let orderedClassesIndex: number = 0;
		let _class: CompiledClass = objectClass;

		while( unorderedClasses.length > 0 ) {
			let remainingUnorderedClasses: CompiledClass[] = [];
			let subClass: CompiledClass;
			for( subClass of unorderedClasses )
				if( subClass.superclassName == _class.name ) {
					subClass.superclass = _class;
					orderedClasses.push( subClass );
				}
				else
					remainingUnorderedClasses.push( subClass );
			unorderedClasses = remainingUnorderedClasses;

			if( ++orderedClassesIndex >= orderedClasses.length ) {
				let unorderedClassName: string = unorderedClasses.length == 0 ? "[unknown]" : unorderedClasses[ 0 ].name;
				throw new Error( "Ordering classes failed for: " + unorderedClassName + ", check inheritance tree (EXTENDS)." );
			}

			_class = orderedClasses[ orderedClassesIndex ];
		}

		this.classes = orderedClasses;
	}

	generateModules( outputFolder: string )
	{
		for( let module of this.modules ) {
			let codeFilename = module.name + CompiledModule.outputFileExtension;
			let codePathname = outputFolder + "/" + codeFilename;

			let mapFilename = codeFilename + CompiledModule.mapFileExtension;
			let mapPathname = outputFolder + "/" + mapFilename;

			let rootNode: SourceNode = module.generate( this.classes );

			// codeWithSourceMap interface: { code: String, map: SourceMapGenerator }
			let codeWithSourceMap = rootNode.toStringWithSourceMap( { file: mapFilename } );

			if( !this.noSourceMaps ) {
				// The comment directive "//# sourceMappingURL" must be added
				// te enable the browser debugger to find the source map.
				codeWithSourceMap.code += "\n//# sourceMappingURL=" + mapFilename + "\n";
			}

			fs.writeFileSync( codePathname, codeWithSourceMap.code );

			if( this.noSourceMaps )
				fs.unlink( mapPathname, ( err ) => { } );
			else
				fs.writeFileSync( mapPathname, codeWithSourceMap.map.toString() );

		}
	}

	// Copy Runtime.js to output folder.

	generateRuntime( outputFolder: string )
	{
		let argv1 = process.argv[ 1 ];
		let path = argv1.replaceAll( "\\", "/" );
		let compilerFolder = path.substring( 0, path.lastIndexOf( "/" ) );

		let runTimePath = compilerFolder + "/Runtime.js";
		let outputPath = outputFolder + "/Runtime.js";
		fs.copyFileSync( runTimePath, outputPath );
		fs.copyFileSync( runTimePath + ".map", outputPath + ".map" );
	}
}
