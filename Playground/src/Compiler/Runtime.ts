// Functionality that is needed for deployed SmallJS apps.
// So the Runtime.js and .map should be deployed along with compiled SmallJS packages.

// This exeption class is thrown on return from a block closure.
// Needed because JS does not support inline returning from an anonymous function.

export class BlockReturn
{
		value: any;

		constructor( value: any )
		{
			this.value = value;
		}
}

// Naming conversions form ST to JS and back.
// Static implementations that can be easily be called from ST using INLINE.

export class Naming
{
	// ================================ Class Naming

	static classPrefix = "St";
	static classSingletonPrefix = "st";
	static classPostfix = "$class";

	static classStToJs( stName: string ): string
	{
		return this.classPrefix + stName;
	}

	static classJsToSt( jsName: string ): string
	{
		return jsName.startsWith( this.classPrefix ) ?
			jsName.slice( this.classPrefix.length ) : jsName;
	}

	static metaClassStToJs( stName: string ): string
	{
		return this.classPrefix + stName + this.classPostfix;
	}

	static metaClassJsToSt( jsName: string ): string
	{
		return jsName.startsWith( this.classPrefix ) && jsName.endsWith( this.classPostfix ) ?
			jsName.substring( this.classPrefix.length, jsName.length - this.classPostfix.length ) : jsName;
	}

	static metaClassSingletonStToJs( stName: string ): string
	{
		return this.classSingletonPrefix + stName + this.classPostfix;
	}

	static metaClassSingletonJsToSt( jsName: string ): string
	{
		return jsName.startsWith( this.classSingletonPrefix ) && jsName.endsWith( this.classPostfix ) ?
			jsName.substring( this.classSingletonPrefix.length, jsName.length - this.classPostfix.length ) : jsName;
	}

	// ================================ Variable  Naming

	static variableStToJs( stName: string ): string
	{
		return this.jsReservedWords.includes( stName ) ? stName + "$" : stName;
	}

	static variableJsToSt( jsName: string ): string
	{
		return jsName.endsWith( '$' ) ? jsName.slice( -1 ) : jsName;
	}

	static jsReservedWords: string[] = [
		"arguments", "break", "case", "catch",
		"class", "const", "continue", "debugger",
		"default", "delete", "do", "else",
		"enum", "eval", "export", "extends",
		"false", "extends", "false", "finally",
		"for", "function", "if", "import",
		"in", "instanceof", "new", "null",
		"return", "super", "switch", "this",
		"throw", "true", "try", "typeof",
		"var", "void", "while", "with", "yield"
	];

	// ================================ Method  Naming

	static methodStToJs( stName: string ): string
	{
		let jsName: string;

		if( this.methodIsConstructor( stName ) )
			jsName = stName;
		else if( this.methodIsKeyword( stName ) )
			jsName = "$" + stName.replaceAll( ":", "$" );
		else if( this.methodIsBinary( stName ) )
			jsName = this.methodStToJsBinary( stName )
		else	// unary
			jsName = "$" + stName;

		return jsName;
	}

	static methodIsConstructor( name: string ): boolean
	{
		return name == "constructor";
	}

	// Return true if argument is a a unary message selector, i.e. has no arguments.

	static methodIsUnary( term: string ): boolean
	{
		if( term.length < 1 )
			return false;

		if( ! CharUtil.isIdentifierStart( term ) )
			return false;

		for( let i = 1; i < term.length; ++i )
			if( ! CharUtil.isIdentifierNext( term[ i ] ) )
				return false;

		return true;
	}

	// Return true if argument is a message selector consists of allowed operator characters.

	static methodIsBinary( term: string ): boolean
	{
		if( term.length < 1 )
			return false;

		for( let char of term )
			if( ! this.operatorMap.has( char ) )
				return false;

		return true;
	}

	// Return true if argument is a message selector in the form "selector1:selector2:"

	static methodIsKeyword( term: string )
	{
		return term.length > 0 && CharUtil.isIdentifierStart( term ) && term.endsWith( ":" );
	}

	// Return true if argument is a message selector in the form "selector1:"

	static methodIsKeywordSelector( term: string )
	{
		if( term.length < 2 )
			return false;

		if( ! term.endsWith( ":" ) )
			return false;

		if( ! CharUtil.isIdentifierStart( term ) )
			return false;

		for( let i = 1; i < term.length - 1 ; ++i )
			if( ! CharUtil.isIdentifierNext( term[ i ] ) )
				return false;

		return true;
	}

	// Map ST binaray method name, consisting of operator characters, to valid JS method name

	static methodStToJsBinary( stName: string ): string
	{
		let jsName: string = '$';

		for( let stChar of stName ) {
			let jsChar: string | undefined = this.operatorMap.get( stChar );
			if( jsChar == undefined )
				throw Error( 'Invalid operator character: ' + stChar );
			jsName += '$' + jsChar;
		}

		return jsName;
	}

	static operatorMap: Map< string, string > = new Map( [
		[ "#", "num" ],
		[ "$", "dollar" ],
		[ "%", "percnt" ],
		[ "&", "amp" ],
		[ "*", "ast" ],
		[ "+", "plus" ],
		[ ",", "comma" ],
		[ "-", "minus" ],
		[ "/", "sol" ],
		[ "<", "lt" ],
		[ "=", "equeals" ],
		[ ">", "gt" ],
		[ "@", "commat" ],
		[ "\\", "bsol" ],
		[ "|", "verbar" ],
		[ "~", "tilde" ]
	] );

	static methodJsToSt( jsName: string ): string
	{
		let stName: string = '';

		if( jsName == "constructor" )
			stName = jsName;
		else if( jsName.startsWith( "$$" ) )
			stName = this.methodJsToStBinary( jsName );
		else if( jsName.startsWith( "$" ) && jsName.endsWith( '$' ) )
			stName = jsName.slice( 1 ).replaceAll( "$", ":" );
		else if( jsName.startsWith( "$" ) )
			stName = jsName.slice( 1 );
		else
			throw Error( "Cannot map JS method name to ST: " + jsName );

		return stName;
	}

	// Convert JS operattor function name back to ST.
	// Example: "$gt$equal" converts to ">=".

	static methodJsToStBinary( jsName: string ): string
	{
		let stName: string = "";

		let start: number = 2;
		while( start < jsName.length )
		{
			let end: number = jsName.indexOf( "$", start );
			if( end < 0 )
				end = jsName.length;

			let jsOperator: string = jsName.substring( start, end );
			let stOperator: string | undefined = this.reverseOperatorMap.get( jsOperator );
			if( stOperator == undefined )
				throw Error( "Unknown JS operator name: " + jsOperator );
			stName += stOperator;

			start = end + 1;
		}

		return stName;
	}

	static reverseOperatorMap: Map< string, string > = new Map( [
		[ "excl", "!" ],
		[ "num", "#" ],
		[ "dollar", "$" ],
		[ "percnt", "%" ],
		[ "amp", "&"  ],
		[ "ast", "*"  ],
		[ "plus", "+" ],
		[ "comma", "," ],
		[ "minus", "-" ],
		[ "sol", "/" ],
		[ "lt", "<" ],
		[ "equeals", "=" ],
		[ "gt", ">" ],
		[ "commat", "@" ],
		[ "bsol", "\\" ],
		[ "verbar", "|" ],
		[ "tilde", "~" ]
	] );

}

// ====================================== CharUtil

export class CharUtil
{
	// Return true if first character in string is an alphabetical character or underscore

	static isIdentifierStart( str: string ): boolean
	{
		let code: number = str.charCodeAt( 0 );
		return ( code >= 65 && code < 91 ) || ( code >= 97 && code < 123 ) || code == 95;
	}

	// Return true if first character in string is an alphabetical character or underscore or a number

	static isIdentifierNext( str: string ): boolean
	{
		let code: number = str.charCodeAt( 0 );
		return ( code >= 65 && code < 91 ) || ( code >= 97 && code < 123 ) || code == 95 || ( code >= 48 && code <= 57 );
	}

	static isLetter( str: string ): boolean
	{
		let code: number = str.charCodeAt( 0 );
		return ( code >= 65 && code < 91 ) || ( code >= 97 && code < 123 );
	}

	static isUppercase( str: string ): boolean
	{
		let code: number = str.charCodeAt( 0 );
		return code >= 65 && code <= 90;
	}

	static isLowercase( str: string ): boolean
	{
		let code: number = str.charCodeAt( 0 );
		return code >= 97 && code <= 122;
	}

	static isDigit( str: string ): boolean
	{
		let code: number = str.charCodeAt( 0 );
		return ( code >= 48 ) && ( code <= 57 );
	}

	static isSpace( str: string ): boolean
	{
		let code: number = str.charCodeAt( 0 );
		return ( code == 32 ) || ( code == 9 ) || ( code == 10 ) || ( code == 13 );
	}
}

// ====================================== NumUtil

export class NumUtil
{
	static gcd( a: number, b: number ): number
	{

		a = Math.floor( Math.abs( a ) );
		b = Math.floor( Math.abs( b ) );

		if( b > a ) {
			let temp: number = a;
			a = b;
			b = temp
		}

		while( true ) {
			if( b == 0 )
				return a;
			a = a % b;
			if( a == 0 )
				return b;
			b = b % a;
		}
	}

	static gcdBigInt( a: bigint, b: bigint ): bigint
	{
		a = ( a >= 0n ? a : -a );
		b = ( b >= 0n ? b : -b );

		if( b > a ) {
			let temp: bigint = a; a = b; b = temp }

		while( true ) {
			if( b == 0n )
				return a;
			a = a % b;
			if( a == 0n )
				return b;
			b = b % a;
		}
	}
}

