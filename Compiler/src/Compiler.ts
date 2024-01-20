import { ClassCompiler } from "./ClassCompiler.js";
import { CompiledModule } from "./CompiledModule.js";
import { CompiledClass } from "./CompiledClass.js";

import { exit } from "process";
import { SourceNode } from "source-map";

import * as fs from "fs";

export class Compiler
{
	noSourceMaps: boolean = false;
	skipTestFolders: boolean = false;
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
			"node <compiler folder>/out/App.js [-s] [-t] <ST source folders> [+t <ST source folders>] <JS output folder>\n" +
			"	-s: Don't generate source map files and remove existing ones.\n" +
			"	-t : Don't compile ./Test subfolders from following folders.\n" +
			"	+t : Resume compiling ./Test subfolders from following folders.\n" );

		exit( 1 );
	}

	compile( inputFolders: string[], outputFolder: string )
	{
		console.log( "SmallJS compiling: " + inputFolders.join( ", " ) + " to: " + outputFolder );
		if( this.noSourceMaps )
			console.log( 'Source maps will not be generated.' );

		this.createOutputFolder( outputFolder );

		this.compileFolders( inputFolders, outputFolder );

		console.log( "Successfully compiled modules: " + this.modules.length + " classes: " + this.classes.length );
	}

	// Create output folder if it does not exist yet.

	createOutputFolder( outputFolder: string )
	{
		if( ! fs.existsSync( outputFolder) )
			fs.mkdirSync( outputFolder );
	}

	compileFolders( inputFolders: string[], outputFolder: string )
	{
		this.modules = [];
		this.classes = [];

		for( let inputFolder of inputFolders )
			if( inputFolder == '-t' )
				this.skipTestFolders = true;
			else if( inputFolder == '+t' )
				this.skipTestFolders = false;
			else
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

		if( this.skipTestFolders && inputFolder.toLocaleLowerCase().endsWith( "/test" ) )
			return;

		let inputFile: string;
		for( inputFile of inputFiles ) {
			let inputPath: string = inputFolder + "/" + inputFile;
			if( fs.statSync( inputPath ).isDirectory() )
				this.loadClasses( inputPath );
			else if( inputFile.endsWith( CompiledModule.inputFileExtension ) )
				this.loadClass( inputPath );
		}
	}

	loadClass( fileName: string )
	{
		let source: string = fs.readFileSync( fileName ).toString();
		let newClass = new ClassCompiler().loadClass( fileName, source );

		this.addClass( newClass );
		this.addModule( newClass.moduleName );
	}

	// Add compiled class. Report compile error if the class name already exists.

	addClass( newClass: CompiledClass )
	{
		let duplicateClass = this.classes.find( _class => _class.name == newClass.name );
		if( duplicateClass )
			this.error( "Duplicate class name: " + newClass.name, newClass.fileName + " and: " + duplicateClass.fileName );

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
		// Find class Object as first ordered class.

		let unorderedClasses: CompiledClass[] = this.classes;
		let index: number = unorderedClasses.findIndex( ( _class ) => _class.name == "Object" );
		if( index < 0 )
			this.error( "Can't find class: Object." );
		let objectClass: CompiledClass = unorderedClasses[ index ];
		unorderedClasses.splice( index, 1 );

		let orderedClasses: CompiledClass[] = [ objectClass ];
		let orderedClassesIndex: number = 0;
		let superClass: CompiledClass = objectClass;

		// Now order all subclasses, in iterations.

		while( unorderedClasses.length > 0 ) {
			let remainingUnorderedClasses: CompiledClass[] = [];
			for( let unorderedClass of unorderedClasses )
				if( unorderedClass.superclassName == superClass.name ) {
					unorderedClass.superclass = superClass;
					orderedClasses.push( unorderedClass );
				}
				else
					remainingUnorderedClasses.push( unorderedClass );
			unorderedClasses = remainingUnorderedClasses;

			if( ++orderedClassesIndex >= orderedClasses.length ) {
				let unorderedClass = unorderedClasses[ 0 ];
				this.error( "Ordering classes failed for: " + unorderedClass.name + ". Check inheritance tree (EXTENDS).", unorderedClass.fileName );
			}

			superClass = orderedClasses[ orderedClassesIndex ];
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

	error( message: string, fileName?: string )
	{
		let fullMessage: string = "Compile error";
		if( fileName )
			fullMessage += " in file: " + fileName;
		fullMessage += ": " + message

		console.error( fullMessage )
		process.exit( 1 );
	}

}
