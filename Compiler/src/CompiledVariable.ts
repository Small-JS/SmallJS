import { CharUtil, Naming } from "./Runtime.js";

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

		for( let variableName of CompiledVariable.stringToNames( variablesString ) )
			compiledVariables.push( new CompiledVariable( variableName ) );

		return compiledVariables;
	}

	// Split whitespace delimited names string into names string array.
	// Multiple spaces, tabs, newlines and returns are allowed in the string.

	private static stringToNames( str: string ): string[]
	{
		let names: string[] = [];
		let name: string = "";

		for( let char of str ) {
			if( CharUtil.isSpace( char ) ) {
				if( name.length > 0 ) {
					names.push( name );
					name = "";
				}
			}
			else
				name = name.concat( char );
		}

		if( name.length > 0 )
			names.push( name );

		return names;
	}

	// Appends dollar sign to variable names that match JS reserved words.
	// Only do this for names that *actually* cannot be used as variable names for
	// class variables, methods variables or function parameters.

	jsName(): string
	{
		return Naming.variableStToJs( this.name );
	}
}
