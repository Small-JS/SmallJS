// This class contains a subset of fields of CompiledClass
// that are stored in file ClassDocumentation.json.
// That file contains method information with first comments.

import { CompiledMethod } from "./CompiledMethod.js";

export class DocumentedMethodJson
{
	name = "";
	header = "";
	category = "";
	comment = "";

	static fromCompiledMethod( method: CompiledMethod ): DocumentedMethodJson
	{
		let json = new DocumentedMethodJson();
		json.name = method.name;
		json.header = method.header;
		json.category = method.category;
		json.comment = method.comment;

		return json;
	}

}
