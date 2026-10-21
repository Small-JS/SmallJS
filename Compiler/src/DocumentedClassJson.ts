// This class contains a subset of fields of CompiledClass
// that are stored in file DocumentedClasses.json.
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

		json.classVars = _class.classVars.map( classVar => classVar.name ).join( " " );
		json.vars = _class.vars.map( _var => _var.name ).join( " " );

		json.classMethods = _class.classMethods.map( classMethod => DocumentedMethodJson.fromCompiledMethod( classMethod ) );
		json.methods = _class.methods.map( method => DocumentedMethodJson.fromCompiledMethod( method ) );

		return json;
	}

}
