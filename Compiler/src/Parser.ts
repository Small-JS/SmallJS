import { Position } from "./Position.js";
import { CharUtil } from "./Runtime.js";

export class Parser
{
	filename: string;
	source: string;
	position: Position = new Position;
	_saveNextComment = false;
	savedComment = '';

	constructor( filename: string, source: string )
	{
		this.filename = filename;
		this.source = source;
	}

	// Match argument term. if it fails, report compile error.

	mustParseTerm( term: string )
	{
		if( !this.tryParseTerm( term ) )
			this.error( "Failed to parse term: \"" + term + "\"" );
	}


	// Try to match the argument term at the current parser position.
	// If it succeeds return true and advance position.
	// Otherwise return false and the parser position remains unchanged.

	tryParseTerm( term: string ): boolean
	{
		if( this.atEnd() || this.peekTerm() != term )
			return false;

		this.parseTerm();
		return true;
	}

	// Return the next parsed term without advancing the parsing position.

	peekTerm(): string
	{
		if( this.atEnd() )
			return "";

		let savedPosition = this.position.copy();
		let term = this.parseTerm();
		this.position = savedPosition;

		return term;
	}

	// Parse the next term on the stream: value, identifier, operator, bracket.

	parseTerm(): string
	{
		this.skipSpace();

		let char: string = this.peekChar();
		let term: string;

		if( char == "$" )
			term = this.parseCharacter();
		else if( char == "'" )
			term = this.parseString();
		else if( CharUtil.isDigit( char ) )
			term = this.parseNumber();
		else if( CharUtil.isIdentifierStart( char ) )
			term = this.parseIdentifier();
		else
			term = this.parseSpecial();

		this.skipSpace();

		return term;
	}

	parseCharacter(): string
	{
		this.skipSpace();

		if( this.nextChar() != "$" )
			this.error( "Character expected.");

		let char = "$" + this.nextChar();

		this.skipSpace();

		return char;
	}

	// Parse a string after keyword INLINE, allowing newlines.

	parseInline(): string
	{
		let str: string = this.parseString( true );
		return str.substring( 1, str.length - 1 );
	}

	// Parse string; i.e. text enclosed in argument delimiters, that should be the first char
	// single or double quotes.

	parseString( allowControlChars : boolean = false ): string
	{
		this.skipSpace();

		let delimiter: string = this.nextChar();
		let str: string = delimiter;

		let char: string;
		do {
			if( this.atEnd() )
				this.error( "Unterminated string with delimiter: " + delimiter );
			char = this.nextChar();

			if( char == "\\" )
			{
				if( this.atEnd() )
					this.error( "End of file within string escape sequence." );

				char += this.nextChar();
			}

			let charCode = char.charCodeAt( 0 );
			if( ! allowControlChars && charCode < 32 )
				this.error( "Illegal character in string with code: " + charCode );

			str += char;
		} while( char != delimiter );

		this.skipSpace();

		return str;
	}

	// Parse number as a string.

	parseNumber(): string
	{
		this.skipSpace();

		if( !this.atDigit() )
			this.error( "Number expected." );

		let num: string = '';
		do {
			num += this.nextChar();
		} while( !this.atEnd() && this.atDigit() )

		// Parse fractional part of number
		if( !this.atEnd() && this.peekChar() == "." && CharUtil.isDigit( this.peekSecondChar() ) ) {
			num += this.nextChar();
			do {
				num += this.nextChar();
			} while( !this.atEnd() && this.atDigit() )
		}

		this.skipSpace();

		return num;
	}

	static specialSingleChars: string = "()[]";
	static specialMultiChars: string = "~!@#$%^&*-+=/\\,<>:;.|";

	parseSpecial(): string
	{
		this.skipSpace();

		let special: string = this.nextChar();

		if( Parser.specialSingleChars.includes( special ) )
			special;
		else if( Parser.specialMultiChars.includes( special ) )
			while( !this.atEnd() && Parser.specialMultiChars.includes( this.peekChar() ) )
				special += this.nextChar();
		else
			this.error( "Illegal special character: '" + this.peekChar() + "'" );

		this.skipSpace();

		return special;
	}

	parseIdentifier(): string
	{
		this.skipSpace();

		if( !CharUtil.isIdentifierStart( this.peekChar() ) )
			this.error( "Illegal identifier." );

		let id: string = '';
		while( !this.atEnd() && ( this.atLetter() || this.atDigit() ) )
			id += this.nextChar();

		// Method name may end with ":" in ST
		if( !this.atEnd() && this.peekChar() == ":" )
			id += this.nextChar();

		this.skipSpace();

		return id;
	}

	parseClassName(): string
	{
		let className = this.parseWord();

		if( !CharUtil.isUppercase( className ) )
			this.error( "Class name must start with uppercase letter: " + className );

		for( let i = 1; i < className.length; ++i )
			if( !CharUtil.isIdentifierNext( className[ i ] ) )
				this.error( "Illegal character in class name: " + className );

		return className;
	}

	parseExtendsClassName(): string
	{
		let className = this.parseWord();

		// Class Object extends nil (no class)
		if( className == "nil" )
			return className;

		if( !CharUtil.isUppercase( className ) )
			this.error( "Extends class name must start with uppercase letter: " + className );

		for( let i = 1; i < className.length; ++i )
			if( !CharUtil.isIdentifierNext( className[ i ] ) )
				this.error( "Illegal character in extends class name: " + className );

		return className;
	}

	parseModuleName(): string
	{
		let moduleName = this.parseWord();

		if( !CharUtil.isIdentifierStart( moduleName ) )
			this.error( "invalid start character of module name: " + moduleName );

		for( let i = 1; i < moduleName.length; ++i )
			if( !CharUtil.isIdentifierNext( moduleName[ i ] ) )
				this.error( "Illegal character in module name: " + moduleName );

		return moduleName;
	}

	parseVariableName(): string
	{
		let variableName = this.parseWord();

		if( !CharUtil.isLowercase( variableName ) )
			this.error( "Variable name must start with lower case letter: " + variableName );

		for( let i = 1; i < variableName.length; ++i )
			if( !CharUtil.isIdentifierNext( variableName[ i ] ) )
				this.error( "Illegal character in variable name: " + variableName );

		return variableName;
	}

	// Return next identifier word delimited by whitespaces or special chars.

	parseWord(): string
	{
		this.skipSpace();

		let word = '';

		while( !this.atEnd() && CharUtil.isIdentifierNext( this.peekChar() ) )
			word += this.nextChar();

		this.skipSpace();

		return word;
	}

	// Skip whitespace and comments.

	skipSpace()
	{
		this.skipWhitespace();

		// Skip, possibly multiple, comments.
		while( !this.atEnd() && this.peekChar() == "\"" )
				this.parseComment();
	}

	saveNextComment( save: boolean )
	{
		this._saveNextComment = save;
		this.savedComment = "";
	}

	parseComment(): string
	{
		if( this.nextChar() != "\"" )
			this.error( "Failed to parse comment start" );

		let comment = "";
		while( !this.atEnd() ){
			let char = this.nextChar();
			if( char == "\"")
				break;
			comment += char;
		}

		// Save comment for class, method or category
		if( this._saveNextComment ) {
			this.savedComment = comment;
			this._saveNextComment = false;
		}

		this.skipWhitespace();

		return comment;
	}

	skipWhitespace()
	{
		while( !this.atEnd() && this.atSpace() )
			this.nextChar();
	}

	// =================================== Character peek & check

	atLetter(): boolean
	{
		return CharUtil.isIdentifierStart( this.peekChar() );
	}

	atDigit(): boolean
	{
		return CharUtil.isDigit( this.peekChar() );
	}

	atSpace(): boolean
	{
		return CharUtil.isSpace( this.peekChar() );
	}

	atMethodEnd(): boolean
	{
		return this.atEnd() || this.peekTerm() == "!";
	}

// ================================= Peeking

	peekChar(): string
	{
		return this.atEnd() ? '' : this.source[ this.position.index ];
	}

	// Try to peek 2 chars ahead.

	peekSecondChar(): string
	{
		let position = this.position.index + 1;
		if( position >= this.source.length )
			return "";

		return this.source[ position ];
	}

	atEnd(): boolean
	{
		return this.position.index >= this.source.length;
	}

	// ================================ Reading

	// Return next line including terminating newline character.
	// Note: Mac-style only \r is not supported.

	nextLine(): string
	{
		let line: string = "";

		while( !this.atEnd() ) {
			let char: string = this.nextChar();
			line += char;
			if( char == "\n" )
				break;
		}

		return line;
	}

	nextChar(): string
	{
		let char = this.source[ this.position.index ];
		this.position.increment( char );
		return char;
	}

	setPosition( position: Position )
	{
		this.position = position.copy();
	}

	error( message: string )
	{
		let fullMessage: string =
			"Compile error in file: " + this.filename +
			", line " + String( this.position.line ) + ", column " + String( this.position.tabbedColumn ) +
			": " + message;

		console.error( fullMessage )
		process.exit( 1 );
	}

}
