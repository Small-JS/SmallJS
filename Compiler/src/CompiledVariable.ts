import { Naming } from "./Runtime.js";

import { SourceNode } from "source-map";

export class CompiledVariable
{
	name: string;
	node!: SourceNode;

	constructor( name: string )
	{
		this.name = name;
	}

	includedIn( compiledVariables: CompiledVariable[] ): boolean
	{
		return compiledVariables.find( compiledVariable => compiledVariable.name == this.name ) !== undefined;
	}

	static fromVariablesString( variablesString: string ): CompiledVariable[]
	{
		let compiledVariables: CompiledVariable[] = [];

		if( variablesString != '' )
			for( let variableName of variablesString.split( ' ' ) )
				compiledVariables.push( new CompiledVariable( variableName ) );

		return compiledVariables;
	}

	// Appends dollar sign to variable names that match JS reserved words.
	// Only do this for names that *actually* cannot be used as variable names for
	// class variables, methods variables or function parameters.

	jsName(): string
	{
		return Naming.variableStToJs( this.name );
	}
}
