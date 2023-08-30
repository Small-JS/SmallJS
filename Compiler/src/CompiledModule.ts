import { CompiledClass } from "./CompiledClass.js";
import { Naming } from "./Runtime.js";

import { SourceNode } from "source-map";

export class CompiledModule
{
	name: string;
	classes: CompiledClass[] = [];

	static inputFileExtension: string = ".st";
	static outputFileExtension: string = ".js";
	static mapFileExtension: string = ".map";

	constructor( name: string )
	{
		this.name = name;
	}

	generate( allClasses: CompiledClass[] ): SourceNode
	{
		this.classes = allClasses.filter( _class => _class.moduleName == this.name );

		return new SourceNode( null, null, null, "" )
			.add( this.generateModuleImports( allClasses ) )
			.add( this.generateClasses() )
			.add( this.generateObjectsInitalization() )
			.add( this.generateClassesInitalization() )
			.add( this.generateClassesInheritance() )
			.add( this.generateClassesList() );
	}

	// Generate combined imports for classes in module.

	generateModuleImports( allClasses: CompiledClass[] ): SourceNode
	{
		let references: CompiledClass[] = [];

		// Make module references from combined class references
		// that do not refer to class within this module.
		for( let _class of this.classes )
			for( let reference of _class.references )
				if( !references.find( _class => _class.name == reference ) ) {
					let referencedClass = allClasses.find( _class => _class.name == reference );
					if( referencedClass !== undefined && referencedClass.moduleName != _class.moduleName )
						references.push( referencedClass );
				}

		let node = this.sourceNode( "moduleImports" );

		node.add( this.generateDefaultImports() );

		if( references.length > 0 ) {
			for( let _class of references ) {
				let referenceString =
					Naming.classStToJs( _class.name ) + ", " +
					Naming.metaClassStToJs( _class.name ) + ", " +
					Naming.metaClassSingletonStToJs( _class.name );
				node.add( "import { " + referenceString + " } from './" + _class.moduleName + CompiledModule.outputFileExtension + "';\n" );
			}
		}

		node.add( "\n" );

		return node;
	}

	generateDefaultImports(): SourceNode
	{
		let node = this.sourceNode( "defaultImports" );

		node.add( "import { BlockReturn } from './Runtime.js';\n" );
		if( this.name != "Core" )
			node.add( "import { stNil, stTrue, stFalse } from './Core.js';\n" );

		return node;
	}

	generateClasses(): SourceNode
	{
		let node = this.sourceNode( "classes" );

		for( let _class of this.classes ) {
			if( _class.classInline )
				node.add( _class.classInline ).add( "\n" );
			node.add( _class.generateObjectClass() );
		}

		for( let _class of this.classes )
			node.add( _class.generateMetaClass() );

		return node;
	}

	// Write singleton objects known by the compiler, only in module Core.

	generateObjectsInitalization(): SourceNode
	{
		let node = this.sourceNode( "objectsInitalization" );

		if( this.name == "Core" )
			node.add(
				"export let stNil = new StNil().$js$( null );\n" +
				"export let stTrue = new StBoolean().$js$( true );\n" +
				"export let stFalse = new StBoolean().$js$( false );\n\n" );

		return node;
	}

	// Generate class initialization code
	// I.e.: Call the initizalize() function on import.
	// Must be done at end of file to prevent dependency errors.

	generateClassesInitalization(): SourceNode
	{
		let node = this.sourceNode( "classesInitalization" );

		// Generate class instance variables.

		for( let _class of this.classes )
			node.add( "export let " + Naming.metaClassSingletonStToJs( _class.name ) +
				" = new " + Naming.metaClassStToJs( _class.name ) + "();\n" );

		node.add( "\n" );

		return node;
	}

	// Must be separate from class instance initialization because of dependencies.

	generateClassesInheritance(): SourceNode
	{
		let node = this.sourceNode( "classesInheritance" );

		for( let _class of this.classes )
			if( _class.superclassName != "nil" )
				 node.add( Naming.metaClassSingletonStToJs( _class.name ) +
					".$superclass$( " + Naming.metaClassSingletonStToJs( _class.superclassName ) + " );\n" );

		node.add( "\n" );

		return node;
	}

	generateClassesList(): SourceNode
	{
		let node = this.sourceNode( "classesList" );

		for( let _class of this.classes )
			node.add( Naming.metaClassSingletonStToJs( "Class" ) +
				".$classes().$add$( " + Naming.metaClassSingletonStToJs( _class.name ) + " );\n" );

		node.add( "\n" );

		return node;
	}

	// Generate a new source node that that is not connected to any ST source,
	// so does cannot have a breakpoint.

	sourceNode( name: string ): SourceNode
	{
		return new SourceNode( null, null, null, undefined, name );
	}

}
