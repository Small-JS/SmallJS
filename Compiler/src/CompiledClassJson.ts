// This class contains a subset of fields of CompiledClass
// that are stored as a module by the compiler in CompiledClasses.js
// This module this loaded by the VM to reconstruct the CompliledClasses of the compiler
// with just enough information to be able to compile a class from the browser.

import { CompiledClass } from "./CompiledClass.js";

export class CompiledClassJson
{
	name: string = "";
	superClassName: string = "";
	moduleName: string = "";

	static fromCompiledClass( _class: CompiledClass ): CompiledClassJson
	{
		let json = new CompiledClassJson();
		json.name = _class.name;
		json.superClassName = _class.superclassName;
		json.moduleName = _class.moduleName;

		return json;
	}

}