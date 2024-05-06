import { CompiledVariable } from "./CompiledVariable.js";
import { Naming } from "./Runtime.js";

// Playground uses local SourceNode class
// import { SourceNode } from "./SourceNode.js";
import { SourceNode } from "source-map";

export class CompiledMethod
{
	name: string = "";
	args: CompiledVariable[] = [];
	vars: CompiledVariable[] = [];
	body!: SourceNode;
	hasReturn: boolean = false;
	hasReturnFromBlock: boolean = false;
	isAsync: boolean = false;

	classReferences: string[] = [];
	methodReferences: string[] = [];
	minimized: boolean = false;

	generate(): SourceNode
	{
		let node = new SourceNode( null, null, "", "", "method" );

		// Generate optional async
		if( this.isAsync )
			node.add( 'async ' );

		// Generate name.
		node.add( "\t" + Naming.methodStToJs( this.name ) );

		// Generate arguments.
		node.add( "(" + this.generateArguments() + ")\n\t{\n" );

		// Generate local variables
		for( let variable of this.vars)
			node.add( variable.node );

		// If the method has a return from a (nested) block,
		// the exception BlockReturn needs to be caught
		// and its value returned from the method.
		if( this.hasReturnFromBlock )
			node.add( "\t\ttry {\n" )
				.add( this.body )
				.add( "\t\t}\n" )
				.add( "\t\tcatch( exception ) {\n" +
					"\t\t\tif( exception.constructor === BlockReturn )\n" +
					"\t\t\t\treturn exception.value;\n" +
					"\t\t\tthrow exception;\n\t\t}\n" );
		else
			node.add( this.body );

		node.add( "\t}\n\n" );

		return node;
	}

	generateArguments(): string
	{
		let script: string = "";

		if( this.args.length > 0 ) {
			script = " ";
			let first: boolean = true;
			for( let compiledVariable of this.args ) {
				if( first )
					first = false;
				else
					script += ", ";
				script += compiledVariable.jsName();
			}
			script += " ";
		}
		return script;
	}

	isConstructor(): boolean
	{
		return Naming.methodIsConstructor( this.name );
	}

	isUnary(): boolean
	{
		return Naming.methodIsUnary( this.name );
	}

	isBinary(): boolean
	{
		return Naming.methodIsBinary( this.name );
	}

	isKeyword(): boolean
	{
		return Naming.methodIsKeyword( this.name );
	}

	isKeywordSelector(): boolean
	{
		return Naming.methodIsKeywordSelector( this.name );
	}

	checkVariableReference( compiledVariable: CompiledVariable ): boolean
	{
		return compiledVariable.includedIn( this.args ) ||
			compiledVariable.includedIn( this.vars );
	}

	addMethodReference( methodName: string )
	{
		if( ! this.methodReferences.includes( methodName ) )
			this.methodReferences.push( methodName );
	}

	addClassReference( className: string )
	{
		if( ! this.classReferences.includes( className ) )
			this.classReferences.push( className );
	}

}
