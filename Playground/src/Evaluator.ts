// NOTE: The class Evaluator can only be used a browser environment
// because the generated JS *module* code needs to be dymamically added as a script node to work.

import { ClassCompiler } from "./Compiler/ClassCompiler.js";
import { CompiledClass } from "./Compiler/CompiledClass.js";
import { CompiledClassJson } from "./Compiler/CompiledClassJson.js";
import { CompiledModule } from "./Compiler/CompiledModule.js";

type EvaluateResult = ( result: any ) => void;
type EvaluateError = ( error: any ) => void;

class EvaluateCallback
{
	constructor( result: EvaluateResult, error: EvaluateError )
	{
		this.result = result;
		this.error = error;
	}

	result: EvaluateResult;
	error: EvaluateError;
}
export let globalCallbacks: EvaluateCallback[] = [];

export class Evaluator
{
	static compiledClassesJson: CompiledClassJson[];

	evaluate( stExpression: string, result: EvaluateResult, error: EvaluateError )
	{
		if( Evaluator.compiledClassesJson )
			this.evaluate2( stExpression, new EvaluateCallback( result, error ), Evaluator.compiledClassesJson );
		else {
			// Put module filename in variable first to prevent compiler checks in VSCode.
			let moduleFileName: string = "./Script/CompiledClassesJson.js";
			import( moduleFileName ).then( _module =>
			{
				Evaluator.compiledClassesJson = _module.compiledClassesJson;
				this.evaluate2( stExpression, new EvaluateCallback( result, error ), Evaluator.compiledClassesJson );
			} );
		}
	}

	private evaluate2( stExpression: string, callback: EvaluateCallback, compiledClassesJson: CompiledClassJson[] )
	{
		try {
			let script = this.compile( stExpression, compiledClassesJson );
			this.evaluate3( script, callback );
		}
		catch( error: any ) {
			callback.error( error );
		}
	}

	private evaluate3( script: string, callback: EvaluateCallback )
	{
		// Remove script node first if it already exists.
		const scriptId: string = "evaluatorScript";
		let scriptElement = document.getElementById( scriptId );
		if( scriptElement != null )
			scriptElement.remove();

		// Must put callback functions in global var, so the script can find them.
		globalCallbacks.push( callback );

		let wrappedScript: string = script +
			"import { globalCallbacks } from './Evaluator.js';\n" +
			"try { let result = new StEvaluator().$evaluate();\n" +
			"\tglobalCallbacks.shift().result( result ); } \n" +
			"catch( error ) { globalCallbacks.shift().error( error ); };\n";

		// Enable this to see logs of generated code.
		// console.log( wrappedScript );

		scriptElement = document.createElement( "script" );
		scriptElement.setAttribute( "id", scriptId );
		scriptElement.setAttribute( "type", "module" );
		scriptElement.innerHTML = wrappedScript;
		document.body.appendChild( scriptElement );
	}

	private compile( stExpression: string, compiledClassesJson: CompiledClassJson[] ): string
	{
		let stClass: string =
			"CLASS Evaluator EXTENDS Object MODULE Evaluator CLASSVARS '' VARS ''\n" +
			"METHODS\nevaluate\n\t^ " + stExpression + ".\n!\n";

		let classCompiler = new ClassCompiler();
		classCompiler.allClasses = this.loadCompiledClasses( compiledClassesJson );
		let evaluatorClass: CompiledClass = classCompiler.loadClass( "", stClass );

		// Replace Evaluator class if it already exists, othwerwise add it.
		let index: number = classCompiler.allClasses.findIndex( _class => _class.name == evaluatorClass.name );
		if( index < 0 )
			classCompiler.allClasses.push( evaluatorClass );
		else
			classCompiler.allClasses[ index ] = evaluatorClass;

		classCompiler.compileClass( evaluatorClass );

		let module = new CompiledModule( "Evaluator" );
		let script = module.generate( classCompiler.allClasses );

		return script;
	}

	loadCompiledClasses( compiledClassesJson: CompiledClassJson[] ): CompiledClass[]
	{
		let compiledClasses: CompiledClass[] = [];
		for( let compiledClassJson of compiledClassesJson )
			compiledClasses.push( CompiledClassJson.asCompiledClass( compiledClassJson ) );

		// Set superclass references found by class names.
		for( let compiledClass of compiledClasses ) {
			if( compiledClass.superclassName != "nil" ) {
				compiledClass.superclass = compiledClasses.find( aClass => aClass.name == compiledClass.superclassName );
				if( compiledClass.superclass === undefined )
					throw Error( "Cannot find superclass: " + compiledClass.superclassName );
			}
		}

		return compiledClasses;
	}

}
