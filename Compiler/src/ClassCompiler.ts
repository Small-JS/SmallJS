import { Parser } from "./Parser.js";
import { CompiledClass } from "./CompiledClass.js";
import { CompiledMethod } from "./CompiledMethod.js";
import { CompiledVariable } from "./CompiledVariable.js";
import { CharUtil, Naming } from "./Runtime.js";

// Playground uses local SourceNode class
// import { SourceNode } from "./SourceNode.js";
import { SourceNode } from "source-map";

export class ClassCompiler
{
	outputFolder!: string;
	parser!: Parser;

	// Currently compiling class and method plus all classes.
	class!: CompiledClass;
	method!: CompiledMethod;
	allClasses: CompiledClass[] = [];
	methodCount = 0;

	// True if last compiled object was a variable.
	// Then it's possible to assign a value to it.
	justCompiledVariable: boolean = false;

	// True if compiple class methods, otherwise compiling instance methods.
	compilingClassMethods: boolean = false;

	loadClass( filename: string, source: string ): CompiledClass
	{
		this.parser = new Parser( filename, source );
		this.class = new CompiledClass( filename, source );

		this.parser.mustParseTerm( "CLASS" );
		this.class.name = this.parser.parseClassName();

		this.parser.mustParseTerm( "EXTENDS" );
		this.class.superclassName = this.parser.parseExtendsClassName();
		if( this.class.superclassName != "nil" )
			this.class.addReference( this.class.superclassName );

		this.parser.mustParseTerm( "MODULE" );
		this.class.moduleName = this.parser.parseModuleName();

		this.parser.mustParseTerm( "CLASSVARS" );
		this.class.classVars = this.loadVariables();

		this.parser.mustParseTerm( "VARS" );
		this.class.vars = this.loadVariables();

		// Save current position in the class body source code for the compilation phase.
		this.class.bodyPosition = this.parser.position.copy();

		return this.class;
	}

	// Load variables into argument array

	loadVariables(): CompiledVariable[]
	{
		let variables: CompiledVariable[] = [];

		if( this.parser.nextChar() != "'" )
			this.error( "Expected single quoted variables list" );

		while( this.parser.peekChar() != "'" )
			variables.push( new CompiledVariable( this.parser.parseVariableName() ) );

		this.parser.nextChar();
		this.parser.skipSpace();

		return variables;
	}

	compileClasses( classes: CompiledClass[], outputFolder: string )
	{
		this.allClasses = classes;
		this.outputFolder = outputFolder;

		for( let _class of classes )
			this.compileClass( _class );
	}

	compileClass( _class: CompiledClass )
	{
		this.class = _class;
		this.parser = new Parser( _class.fileName, _class.source );
		this.parser.setPosition( _class.bodyPosition );

		// The default is compiling istance methods.
		this.compilingClassMethods = false;

		while( !this.parser.atEnd() ) {
			if( this.parser.tryParseTerm( "INLINE" ) )
				this.compileClassInline();
			else if( this.parser.tryParseTerm( "CLASSMETHODS" ) )
				this.compilingClassMethods = true;
			else if( this.parser.tryParseTerm( "METHODS" ) )
				this.compilingClassMethods = false;
			else
				this.compileMethod();
		}
	}

	// JS inline statements at the class level can be used for imports.
	// They will be placed at the start of the generated JS class.

	private compileClassInline()
	{
		if( !this.class.classInline )
			this.class.classInline = this.sourceNode( "", "classInline" );

		let source = this.parser.parseStringValue() + "\n";
		this.class.classInline.add( source );
	}

	private compileMethod()
	{
		this.method = new CompiledMethod();
		this.method.body = this.sourceNode( "", "method" );

		this.compileMethodHeader();
		this.compileMethodBody();
		this.methodCount++;
	}

	compileMethodHeader()
	{
		if( this.parser.tryParseTerm( 'async' ) )
			this.method.isAsync = true;

		this.method.name = this.parser.parseTerm();

		if( this.method.isUnary() ) {}
		else if( this.method.isBinary() )
			this.compileMethodHeaderVariable();
		else if( this.method.isKeywordSelector() ) {
			this.compileMethodHeaderVariable();
			// Check for more selectors ending with ":" plus argument.
			while( !this.parser.atEnd() && Naming.methodIsKeyword( this.parser.peekTerm() ) ) {
				this.method.name += this.parser.parseTerm();
				this.compileMethodHeaderVariable();
			}
		}
		else
			this.error( "Illegal method name: " + this.method.name );

		if( this.compilingClassMethods ) {
			if( !this.class.addClassMethod( this.method ) )
				this.error( "Duplicate class method: " + this.method.name );
		}
		else {
			if( !this.class.addMethod( this.method ) )
				this.error( "Duplicate method: " + this.method.name );
		}
	}

	compileMethodHeaderVariable()
	{
		let variableName = this.parser.parseVariableName();
		this.method.args.push( new CompiledVariable( variableName ) );
	}

	compileMethodBody()
	{
		while( !this.parser.atMethodEnd() ) {
			this.compileConstructor();
			this.compileLocalVariables();
			this.compileStatements();
		}
		this.parser.tryParseTerm( "!" );
	}

	private compileConstructor()
	{
		if( !this.method.isConstructor() )
			return;

		let node = this.sourceNode( "\t\tsuper();\n", "constructor" );
		this.method.body.add( node );
	}

	private compileLocalVariables()
	{
		if( !this.parser.tryParseTerm( "|" ) )
			return;

		while( !this.parser.tryParseTerm( "|" ) )
			this.compileLocalVariable();
	}

	private compileLocalVariable()
	{
		let variableName: string = this.parser.parseVariableName();

		if( [ 'true', 'false', 'nil', 'self', 'super', 'await' ].includes( variableName ) )
			this.error( "Local variable name is reserved word: " + variableName );

		let compiledVariable = new CompiledVariable( variableName );
		if( compiledVariable.includedIn( this.method.vars ) )
			this.error( "Duplicate local variable: " + variableName);

		let source = "\t\tlet " + compiledVariable.jsName() + " = stNil;\n";
		compiledVariable.node = this.sourceNode( source, "variable" );

		this.method.vars.push( compiledVariable );
	}

	private compileStatements()
	{
		while( !this.parser.atMethodEnd() ) {
			let node = this.compileStatement();
			this.method.body.add( node );
		}

		if( !this.method.hasReturn && !this.method.isConstructor() )
			this.method.body.add( this.sourceNode( "\t\treturn this;\n", "return self" ) );
	}

	// A statement consists of an expression,
	// possibly preceded by the return operator "^".

	private compileStatement(): SourceNode
	{
		let node = this.sourceNode( "\t\t", "statement" );

		if( this.parser.tryParseTerm( "^" ) )
		{
			this.method.hasReturn = true;
			node.add( "return " );
		}

		node.add( this.compileExpression() );

		if( this.method.hasReturn )
			node.add( this.positionedSourceNode( ";\n", "return" ) );
		else
			node.add( ";\n" );

		this.parser.tryParseTerm( "." );

		return node;
	}

	// An expression is a singe object or the result of messages sent to one,
	// ending with a period or a closing prenthesis / bracket.

	private compileExpression(): SourceNode
	{
		if( this.parser.atEnd() )
			return this.sourceNode( "", "emptyExpression" );

		return this.compileAssignment();
	}

	// Compile variable assignment and before that,
	// compile higher precedence message sends (all).

	private compileAssignment(): SourceNode
	{
		this.justCompiledVariable = false;

		let receiver = this.compileReceiver();

		if( this.parser.tryParseTerm( ":=" ) ) {
			if( !this.justCompiledVariable )
				this.error( "Left side of assignment is not a variable." );
			receiver.add( " = " ).add( this.compileAssignment() );
		}
		else
			this.compileCascadedMessages( receiver );

		return receiver;
	}

	// ======================================== Compile receiver objects

	// Compile (composed) receiver object.

	private compileReceiver(): SourceNode
	{
		let term: string = this.parser.parseTerm();

		let node: SourceNode;
		if( term == "INLINE" )
			node = this.compileInline();
		else if( term == "await" )
			node = this.compileAwait();
		else if( term == "async" )
			node = this.compileAsyncBlock();
		else if( term == "[" )
			node = this.compileBlock( false );
		else if( term == "(" )
			node = this.compileParenthesis();
		else if( CharUtil.isIdentifierStart( term ) && ![ "nil", "true", "false" ].includes( term ) )
			node = this.compileIdentifier( term );
		else
			node = this.compileLiteral( term );

		return node;
	}

	private compileInline(): SourceNode
	{
		return this.sourceNode( this.parser.parseStringValue(), "inline" );
	}

	private compileAwait(): SourceNode
	{
		let node = this.sourceNode( "", "await" );

		let className = this.parser.parseTerm();
		if( ! CharUtil.isUppercase( className ) )
			this.error( "Failed to parse class name after await" );
		node.add( this.compileClassReference( className ) + ".$fromJs$( " );

		node.add( "await " );
		node.add( this.compileExpression() );
		node.add( ".js )" );

		return node;
	}

	// Compile block following 'async' statement.
	// 'async' keyword has aleady been parsed.

	private compileAsyncBlock(): SourceNode
	{
		this.parser.mustParseTerm( "[" );

		return this.compileBlock( true );
	}

	// Compile statements within block [ ... ].
	// Opening bracket of block has aleady been parsed.

	private compileBlock( async: boolean ): SourceNode
	{
		let asyncString = async ? "async " : "";
		let node = this.sourceNode( "stBlock$class.$fromJs$( " + asyncString + "( ", "block" );

		let oldArgs = this.method.args.slice();

		if( this.parser.peekTerm() == ":" )
			this.compileBlockArguments( node );

		node.add( " ) => {\n" );

		while( this.parser.peekChar() != "]" )
			node.add( this.compileBlockStatement() );

		this.parser.mustParseTerm( "]" );
		node.add( "\t\t\t} )" );

		this.method.args = oldArgs;

		this.addClassReferenceToClassAndMethod( "Block" );

		return node;
	}

	// Parse block arguments and add them to method arguments (temporarily).

	compileBlockArguments( node: SourceNode )
	{
		let first = true;
		while( this.parser.tryParseTerm( ":" ) )
		{
			if( first )
				first = false;
			else
				node.add( ", " );

			let arg = new CompiledVariable( this.parser.parseIdentifier() );
			node.add( arg.jsName() );
			this.method.args.push( arg );
		}

		this.parser.mustParseTerm( "|" );
	}

	// A block statement consists of an expression,
	// possibly preceded by the return operator "^".

	private compileBlockStatement(): SourceNode
	{
		let node = this.sourceNode( "\t\t\t\t", "blockStatement" );
		let hasReturn = this.parser.tryParseTerm( "^" );
		let expression = this.compileExpression();
		this.parser.tryParseTerm( "." );

		if( hasReturn ) {
			this.method.hasReturnFromBlock = true;
			node.add( "throw new BlockReturn( " ).add( expression ).add( " );\n" );
		}
		else {
			// Last expression in block is return value.
			if( this.parser.peekTerm() == "]" )
				node.add( "return " );
			node.add( expression ).add( ";\n" );
		}

		return node;
	}

		// Compile expression within parenthesis ( ... ).
	// The opening parenthesis has aleady been parsed.

	private compileParenthesis(): SourceNode
	{
		let node = this.compileExpression();

		this.parser.mustParseTerm( ")" );

		return node;
	}

// Compile number or string or literal array

	private compileLiteral( literal: string ): SourceNode
	{
		let node = this.sourceNode( "", "literal" );

		if( literal == "nil" )
			node.add( "stNil" );
		else if( literal == "true" )
			node.add( "stTrue" );
		else if( literal == "false" )
			node.add( "stFalse" );
		else if( CharUtil.isDigit( literal ) || literal == "-" )
			node.add( this.compileNumber( literal ) );
		else if( literal.charAt( 0 ) == "'" ) {
			node.add( "stString$class.$fromJs$( " + literal + " )" );
			this.addClassReferenceToClassAndMethod( "String" );
		}
		else if( literal.charAt( 0 ) == "$" ) {
			node.add( "stCharacter$class.$fromJs$( " + literal.charCodeAt( 1 ) + " )" );
			this.addClassReferenceToClassAndMethod( "Character" );
		}
		else if( literal == "#" )
			node = this.compileArray();
		else
			this.error( "Illegal literal: " + literal );

		return node;
	}

	compileNumber( num: string ): string
	{
		let negate: string = "";
		if( num == "-" ) {
			negate = "-";
			num = this.parser.parseTerm();
		}

		if( !CharUtil.isDigit( num ) )
			this.error( "Illegal number: " + negate + num );

		let stClass: string;
		if( num.indexOf( "." ) >= 0 )
			stClass = "Float";
		else if( Number.isSafeInteger( Number( num ) ) )
			stClass = "Integer";
		else {
			stClass = "BigInt";
			num += "n";
		}
		this.addClassReferenceToClassAndMethod( stClass );

		return "st" + stClass + "$class.$fromJs$( " + negate + num + " )";
	}

	private compileArray(): SourceNode
	{
		this.parser.mustParseTerm( "(" );

		let node = this.sourceNode( "stArray$class.$new()", "array" );
		while( !this.parser.tryParseTerm( ")" ) )
			node.add( ".$add$( " ).add( this.compileReceiver() ).add( " )" );

		this.addClassReferenceToClassAndMethod( "Array" );

		return node;
	}

	private compileIdentifier( name: string ): SourceNode
	{
		let node = this.sourceNode( "", "identifier" );

		if( name == "self" )
			node.add( "this" );
		else if( name == "super" )
			node.add( "super" );
		else if( CharUtil.isUppercase( name ) )
			node.add( this.compileClassReference( name ) );
		else if( CharUtil.isLowercase( name ) )
			node.add( this.compileVariableReference( name ) );
		else
			this.error( "Illegal indentifier: " + name );

		return node;
	}

	private compileClassReference( name: string ): string
	{
		if( !this.checkClassReference( name ) )
			this.error( "Cannot find class reference: " + name );

		this.addClassReferenceToClassAndMethod( name );

		return Naming.metaClassSingletonStToJs( name );
	}

	private compileVariableReference( name: string ): string
	{
		if( !CharUtil.isLowercase( name ) )
			this.error( "Illegal variable name: " + name );

		let compiledVariable: CompiledVariable = new CompiledVariable( name );

		let jsName: string = '';
		if( this.method.checkVariableReference( compiledVariable ) )
			jsName = compiledVariable.jsName();
		else if( this.class.checkVariableReference( compiledVariable ) )
			jsName = "this." + compiledVariable.jsName();
		else if( this.class.checkClassVariableReference( compiledVariable ) ) {
			let classAccess = this.compilingClassMethods ? "" : "$class().";
			jsName = "this." + classAccess + compiledVariable.jsName();
		}
		else
			this.error( "Cannot find variable reference: " + name );

		this.justCompiledVariable = true;
		return jsName;
	}

	// If return true if argument matches an existing class
	// Also return trye if classes are not loaded (eval mode).

	private checkClassReference( name: string ): boolean
	{
		return this.allClasses.find( _class => _class.name == name ) != undefined;
	}

	private addClassReferenceToClassAndMethod( className: string )
	{
		this.class.addReference( className );
		this.method.addClassReference( className );
	}

	// ======================================== Compile message sends

	// Implements message cascading with ";"
	// I.e.: sending subsequent messages to the original receiver.
	// The result of the last message send is the return value.

	private compileCascadedMessages( receiver: SourceNode )
	{
		this.compileKeywordMessage( receiver );

		// Non cascaded message
		if( ! this.parser.tryParseTerm( ";" ) )
			return;

		let lastMessage = <SourceNode> receiver.children.pop();
		receiver.prepend( "( () => { let $object$ = " ).add( ";\n" );
		receiver.add( '\t\t\t$object$' ).add( lastMessage ).add( ";\n" );

		do {
			let cascadedReceiver = this.sourceNode( "$object$", "cascadedReceiver" );
			this.compileKeywordMessage( cascadedReceiver );
			if( cascadedReceiver.toString() == '$object$' )
				this.error( "Expected cascaded message" );

			// Result of last cascaded message sent is return value
			let returnString = this.parser.peekTerm() == ";" ? "" : "return ";

			receiver.add( "\t\t\t" + returnString ).add( cascadedReceiver ).add( ";\n" );
		} while( this.parser.tryParseTerm( ";" ) );

		receiver.add( "\t\t} ) ()" );
	}

	// Compile keyword message sends but before that,
	// compile higher precedence binary and unary message sends.

	private compileKeywordMessage( receiver: SourceNode )
	{
		this.compileBinaryMessages( receiver );

		// Not a keyword message
		if( ! Naming.methodIsKeywordSelector( this.parser.peekTerm() ) )
			return;

		let message = this.positionedSourceNode( "", "keywordMessage" );

		// Parse keywords and arguments
		let args: SourceNode[] = [];
		let methodName: string = "";
		do {
			methodName += this.parser.parseTerm();
			let arg = this.compileReceiver();
			this.compileBinaryMessages( arg );
			args.push( arg );
		} while( Naming.methodIsKeyword( this.parser.peekTerm() ) );

		// Save method reference for minimizing
		this.method.addMethodReference( methodName );

		// Generate JS
		message.add( "." + Naming.methodStToJs( methodName ) + "( " + args[ 0 ] );
		for( let index = 1; index < args.length; ++index )
			message.add( ", " + args[ index ] );
		message.add( " )" );

		receiver.add( message );
	}

	// Compile binary message sends but before that,
	// compile higher precedence unary message sends.

	private compileBinaryMessages( receiver: SourceNode )
	{
		this.compileUnaryMessages( receiver );

		while( Naming.methodIsBinary( this.parser.peekTerm() ) ) {
			let methodName = this.parser.parseTerm();
			// Save method reference for minimizing
			this.method.addMethodReference( methodName );

			let message = this.positionedSourceNode( "", "binaryMessage" );
			message.add( "." + Naming.methodStToJs( methodName ) + "( " );
			let arg = this.compileReceiver();
			this.compileUnaryMessages( arg );
			message.add( arg ).add( " )" );
			receiver.add( message );
		}
	}

	// Compile unary message sends which have the highest precedence

	private compileUnaryMessages( receiver: SourceNode )
	{
		while( Naming.methodIsUnary( this.parser.peekTerm() ) ) {
			let methodName = this.parser.parseTerm();
			// Save method reference for minimizing
			this.method.addMethodReference( methodName );

			let message = this.positionedSourceNode( "", "unaryMessage" );
			message.add( "." + Naming.methodStToJs( methodName ) + "()" );
			receiver.add( message );
		}
	}

	// Generate a new source node that is not connected to any ST source,
	// so does cannot have a breakpoint.

	sourceNode( script: string, name: string ): SourceNode
	{
		return new SourceNode( null, null, null, script, name );
	}

	// Generate a new source node that with ST filename, line number and column,
	// so it can be used as a breakpoint.

	positionedSourceNode( script: string, name: string ): SourceNode
	{
		return new SourceNode(
			this.parser.position.line, this.parser.position.column - 1,
			this.relativeFilename(), script, name );
	}

	// Source file names in source maps should be referenced relative to the output folder

	relativeFilename(): string
	{
		return this.relativeOutputPath() + this.class.fileName;
	}

	// Return relative path from output folder to workspace folder.
	// E.g. if output folder is "web" then relative path will be "../".
	// Note: This currently only works with output folders that are subfolders,
	//       Not with parent relative folders nor with absolute folders.

	relativeOutputPath(): string
	{
		let folder = this.outputFolder;
		if( folder == "." || folder == "./" )
			return "";

		if( folder.startsWith( "./" ) )
			folder = folder.slice( 2 );

		let result = "";
		let pos = 0;
		while( pos < folder.length )
		{
			result += "../";
			pos = folder.indexOf( "/" , pos );
			pos = pos < 0 ? folder.length : pos + 1;
		}

		return result;
	}

	error( message: string )
	{
		this.parser.error( message );
	}

}
