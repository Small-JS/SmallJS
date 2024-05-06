// This class contains a subset of fields of CompiledClass
// that are stored as a module by the compiler in CompiledClasses.js
// This module this loaded by the VM to reconstruct the CompliledClasses of the compiler
// with just enough information to be able to compile a class from the browser.

import { CompiledClass } from "./CompiledClass.js";
import { CompiledVariable } from "./CompiledVariable.js";

export class CompiledClassJson
{
	name: string = "";
	superClassName: string = "";
	// classVarNames: string[] = [];
	// instVarNames: string[] = [];
	moduleName: string = "";

	static fromCompiledClass( _class: CompiledClass ): CompiledClassJson
	{
		let json = new CompiledClassJson();
		json.name = _class.name;
		json.superClassName = _class.superclassName;
		json.moduleName = _class.moduleName;

		// for( let compiledVariable of _class.classVars )
		// 	json.classVarNames.push( compiledVariable.name );

		// for( let compiledVariable of _class.vars )
		// 	json.instVarNames.push( compiledVariable.name );

		return json;
	}

	static asCompiledClass( json: CompiledClassJson ): CompiledClass
	{
		let _class = new CompiledClass( "", "" );
		_class.name = json.name;
		_class.superclassName = json.superClassName;
		_class.moduleName = json.moduleName;

		// for( let varName of json.classVarNames )
		// 	_class.classVars.push( new CompiledVariable( varName ) );

		// for( let varName of json.instVarNames )
		// 	_class.vars.push( new CompiledVariable( varName ) );

		return _class;
	}

}