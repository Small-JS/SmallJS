import { CompiledVariable } from "./CompiledVariable.js";
import { CompiledMethod } from "./CompiledMethod.js";
import { Naming } from "./Runtime.js";
import { SourceNode } from "source-map";
import { Position } from "./Position.js";

export class CompiledClass
{
	filename: string;
	source: string;
	bodyPosition!: Position;

	name: string = "";
	moduleName: string = "";
	superclassName: string = "";
	superclass?: CompiledClass;

	vars: CompiledVariable[] = [];
	classVars: CompiledVariable[] = [];

	methods: CompiledMethod[] = [];
	classMethods: CompiledMethod[] = [];

	references: string[] = [ "Object", "Class", "Method", "String" ];

	classInline?: SourceNode;

	constructor( filename: string, source: string )
	{
		this.filename = filename;
		this.source = source;
	}

	// Return true if name matches an instance- or class variable of this or a superclass.

	checkVariableReference( compiledVariable: CompiledVariable ): boolean
	{
		if( compiledVariable.includedIn( this.vars ) )
			return true;

		return this.superclass == null ? false : this.superclass.checkVariableReference( compiledVariable );
	}

	// Return true if name matches a class variable of this or a superclass.

	checkClassVariableReference( compiledVariable: CompiledVariable ): boolean
	{
		if( compiledVariable.includedIn( this.classVars ) )
			return true;

		return this.superclass == null ? false : this.superclass.checkClassVariableReference( compiledVariable );
	}

	// Add reference if it is new and not refering to self.

	addReference( reference: string )
	{
		if( reference != this.name )
			if( this.references.indexOf( reference ) < 0 )
				this.references.push( reference );
	}

	// Add method to class.
	// Return false on error: duplicate method.

	addMethod( method: CompiledMethod ): boolean
	{
		if( this.findMethodName( method.name ) )
			return false;

		this.methods.push( method );
		return true;
	}

	findMethodName( methodName: string ): boolean
	{
		return this.methods.find( method => method.name == methodName ) != undefined;
	}

	addClassMethod( method: CompiledMethod ): boolean
	{
		if( this.findClassMethodName( method.name ) )
			return false;

		this.classMethods.push( method );
		return true;
	}

	findClassMethodName( methodName: string ): boolean
	{
		return this.classMethods.find( method => method.name == methodName ) != undefined;
	}

	// Generate JavaScript class for instatiation objects of this ST class.
	// Contains instance variables and methods.

	generateObjectClass(): SourceNode
	{
		// Generate class type definition
		let node = new SourceNode( null, null, "", "", "class" );
		node.add( "export class " + this.jsName() );
		if( this.superclassName != 'nil' )
			node.add( " extends " + this.jsSuperclassName() );
		node.add( "\n{\n" );

		// Generate instance variables
		if( this.vars.length > 0 ) {
			for( let instVar of this.vars ) {
				node.add( "\t" + instVar.jsName() );
				if( this.name != "JsObject" )
					node.add( " = stNil" );
				node.add( ";\n" );
			}
			node.add( "\n" );
		}

		// Hardcoded method to get class object.
		node.add( "\t$class()\n\t{\n" +
			"\t\treturn " + this.jsMetaClassSingletonName() + ";\n\t}\n\n" );

		// Hardcoded method to get class module name.
		node.add( "\t$moduleName()\n\t{\n" +
			"\t\treturn stString$class.$fromJs$( '" + this.moduleName + "' );\n\t}\n\n" );

		// Generate instance methods
 		for( let method of this.methods )
		 node.add( method.generate() );

		 node.add( "}\n\n" );

		return node;
	}

	// Generate JavaScript class for instatiation of the ST class inself
	// This is sometimes called the meta class.
	// Contains class variables and methods.

	generateMetaClass(): SourceNode
	{
		// Generate class
		let node = new SourceNode( null, null, "", "", "class" );
		node.add( "export class " + this.jsMetaClassName() + " extends " );
		node.add( this.superclassName == 'nil' ? "StClass" : this.jsMetaSuperclassName() );
		node.add( "\n{\n" );

		// Generate class variables
		if( this.classVars.length > 0 ) {
			for( let classVar of this.classVars )
				node.add( "\t" + classVar.jsName() + " = stNil;\n" );
				node.add( "\n" );
		}

		node.add( "\t$basicNew()\n\t{\n" +
			"\t\treturn new " + this.jsName() + "();\n\t}\n\n" );

		node.add( "\t$jsClass()\n\t{\n" +
			"\t\treturn " + this.jsName() + ".prototype;\n\t}\n\n" );

			// Generate class methods
		for( let classMethod of this.classMethods )
			node.add( classMethod.generate() );

		node.add( "}\n\n");

		return node;
	}

	// =========================== JS naming

	jsName(): string
	{
		return Naming.classStToJs( this.name );
	}

	jsSuperclassName(): string
	{
		return Naming.classStToJs( this.superclassName );
	}

	jsMetaClassName(): string
	{
		return Naming.metaClassStToJs( this.name )
	}

	jsMetaClassSingletonName(): string
	{
		return Naming.metaClassSingletonStToJs( this.name );
	}

	jsMetaSuperclassName(): string
	{
		return Naming.metaClassStToJs( this.superclassName )
	}

}