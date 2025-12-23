// This class contains a subset of fields of CompiledClass
// that are stored in file ClassDocumentation.json.
// That file contains class information with first comments.

// This class may only have static methods to remain exportable to JSON.

import { CompiledClass } from "./CompiledClass.js";
import { DocumentedMethodJson } from "./DocumentedMethodJson.js";

export class DocumentedClassJson
{
	name = "";
	path = "";
	module = "";
	superclass = "";
	classVars = "";
	vars = "";
	comment = "";

	classMethods: DocumentedMethodJson[] = [];
	methods: DocumentedMethodJson[] = [];

	static fromCompiledClass( _class: CompiledClass ): DocumentedClassJson
	{
		let json = new DocumentedClassJson();
		json.name = _class.name;
		json.superclass = _class.superclassName;
		json.module = _class.moduleName;
		json.comment = _class.comment;
		json.path = _class.path;

		json.classVars = "";
		for( let classVar of _class.classVars )
			json.classVars += classVar.name + " ";
		json.classVars = json.classVars.trim();

		json.vars = "";
		for( let _var of _class.vars )
			json.vars += _var.name + " ";
		json.vars = json.vars.trim();

		json.classMethods = [];
		for( let classMethod of _class.classMethods )
			json.classMethods.push(
				DocumentedMethodJson.fromCompiledMethod( classMethod ) );

		json.methods = [];
		for( let method of _class.methods )
			json.methods.push(
				DocumentedMethodJson.fromCompiledMethod( method ) );

		return json;
	}

}