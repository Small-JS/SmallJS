import { Naming } from "./Runtime.js";

// Playground uses local SourceNode class
import { SourceNode } from "./SourceNode.js";
// import { SourceNode } from "source-map";

export class CompiledVariable
{
	name: string;
	// Declaration of a local variable, e.g. "let a = stNil$;".
	// Not set for arguments, instance variables and class variables.
	node?: SourceNode;

	constructor( name: string )
	{
		this.name = name;
	}

	includedIn( compiledVariables: CompiledVariable[] ): boolean
	{
		return compiledVariables.find( compiledVariable => compiledVariable.name == this.name ) !== undefined;
	}

	// Appends dollar sign to variable names that match JS reserved words.
	// This is required for arguments and local variables, which are JS variables.
	// Instance and class variables are JS properties, where reserved words are allowed,
	// but they get the dollar sign too, so INLINE code uses the same name for every variable.

	jsName(): string
	{
		return Naming.variableStToJs( this.name );
	}
}
