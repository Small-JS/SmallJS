import { ClassCompiler } from "./ClassCompiler.js";
import { CompiledModule } from "./CompiledModule.js";
import { CompiledClass } from "./CompiledClass.js";
import { CompiledClassJson } from "./CompiledClassJson.js";
import { CompiledMethod } from "./CompiledMethod.js";

import { exit } from "process";
import * as fs from "fs";

export class Compiler
{
	static version = "1.7";

	classCompiler = new ClassCompiler();

	modules: CompiledModule[] = [];
	classes: CompiledClass[] = [];

	sourceMaps: boolean = true;
	skipTestFolders: boolean = false;

	minimize: boolean = false;
	minimizeStartClassName: string = '';
	minimizedMethodCount = 0;

	start()
	{
		let args: string[] = process.argv.slice( 2 );

		// Parse compiler opions

		while( args.length > 0 ) {
			if( args[ 0 ] == '-v' ) {
				this.showVersion();
				exit(0);
			}
			else if( args[ 0 ] == '-s' ) {
				this.sourceMaps = false;
				args.shift();
			}
			else if( args[ 0 ] == '-m' ) {
				this.minimize = true;
				args.shift();
				if( args.length < 1 )
					this.usage();
				this.minimizeStartClassName = <string> args.shift();
			}
			else
				break;
		}

		// Need at least 1 input and 1 output folder

		if( args.length < 2 )
			this.usage();

		let outputFolder = <string> args.pop();
		this.compile( args, outputFolder );
	}

	usage()
	{
		console.log(
			"Usage: <compiler folder>/start.sh [-s] [-m <start class>] [-t] <ST source folders> [+t <ST source folders>] <JS output folder>\n" +
			"	-s : Don't generate source map files and remove existing ones.\n" +
			"	-m : Minimize generated classes from specified starting class.\n" +
			"	-t : Don't compile ./Test subfolders in following folders.\n" +
			"	+t : Resume compiling ./Test subfolders in following folders.\n" +
			"	-v : Show SmallJS version number and exit.\n" );

		exit( 1 );
	}

	showVersion()
	{
		console.log( "SmallJS version: " + Compiler.version );
	}

	compile( inputFolders: string[], outputFolder: string )
	{
		console.log( "SmallJS compiling: " + inputFolders.join( ", " ) + " to: " + outputFolder );
		if( !this.sourceMaps )
			console.log( 'Source maps will not be generated.' );

		this.createOutputFolder( outputFolder );

		this.compileFolders( inputFolders, outputFolder );
	}

	createOutputFolder( outputFolder: string )
	{
		if( !fs.existsSync( outputFolder ) )
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

		this.classCompiler.compileClasses( this.classes, outputFolder );
		console.log( "Successfully compiled modules: " + this.modules.length +
			": classes: " + this.classes.length + " methods: " + this.classCompiler.methodCount );

		this.minimizeClasses();
		this.generateModules( outputFolder );
		this.generateMetaData( outputFolder );
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
	}

	// Add compiled class .
	// Report compile error if the class name already exists.

	addClass( newClass: CompiledClass )
	{
		let duplicateClass = this.classes.find( _class => _class.name == newClass.name );
		if( duplicateClass )
			this.error( "Duplicate class name: " + newClass.name,
				newClass.fileName + " and: " + duplicateClass.fileName );
		this.classes.push( newClass );

		// Add class to existing module or create new module for it.

		if( ! this.modules.find( module => module.name == newClass.moduleName ) )
			this.modules.push( new CompiledModule( newClass.moduleName ) );
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

	minimizeClasses()
	{
		if( !this.minimize )
			return;

		for( let _class of this.classes ) {
			_class.minimized = true;
			for( let method of _class.methods )
				method.minimized = true;
			for( let classMethod of _class.classMethods )
				classMethod.minimized = true;
		}
		this.minimizedMethodCount = this.classCompiler.methodCount;

		// Minimize from the starting class plus some classes that are hardcoded into the compiler.

		let startClassNames: string[] = [  this.minimizeStartClassName, "Array", "Block", "Boolean", "Class", "JsObject", "Nil", "Test" ];
		for( let className of startClassNames )
			this.minimizeFromClassName( className )

		// Now remove all classes and methods where minimized is true.

		let classesUsed: CompiledClass[] = [];
		for( let _class of this.classes )
			if( ! _class.minimized ) {
				classesUsed.push( _class );
				_class.methods = _class.methods.filter( ( method ) => ! method.minimized );
			}
		this.classes = classesUsed;

		// Regenerate modules from used classes.

		let modulesUsed: CompiledModule[] = [];
		for( let _class of this.classes )
			if( ! modulesUsed.find( module => module.name == _class.moduleName ) )
				modulesUsed.push( new CompiledModule( _class.moduleName ) );
		this.modules = modulesUsed;

		console.log( 'Minimized from class: ' + this.minimizeStartClassName +
			": modules: " + this.modules.length +
			" classes: " + this.classes.length +
			" methods: " + this.minimizedMethodCount );
	}

	minimizeFromClassName( className: string )
	{
		let _class = this.classes.find( ( _class ) => _class.name == className );
		if( !_class )
			this.error( "Can't find starting class for -m option: " + className );

		// Unset minimized for current class and super classes.

		let superClass = _class;
		while( superClass != undefined && superClass.minimized ) {
			superClass.minimized = false;
			superClass = superClass.superclass;
		}

		// Then unset 'minimize' for classes and methods referenced recursively

		for( let method of _class!.methods )
			this.minimizeFromMethod( method );

		for( let classMethod of _class!.classMethods )
			this.minimizeFromMethod( classMethod );
	}

	minimizeFromMethod( method: CompiledMethod )
	{
		if( ! method.minimized )
			return;		// Already visited, stop recursion.

		method.minimized = false;
		this.minimizedMethodCount--;

		// All class references and their superclasses to used classes

		for( let className of method.classReferences ) {
			let _class = this.findClass( className );
			while( _class != undefined && _class.minimized ) {
				_class.minimized = false;
				this.minimizeFromConstructor( _class )
				_class = _class.superclass;
			}
		}

		// For all method references of this method,
		// recurse into all used classes that implement that method.

		for( let methodName of method.methodReferences )
			for( let _class of this.classes ) {
				let method = _class.methods.find( method => method.name == methodName );
				if( method )
					this.minimizeFromMethod( method );

				let classMethod = _class.classMethods.find( method => method.name == methodName );
				if( classMethod )
					this.minimizeFromMethod( classMethod );
			}
	}

	// Minimize classes from constructor, if present

	minimizeFromConstructor( _class: CompiledClass )
	{
		let constructor = _class.findMethodName( 'constructor' )
		if( constructor )
			this.minimizeFromMethod( constructor );
	}
	findClass( name: string ): CompiledClass | undefined
	{
		return this.classes.find( ( _class ) => _class.name == name );
	}

	// Recursively *unset* minimize form argument class,
	// setting property 'strip' to false for referenced classes.

	generateModules( outputFolder: string )
	{
		for( let module of this.modules )
			module.generate( this.classes, outputFolder, this.sourceMaps );
	}

	generateMetaData( outputFolder: string )
	{
		let classesJson: CompiledClassJson[] = [];

		for( let _class of this.classes )
			classesJson.push( CompiledClassJson.fromCompiledClass( _class ) );

		let script: string = "export let compiledClassesJson = " + JSON.stringify( classesJson, undefined, "\t" ) + ";\n";
		fs.writeFileSync( outputFolder + "/CompiledClassesJson.js", script );
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
		fullMessage += ": " + message;

		console.error( fullMessage );
		process.exit( 1 );
	}

}
