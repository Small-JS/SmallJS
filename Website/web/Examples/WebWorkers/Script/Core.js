import { BlockReturn } from './Runtime.js';

import { Naming } from "./Runtime.js";

export class StObject
{
	$class()
	{
		return stObject$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toJs()
	{
		let result = stNil;
		result = stJsObject$class.$newEmpty();
		this.$ownPropertyNames().$do$( stBlock$class.$fromJs$( ( name ) => {
				return result.$atJsProperty$put$( name, this.$atProperty$( name ) );
			} ) );
		return result.$js();
	}

	$toJson()
	{
		return stString$class.$fromJs$( JSON.stringify( this.$toJs() ) );
	}

	$toJsObject()
	{
		return stJsObject$class.$fromJs$( this.$toJs() );
	}

	$toString()
	{
		return stString$class.$fromJs$( 'a ' ).$$comma( this.$class().$name() );
	}

	$toLocaleString()
	{
		return this.$toString();
	}

	$ownPropertyNames()
	{
		return stArray$class.$fromJs$elementClass$( Object.getOwnPropertyNames( this ), stString$class );
	}

	$atProperty$( name )
	{
		return stNil$class.$fromJs$( this[ name.js ] );
	}

	$atProperty$put$( name, value )
	{
		this[ name.js ] = value;
		return this;
	}

	$keys()
	{
		return stArray$class.$fromJs$elementClass$( Object.keys( this ), stString$class );
	}

	$entries()
	{
		return stArray$class.$fromJs$elementConverter$( Array.from( Object.entries( this ) ), stBlock$class.$fromJs$( ( jsEntry ) => {
				return stArray$class.$with$with$( stString$class.$fromJs$( jsEntry[ 0 ] ), jsEntry[ 1 ] );
			} ) );
	}

	$$equeals$equeals( object )
	{
		return stBoolean$class.$fromJs$( this === object );
	}

	$$equeals( object )
	{
		return this.$$equeals$equeals( object );
	}

	$$tilde$equeals( object )
	{
		return this.$$equeals( object ).$not();
	}

	$isNil()
	{
		return stFalse;
	}

	$notNil()
	{
		return this.$isNil().$not();
	}

	$argIsEqualToInteger$( integer )
	{
		return stFalse;
	}

	$argIsEqualToBigInt$( bigInt )
	{
		return stFalse;
	}

	$argIsEqualToFloat$( float )
	{
		return stFalse;
	}

	$argIsEqualToFraction$( fraction )
	{
		return stFalse;
	}

	$assert$( block )
	{
		block.$value().$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'Assertion failed: ' ).$$comma( block.$script() ) );
			} ) );
		return this;
	}

	$error$( message )
	{
		stError$class.$throw$( message );
		return this;
	}

	$subclassResponsibility()
	{
		this.$error$( stString$class.$fromJs$( 'Method should be implemented by subclass.' ) );
		return this;
	}

	$log$( message )
	{
		console.log( message.$toString().js );
		return this;
	}

	$yourself()
	{
		return this;
	}

	$halt()
	{
		this.$error$( stString$class.$fromJs$( 'Halted.' ) );
		return this;
	}

	$isKindOf$( aClass )
	{
		return this.$class().$inheritsFrom$( aClass );
	}

	$isMemberOf$( aClass )
	{
		return this.$class().$$equeals( aClass );
	}

	$respondsTo$( methodName )
	{
		return this.$class().$canUnderstand$( methodName );
	}

	$perform$( methodName )
	{
		return this[ Naming.methodStToJs( methodName.js ) ]();
	}

	$perform$with$( methodName, argument )
	{
		return this[ Naming.methodStToJs( methodName.js ) ]( argument );
	}

	$perform$with$with$( methodName, argument1, argument2 )
	{
		return this[ Naming.methodStToJs( methodName.js ) ]( argument1, argument2 );
	}

	$perform$with$with$with$( methodName, argument1, argument2, argument3 )
	{
		return this[ Naming.methodStToJs( methodName.js ) ]( argument1, argument2, argument3 );
	}

}

export class StClass extends StObject
{
	name = stNil;
	superclass = stNil;
	methods = stNil;
	classMethods = stNil;

	$class()
	{
		return stClass$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$name()
	{
		return stString$class.$fromJs$( Naming.metaClassJsToSt( this.constructor.name ) );
	}

	$toString()
	{
		return stString$class.$fromJs$( 'class ' ).$$plus( this.$name() );
	}

	$superclass()
	{
		return this.superclass;
	}

	$superclass$( aSuperclass )
	{
		this.superclass = aSuperclass;
		return this;
	}

	$classMethodNames()
	{
		return stArray$class.$fromJs$elementConverter$( Object.getOwnPropertyNames( this.constructor.prototype ), stBlock$class.$fromJs$( ( jsName ) => {
				return stString$class.$fromJs$( Naming.methodJsToSt( jsName ) );
			} ) );
	}

	$methodNames()
	{
		return stArray$class.$fromJs$elementConverter$( Object.getOwnPropertyNames( this.$jsClass() ), stBlock$class.$fromJs$( ( jsName ) => {
				return stString$class.$fromJs$( Naming.methodJsToSt( jsName ) );
			} ) );
	}

	$canUnderstand$( methodName )
	{
		let class$ = stNil;
		try {
		class$ = this;
		stBlock$class.$fromJs$( (  ) => {
				class$.$methodNames().$includes$( methodName ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stTrue );
			} ) );
				class$ = class$.$superclass();
				return class$.$notNil();
			} ).$whileTrue();
		return stFalse;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$inheritsFrom$( aClass )
	{
		let class$ = stNil;
		try {
		class$ = this;
		stBlock$class.$fromJs$( (  ) => {
				class$.$$equeals( aClass ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stTrue );
			} ) );
				class$ = class$.$superclass();
				return class$.$notNil();
			} ).$whileTrue();
		return stFalse;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

}

export class StConsole extends StObject
{
	$class()
	{
		return stConsole$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

}

export class StJsObject extends StObject
{
	js;

	$class()
	{
		return stJsObject$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$$equeals( object )
	{
		return stBoolean$class.$fromJs$( this.js === object.js );
	}

	$js()
	{
		return this.js;
	}

	$js$( aJs )
	{
		this.js = aJs;
		return this;
	}

	$jsClassName()
	{
		return this.$isUndefined().$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return stString$class.$fromJs$( 'undefined' );
			} ), stBlock$class.$fromJs$( (  ) => {
				return stString$class.$fromJs$( this.js.constructor.name );
			} ) );
	}

	$ownJsPropertyNames()
	{
		return stArray$class.$fromJs$elementClass$( Object.getOwnPropertyNames( this.js ), stString$class );
	}

	$atJsProperty$( name )
	{
		return stObject$class.$fromJs$( this.js[ name.js ] );
	}

	$atJsProperty$put$( name, value )
	{
		this.js[ name.js ] = value.$toJs();
		return this;
	}

	$isNull()
	{
		return stBoolean$class.$fromJs$( this.js == null );
	}

	$isUndefined()
	{
		return this.$isNull();
	}

	$isArray()
	{
		return stBoolean$class.$fromJs$( Array.isArray( this.js ) );
	}

	$isObject()
	{
		return stBoolean$class.$fromJs$( typeof this.js == "object" );
	}

	$isEmpty()
	{
		return stBoolean$class.$fromJs$( Object.keys( this.js ).length === 0 );
	}

	$toJs()
	{
		return this.js;
	}

	$toString()
	{
		let jsType = stNil;
		jsType = this.$isUndefined().$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return stString$class.$fromJs$( 'undefined' );
			} ), stBlock$class.$fromJs$( (  ) => {
				return stString$class.$fromJs$( this.js.toString() );
			} ) );
		return stString$class.$fromJs$( 'a ' ).$$comma( this.$class().$name() ).$$comma( stString$class.$fromJs$( '( ' ) ).$$comma( jsType ).$$comma( stString$class.$fromJs$( ' )' ) );
	}

}

export class StSqlObject extends StObject
{
	id = stNil;

	$class()
	{
		return stSqlObject$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$id()
	{
		return this.id;
	}

	$id$( aId )
	{
		this.id = aId;
		return this;
	}

	$columnValues()
	{
		let result = stNil;
		result = stArray$class.$new();
		this.$class().$columns().$do$( stBlock$class.$fromJs$( ( column ) => {
				return result.$add$( this.$atProperty$( column ) );
			} ) );
		return result;
	}

}

export class StTest extends StObject
{
	currentMethodName = stNil;
	methodAssertCount = stNil;

	$class()
	{
		return stTest$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	constructor()
	{
		super();
		this.currentMethodName = stString$class.$fromJs$( '' );
		this.methodAssertCount = stInteger$class.$fromJs$( 0 );
	}

	$enabled()
	{
		return stTrue;
	}

	$all()
	{
		this.$enabled().$ifFalse$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return stTest$class.$disabledModuleCount().$increment();
			} ), stBlock$class.$fromJs$( (  ) => {
				return this.$class().$methodNames().$do$( stBlock$class.$fromJs$( ( methodName ) => {
				return this.$isTestMethod$( methodName ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				this.currentMethodName = methodName;
				this.methodAssertCount = stInteger$class.$fromJs$( 0 );
				return this.$perform$( methodName );
			} ) );
			} ) );
			} ) );
		return this;
	}

	$isTestMethod$( methodName )
	{
		return methodName.$startsWith$( stString$class.$fromJs$( 'test' ) ).$and$( stBlock$class.$fromJs$( (  ) => {
				return methodName.$endsWith$( stString$class.$fromJs$( ':' ) ).$not();
			} ) );
	}

	$assert$( block )
	{
		this.methodAssertCount.$increment();
		stTest$class.$globalAssertCount().$increment();
		block.$value().$$equeals( stTrue ).$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				this.currentMethodName.$isNil().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.currentMethodName = stString$class.$fromJs$( '<unknown>' );
			} ) );
				return this.$error$( stString$class.$fromJs$( 'Test failed: ' ).$$comma( this.$class().$name() ).$$comma( stString$class.$fromJs$( '.' ) ).$$comma( this.currentMethodName ).$$comma( stString$class.$fromJs$( ' #' ) ).$$comma( this.methodAssertCount.$toString() ).$$comma( stString$class.$fromJs$( ': ' ) ).$$comma( block.$script() ) );
			} ) );
		return this;
	}

	$assertError$( block )
	{
		this.$assert$( stBlock$class.$fromJs$( (  ) => {
				return block.$valueOnError$( stBlock$class.$fromJs$( ( error ) => {
				return error;
			} ) ).$class().$$equeals( stError$class );
			} ) );
		return this;
	}

}

export class StTimer extends StObject
{
	id = stNil;

	$class()
	{
		return stTimer$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$timeout$then$( timeout, block )
	{
		this.id = stInteger$class.$fromJs$( setTimeout( block.js, timeout.js ) );
		return this;
	}

	$clearTimeout()
	{
		clearTimeout( this.id.js );
		return this;
	}

	$interval$then$( interval, block )
	{
		this.id = stInteger$class.$fromJs$( setInterval( block.js, interval.js ) );
		return this;
	}

	$clearInterval()
	{
		clearInterval( this.id.js );
		return this;
	}

	$id()
	{
		return this.id;
	}

}

export class StEventId extends StObject
{
	type = stNil;
	block = stNil;
	jsBlock = stNil;

	$class()
	{
		return stEventId$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$type()
	{
		return this.type;
	}

	$type$( aType )
	{
		this.type = aType;
		return this;
	}

	$block()
	{
		return this.block;
	}

	$block$( aBlock )
	{
		this.block = aBlock;
		return this;
	}

	$jsBlock()
	{
		return this.jsBlock;
	}

	$jsBlock$( aJsBlock )
	{
		this.jsBlock = aJsBlock;
		return this;
	}

}

export class StPoint extends StObject
{
	x = stNil;
	y = stNil;

	$class()
	{
		return stPoint$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toString()
	{
		return stString$class.$fromJs$( '( ' ).$$comma( this.x.$toString() ).$$comma( stString$class.$fromJs$( ' @ ' ) ).$$comma( this.y.$toString() ).$$comma( stString$class.$fromJs$( ' )' ) );
	}

	$$commat( z )
	{
		return stPoint3d$class.$x$y$z$( this.x, this.y, z );
	}

	$x()
	{
		return this.x;
	}

	$x$( aX )
	{
		this.x = aX;
		return this;
	}

	$y()
	{
		return this.y;
	}

	$y$( aY )
	{
		this.y = aY;
		return this;
	}

	$x$y$( aX, aY )
	{
		this.x = aX;
		this.y = aY;
		return this;
	}

	$z()
	{
		return stInteger$class.$fromJs$( 0 );
	}

	$$equeals( point )
	{
		return this.x.$$equeals( point.$x() ).$$amp( this.y.$$equeals( point.$y() ) );
	}

	$$lt( point )
	{
		return this.x.$$lt( point.$x() ).$$amp( this.y.$$lt( point.$y() ) );
	}

	$$lt$equeals( point )
	{
		return this.x.$$lt$equeals( point.$x() ).$$amp( this.y.$$lt$equeals( point.$y() ) );
	}

	$$gt( point )
	{
		return this.x.$$gt( point.$x() ).$$amp( this.y.$$gt( point.$y() ) );
	}

	$$gt$equeals( point )
	{
		return this.x.$$gt$equeals( point.$x() ).$$amp( this.y.$$gt$equeals( point.$y() ) );
	}

	$$plus( magnitude )
	{
		return magnitude.$addToPoint$( this );
	}

	$$minus( magnitude )
	{
		return magnitude.$subtractFromPoint$( this );
	}

	$$ast( magnitude )
	{
		return magnitude.$multiplyByPoint$( this );
	}

	$$sol( magnitude )
	{
		return magnitude.$divideIntoPoint$( this );
	}

	$$sol$sol( magnitude )
	{
		return magnitude.$integerDivideIntoPoint$( this );
	}

	$$percnt( magnitude )
	{
		return magnitude.$moduloFromPoint$( this );
	}

	$addToInteger$( integer )
	{
		return stPoint$class.$x$y$( integer.$$plus( this.x ), integer.$$plus( this.y ) );
	}

	$subtractFromInteger$( integer )
	{
		return stPoint$class.$x$y$( integer.$$minus( this.x ), integer.$$minus( this.y ) );
	}

	$multiplyByInteger$( integer )
	{
		return stPoint$class.$x$y$( integer.$$ast( this.x ), integer.$$ast( this.y ) );
	}

	$divideIntoInteger$( integer )
	{
		return stPoint$class.$x$y$( integer.$$sol( this.x ), integer.$$sol( this.y ) );
	}

	$integerDivideIntoInteger$( integer )
	{
		return stPoint$class.$x$y$( integer.$$sol$sol( this.x ), integer.$$sol$sol( this.y ) );
	}

	$moduloFromInteger$( integer )
	{
		return stPoint$class.$x$y$( integer.$$percnt( this.x ), integer.$$percnt( this.y ) );
	}

	$addToBigInt$( bigInt )
	{
		return stPoint$class.$x$y$( bigInt.$$plus( this.x ), bigInt.$$plus( this.y ) );
	}

	$subtractFromBigInt$( bigInt )
	{
		return stPoint$class.$x$y$( bigInt.$$minus( this.x ), bigInt.$$minus( this.y ) );
	}

	$multiplyByBigInt$( bigInt )
	{
		return stPoint$class.$x$y$( bigInt.$$ast( this.x ), bigInt.$$ast( this.y ) );
	}

	$divideIntoBigInt$( bigInt )
	{
		return stPoint$class.$x$y$( bigInt.$$sol( this.x ), bigInt.$$sol( this.y ) );
	}

	$integerDivideIntoBigInt$( bigInt )
	{
		return stPoint$class.$x$y$( bigInt.$$sol$sol( this.x ), bigInt.$$sol$sol( this.y ) );
	}

	$moduloFromBigInt$( bigInt )
	{
		return stPoint$class.$x$y$( bigInt.$$percnt( this.x ), bigInt.$$percnt( this.y ) );
	}

	$addToFraction$( fraction )
	{
		return stPoint$class.$x$y$( fraction.$$plus( this.x ), fraction.$$plus( this.y ) );
	}

	$subtractFromFraction$( fraction )
	{
		return stPoint$class.$x$y$( fraction.$$minus( this.x ), fraction.$$minus( this.y ) );
	}

	$multiplyByFraction$( fraction )
	{
		return stPoint$class.$x$y$( fraction.$$ast( this.x ), fraction.$$ast( this.y ) );
	}

	$divideIntoFraction$( fraction )
	{
		return stPoint$class.$x$y$( fraction.$$sol( this.x ), fraction.$$sol( this.y ) );
	}

	$integerDivideIntoFraction$( fraction )
	{
		return stPoint$class.$x$y$( fraction.$$sol$sol( this.x ), fraction.$$sol$sol( this.y ) );
	}

	$moduloFromFraction$( fraction )
	{
		return stPoint$class.$x$y$( fraction.$$percnt( this.x ), fraction.$$percnt( this.y ) );
	}

	$addToFloat$( float )
	{
		return stPoint$class.$x$y$( float.$$plus( this.x ), float.$$plus( this.y ) );
	}

	$subtractFromFloat$( float )
	{
		return stPoint$class.$x$y$( float.$$minus( this.x ), float.$$minus( this.y ) );
	}

	$multiplyByFloat$( float )
	{
		return stPoint$class.$x$y$( float.$$ast( this.x ), float.$$ast( this.y ) );
	}

	$divideIntoFloat$( float )
	{
		return stPoint$class.$x$y$( float.$$sol( this.x ), float.$$sol( this.y ) );
	}

	$integerDivideIntoFloat$( float )
	{
		return stPoint$class.$x$y$( float.$$sol$sol( this.x ), float.$$sol$sol( this.y ) );
	}

	$moduloFromFloat$( float )
	{
		return stPoint$class.$x$y$( float.$$percnt( this.x ), float.$$percnt( this.y ) );
	}

	$addToPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$plus( this.x ), point.$y().$$plus( this.y ) );
	}

	$subtractFromPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$minus( this.x ), point.$y().$$minus( this.y ) );
	}

	$multiplyByPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$ast( this.x ), point.$y().$$ast( this.y ) );
	}

	$divideIntoPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$sol( this.x ), point.$y().$$sol( this.y ) );
	}

	$integerDivideIntoPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$sol$sol( this.x ), point.$y().$$sol$sol( this.y ) );
	}

	$moduloFromPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$percnt( this.x ), point.$y().$$percnt( this.y ) );
	}

	$negated()
	{
		return stPoint$class.$x$y$( this.x.$negated(), this.y.$negated() );
	}

	$abs()
	{
		return stPoint$class.$x$y$( this.x.$abs(), this.y.$abs() );
	}

	$dotProduct$( point )
	{
		return this.x.$$ast( point.$x() ).$$plus( this.y.$$ast( point.$y() ) );
	}

}

export class StRect extends StObject
{
	origin = stNil;
	extent = stNil;

	$class()
	{
		return stRect$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toString()
	{
		return stString$class.$fromJs$( 'Rect( ' ).$$comma( this.origin.$toString() ).$$comma( stString$class.$fromJs$( ' , ' ) ).$$comma( this.extent.$toString() ).$$comma( stString$class.$fromJs$( ' )' ) );
	}

	$origin$extent$( anOrigin, anExtent )
	{
		this.origin = anOrigin;
		this.extent = anExtent;
		return this;
	}

	$origin()
	{
		return this.origin;
	}

	$extent()
	{
		return this.extent;
	}

	$$equeals( rectangle )
	{
		return this.origin.$$equeals( rectangle.$origin() ).$$amp( this.extent.$$equeals( rectangle.$extent() ) );
	}

}

export class StBlock extends StJsObject
{
	$class()
	{
		return stBlock$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$script()
	{
		return stString$class.$fromJs$( this.js.toString() );
	}

	$value()
	{
		return this.js();
	}

	$value$( arg1 )
	{
		return this.js( arg1 );
	}

	$value$value$( arg1, arg2 )
	{
		return this.js( arg1, arg2 );
	}

	$valueOnError$( block )
	{
		try { return this.$value() } catch( error ) { return block.$value$( stError$class.$fromJs$( error ) ) };
		return this;
	}

	$whileTrue$( block )
	{
		while( this.$value().js ) block.$value();
		return this;
	}

	$whileTrue()
	{
		while( this.$value().js );
		return this;
	}

	$and$( block )
	{
		return this.$value().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return block.$value();
			} ) );
	}

	$or$( block )
	{
		return this.$value().$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return block.$value();
			} ) );
	}

}

export class StBoolean extends StJsObject
{
	$class()
	{
		return stBoolean$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toString()
	{
		return this.$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return stString$class.$fromJs$( 'true' );
			} ), stBlock$class.$fromJs$( (  ) => {
				return stString$class.$fromJs$( 'false' );
			} ) );
	}

	$$lt( boolean )
	{
		return stBoolean$class.$fromJs$( this.js < boolean.js );
	}

	$$gt( boolean )
	{
		return stBoolean$class.$fromJs$( this.js > boolean.js );
	}

	$$lt$equeals( boolean )
	{
		return stBoolean$class.$fromJs$( this.js <= boolean.js );
	}

	$$gt$equeals( boolean )
	{
		return stBoolean$class.$fromJs$( this.js >= boolean.js );
	}

	$compare$( boolean )
	{
		return this.$$lt( boolean ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return stInteger$class.$fromJs$( -1 );
			} ), stBlock$class.$fromJs$( (  ) => {
				return this.$$gt( boolean ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return stInteger$class.$fromJs$( 1 );
			} ), stBlock$class.$fromJs$( (  ) => {
				return stInteger$class.$fromJs$( 0 );
			} ) );
			} ) );
	}

	$ifTrue$( block )
	{
		return ( this.js ? block.$value() : this );
	}

	$ifFalse$( block )
	{
		return ( this.js ? this : block.$value() );
	}

	$ifTrue$ifFalse$( trueBlock, falseBlock )
	{
		return ( this.js ? trueBlock.$value() : falseBlock.$value() );
	}

	$ifFalse$ifTrue$( falseBlock, trueBlock )
	{
		return ( this.js ? trueBlock.$value() : falseBlock.$value() );
	}

	$and$( block )
	{
		return this.$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return block.$value();
			} ), stBlock$class.$fromJs$( (  ) => {
				return this;
			} ) );
	}

	$or$( block )
	{
		return this.$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return this;
			} ), stBlock$class.$fromJs$( (  ) => {
				return block.$value();
			} ) );
	}

	$not()
	{
		return stBoolean$class.$fromJs$( ! this.js );
	}

	$$amp( boolean )
	{
		return stBoolean$class.$fromJs$( this.js && boolean.js );
	}

	$$verbar( boolean )
	{
		return stBoolean$class.$fromJs$( this.js || boolean.js );
	}

}

export class StError extends StJsObject
{
	$class()
	{
		return stError$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$message()
	{
		return stString$class.$fromJs$( this.js.message );
	}

	$message$( message )
	{
		this.js.message = message.js;
		return this;
	}

	$toString()
	{
		return stString$class.$fromJs$( 'Error: ' ).$$comma( this.$name() ).$$comma( stString$class.$fromJs$( ': ' ) ).$$comma( this.$message() );
	}

	$throw()
	{
		throw this.js;
		return this;
	}

}

export class StNil extends StJsObject
{
	$class()
	{
		return stNil$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toString()
	{
		return stString$class.$fromJs$( 'nil' );
	}

	$isNil()
	{
		return stTrue;
	}

}

export class StPromise extends StJsObject
{
	$class()
	{
		return stPromise$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$then$( block )
	{
		this.js.then( ( result ) => block.$value$( result ) );
		return this;
	}

	$catch$( block )
	{
		this.js.catch( ( error ) => block.$value$( error ) );
		return this;
	}

	$finally$( block )
	{
		this.js.finally( () => block.$value() );
		return this;
	}

async 	$awt()
	{
		return await this.js;
	}

}

export class StPromiseStatus extends StJsObject
{
	$class()
	{
		return stPromiseStatus$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$status()
	{
		return stString$class.$fromJs$( this.js.status );
	}

	$value()
	{
		return stNil$class.$fromJs$( this.js.value );
	}

	$reason()
	{
		return stNil$class.$fromJs$( this.js.reason );
	}

}

export class StArrayBuffer extends StJsObject
{
	$class()
	{
		return stArrayBuffer$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$byteLength()
	{
		return stInteger$class.$fromJs$( this.js.byteLength );
	}

	$slice$to$( from, to )
	{
		return stArrayBuffer$class.$fromJs$( this.js.slice( from.js, to.js ) );
	}

}

export class StCollection extends StJsObject
{
	$class()
	{
		return stCollection$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

}

export class StEvent extends StJsObject
{
	$class()
	{
		return stEvent$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$bubbles()
	{
		return stBoolean$class.$fromJs$( this.js.bubbles );
	}

	$cancelable()
	{
		return stBoolean$class.$fromJs$( this.js.cancelable );
	}

	$composed()
	{
		return stBoolean$class.$fromJs$( this.js.composed );
	}

	$currentTarget()
	{
		return stEventTarget$class.$fromJs$( this.js.currentTarget );
	}

	$defaultPrevented()
	{
		return stBoolean$class.$fromJs$( this.js.defaultPrevented );
	}

	$eventPhase()
	{
		return stInteger$class.$fromJs$( this.js.eventPhase );
	}

	$isTrusted()
	{
		return stBoolean$class.$fromJs$( this.js.isTrusted );
	}

	$target()
	{
		return stEventTarget$class.$fromJs$( this.js.target );
	}

	$timeStamp()
	{
		return stDate$class.$fromJs$( this.js.timeStamp );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$composedPath()
	{
		return stArray$class.$fromJs$elementClass$( this.js.composedPath(), stEventTarget$class );
	}

	$preventDefault()
	{
		this.js.preventDefault();
		return this;
	}

	$stopImmediatePropagation()
	{
		this.js.stopImmediatePropagation();
		return this;
	}

	$stopPropagation()
	{
		this.js.stopPropagation();
		return this;
	}

}

export class StEventTarget extends StJsObject
{
	eventIds = stNil;

	$class()
	{
		return stEventTarget$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$$equeals( eventTarget )
	{
		return stBoolean$class.$fromJs$( this.js == eventTarget.js );
	}

	$eventIds()
	{
		this.eventIds.$isNil().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.eventIds = stArray$class.$new();
			} ) );
		return this.eventIds;
	}

	$addEventListener$then$( type, block )
	{
		let jsBlock = stNil;
		jsBlock = stBlock$class.$fromJs$( ( jsEvent ) => {
				return block.$value$( stEvent$class.$fromJsSubEvent$( jsEvent ) );
			} );
		this.js.addEventListener( type.js, jsBlock.js );
		this.$eventIds().$add$( stEventId$class.$fromType$block$jsBlock$( type, block, jsBlock ) );
		return this;
	}

	$removeEventListener$then$( type, block )
	{
		let eventId = stNil;
		this.eventIds.$length().$$minus( stInteger$class.$fromJs$( 1 ) ).$to$by$do$( stInteger$class.$fromJs$( 0 ), stInteger$class.$fromJs$( -1 ), stBlock$class.$fromJs$( ( index ) => {
				eventId = this.eventIds.$at$( index );
				return eventId.$type().$$equeals( type ).$$amp( eventId.$block().$$equeals( block ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				this.js.removeEventListener( eventId.type.js, eventId.jsBlock.js );
				return this.eventIds.$removeAt$( index );
			} ) );
			} ) );
		return this;
	}

	$dispatchEvent$( event )
	{
		return stBoolean$class.$fromJs$( this.dispatchEvent( event.js ) );
	}

}

export class StAbortController extends StJsObject
{
	$class()
	{
		return stAbortController$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$signal()
	{
		return stAbortSignal$class.$fromJs$( this.js.signal );
	}

	$abort()
	{
		this.js.abort();
		return this;
	}

}

export class StFormData extends StJsObject
{
	$class()
	{
		return stFormData$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$get$( name )
	{
		return stString$class.$fromJs$( this.js.get( name.js ) );
	}

	$getAll$( name )
	{
		return stArray$class.$fromJs$elemenClass$( this.js.get( name.js ), stString$class );
	}

	$set$value$( name, value )
	{
		this.js.append( name.js, value.js );
		return this;
	}

	$append$value$( name, value )
	{
		this.js.append( name.js, value.js );
		return this;
	}

	$delete$( name )
	{
		this.js.delete( name.js );
		return this;
	}

	$entries()
	{
		return stArray$class.$fromJs$( this.js.entries() );
	}

	$keys()
	{
		return stArray$class.$fromJs$( this.js.keys() );
	}

	$values()
	{
		return stArray$class.$fromJs$( this.js.values() );
	}

	$has$( name )
	{
		return stBoolean$class.$fromJs$( this.js.has( name.js ) );
	}

}

export class StHeaders extends StJsObject
{
	$class()
	{
		return stHeaders$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$append$value$( name, value )
	{
		this.js.append( name.js, value.js );
		return this;
	}

	$get$( name )
	{
		return stString$class.$fromJs$( this.js.get( name.js ) );
	}

	$set$value$( name, value )
	{
		this.js.append( name.js, value.js );
		return this;
	}

	$delete$( name )
	{
		this.js.delete( name.js );
		return this;
	}

	$has$( name )
	{
		return stBoolean$class.$fromJs$( this.js.has( name.js ) );
	}

	$entries()
	{
		return stArray$class.$fromJs$elementConverter$( this.js.entries(), stBlock$class.$fromJs$( ( jsArray ) => {
				return stArray$class.$fromJs$elementClass$( jsArray, stString$class );
			} ) );
	}

	$keys()
	{
		return stArray$class.$fromJs$elementClass$( this.js.keys(), stString$class );
	}

	$values()
	{
		return stArray$class.$fromJs$elementClass$( this.js.values(), stString$class );
	}

	$getSetCookie()
	{
		return stArray$class.$fromJs$elementClass$( this.js.getSetCookie(), stString$class );
	}

}

export class StRequest extends StJsObject
{
	$class()
	{
		return stRequest$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$body()
	{
		return stReadableStream$class.$fromJs$( this.body );
	}

	$bodyUsed()
	{
		return stBoolean$class.$fromJs$( this.js.bodyUsed );
	}

	$bodyUsed$( aBool )
	{
		this.js.bodyUsed = aBool.js;
		return this;
	}

	$cache()
	{
		return stString$class.$fromJs$( this.js.cache );
	}

	$credentials()
	{
		return stString$class.$fromJs$( this.js.credentials );
	}

	$destination()
	{
		return stString$class.$fromJs$( this.js.destination );
	}

	$headers()
	{
		return stHeaders$class.$fromJs$( this.js.headers );
	}

	$integrity()
	{
		return stString$class.$fromJs$( this.js.integrity );
	}

	$method()
	{
		return stString$class.$fromJs$( this.js.method );
	}

	$mode()
	{
		return stString$class.$fromJs$( this.js.mode );
	}

	$redirect()
	{
		return stString$class.$fromJs$( this.js.redirect );
	}

	$referrer()
	{
		return stString$class.$fromJs$( this.js.referrer );
	}

	$referrerPolicy()
	{
		return stString$class.$fromJs$( this.js.referrerPolicy );
	}

	$signal()
	{
		return stAbortSignal$class.$fromJs$( this.js.signal );
	}

	$url()
	{
		return stString$class.$fromJs$( this.js.url );
	}

	$arrayBufferThen$( block )
	{
		this.js.arrayBuffer().then( buffer =>
		block.$value$( stArrayBuffer$class.$fromJs$( buffer ) ) );
		return this;
	}

	$blobThen$( block )
	{
		this.js.blob().then( blob =>
		block.$value$( stBlob$class.$fromJs$( blob ) ) );
		return this;
	}

	$clone()
	{
		stRequest$class.$fromJs$( this.js.clone() );
		return this;
	}

	$formDataThen$( block )
	{
		this.js.formData().then( formData =>
		block.$value$( stFormData$class.$fromJs$( formData ) ) );
		return this;
	}

	$jsonThen$( block )
	{
		this.js.json().then( object =>
		block.$value$( stObject$class.$fromJs$( object ) ) );
		return this;
	}

	$textThen$( block )
	{
		this.js.text().then( string =>
		block.$value$( stString$class.$fromJs$( string ) ) );
		return this;
	}

}

export class StRequestOptions extends StJsObject
{
	$class()
	{
		return stRequestOptions$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$method()
	{
		return stString$class.$fromJs$( this.js.method );
	}

	$method$( method )
	{
		this.js.method = method.js;
		return this;
	}

	$headers()
	{
		return stHeaders$class.$fromJs$( this.js.headers );
	}

	$headers$( headers )
	{
		this.js.headers = headers.js;
		return this;
	}

	$body()
	{
		return stArrayBuffer$class.$fromJs$( this.js.body );
	}

	$body$( body )
	{
		this.js.body = body.js;
		return this;
	}

	$mode()
	{
		return stString$class.$fromJs$( this.js.mode );
	}

	$mode$( mode )
	{
		this.js.mode = mode.js;
		return this;
	}

	$credentials()
	{
		return stString$class.$fromJs$( this.js.credentials );
	}

	$credentials$( credentials )
	{
		this.js.credentials = credentials.js;
		return this;
	}

	$cache()
	{
		return stString$class.$fromJs$( this.js.cache );
	}

	$cache$( cache )
	{
		this.js.cache = cache.js;
		return this;
	}

	$redirect()
	{
		return stString$class.$fromJs$( this.js.redirect );
	}

	$redirect$( redirect )
	{
		this.js.redirect = redirect.js;
		return this;
	}

	$referrer()
	{
		return stString$class.$fromJs$( this.js.referrer );
	}

	$referrer$( referrer )
	{
		this.js.referrer = referrer.js;
		return this;
	}

	$referrerPolicy()
	{
		return stString$class.$fromJs$( this.js.referrerPolicy );
	}

	$referrerPolicy$( referrerPolicy )
	{
		this.js.referrerPolicy = referrerPolicy.js;
		return this;
	}

	$integrity()
	{
		return stString$class.$fromJs$( this.js.integrity );
	}

	$integrity$( integrity )
	{
		this.js.integrity = integrity.js;
		return this;
	}

	$keepalive()
	{
		return stBoolean$class.$fromJs$( this.js.keepalive );
	}

	$keepalive$( keepalive )
	{
		this.js.keepalive = keepalive.js;
		return this;
	}

	$signal()
	{
		return stAbortSignal$class.$fromJs$( this.js.signal );
	}

	$signal$( signal )
	{
		this.js.signal = signal.js;
		return this;
	}

	$priority()
	{
		return stString$class.$fromJs$( this.js.priority );
	}

	$priority$( priority )
	{
		this.js.priority = priority.js;
		return this;
	}

}

export class StResponse extends StJsObject
{
	$class()
	{
		return stResponse$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$body()
	{
		return stReadableStream$class.$fromJs$( this.js.body );
	}

	$bodyUsed()
	{
		return stBoolean$class.$fromJs$( this.js.bodyUsed );
	}

	$bodyUsed$( aBool )
	{
		this.js.bodyUsed = aBool.js;
		return this;
	}

	$headers()
	{
		return stHeaders$class.$fromJs$( this.js.headers );
	}

	$ok()
	{
		return stBoolean$class.$fromJs$( this.js.ok );
	}

	$redirected()
	{
		return stBoolean$class.$fromJs$( this.js.redirected );
	}

	$status()
	{
		return stInteger$class.$fromJs$( this.js.status );
	}

	$statusText()
	{
		return stString$class.$fromJs$( this.js.statusText );
	}

	$statusAndText()
	{
		return this.$status().$toString().$$comma( stString$class.$fromJs$( ': ' ) ).$$comma( this.$statusText() );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$url()
	{
		return stString$class.$fromJs$( this.js.url );
	}

	$arrayBufferThen$( block )
	{
		this.js.arrayBuffer().then( buffer =>
		block.$value$( stArrayBuffer$class.$fromJs$( buffer ) ) );
		return this;
	}

	$blobThen$( block )
	{
		this.js.blob().then( blob =>
		block.$value$( stBlob$class.$fromJs$( blob ) ) );
		return this;
	}

	$clone()
	{
		stResponse$class.$fromJs$( this.js.clone() );
		return this;
	}

	$formDataThen$( block )
	{
		this.js.formData().then( formData =>
		block.$value$( stFormData$class.$fromJs$( buffer ) ) );
		return this;
	}

	$jsonThen$( block )
	{
		this.js.json().then( object =>
		block.$value$( stObject$class.$fromJs$( object ) ) );
		return this;
	}

	$textThen$( block )
	{
		this.js.text().then( string =>
		block.$value$( stString$class.$fromJs$( string ) ) );
		return this;
	}

	$cookie()
	{
		return stString$class.$fromJs$( this.js.headers.get( "set-cookie" ) );
	}

}

export class StMagnitude extends StJsObject
{
	$class()
	{
		return stMagnitude$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$$gt( magnitude )
	{
		return this.$$lt$equeals( magnitude ).$not();
	}

	$$gt$equeals( magnitude )
	{
		return this.$$lt( magnitude ).$not();
	}

	$compare$( magnitude )
	{
		return this.$$lt( magnitude ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return stInteger$class.$fromJs$( -1 );
			} ), stBlock$class.$fromJs$( (  ) => {
				return this.$$gt( magnitude ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return stInteger$class.$fromJs$( 1 );
			} ), stBlock$class.$fromJs$( (  ) => {
				return stInteger$class.$fromJs$( 0 );
			} ) );
			} ) );
	}

	$min$( magnitude )
	{
		return this.$$lt$equeals( magnitude ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return this;
			} ), stBlock$class.$fromJs$( (  ) => {
				return magnitude;
			} ) );
	}

	$max$( magnitude )
	{
		return this.$$gt$equeals( magnitude ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return this;
			} ), stBlock$class.$fromJs$( (  ) => {
				return magnitude;
			} ) );
	}

}

export class StBlob extends StJsObject
{
	$class()
	{
		return stBlob$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$size()
	{
		return stInteger$class.$fromJs$( this.js.size );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$arrayBufferThen$( block )
	{
		return stArrayBuffer$class.$fromJs$( this.js.arrayBuffer()
		.then( ( arrayBuffer ) => block.js( stArrayBuffer$class.$fromJs$( arrayBuffer ) ) ) );
	}

	$slice$to$( from, to )
	{
		return stBlob$class.$fromJs$( this.js.slice( from.js, to.js ) );
	}

	$stream()
	{
		return stReadableStream$class.$fromJs$( this.js.stream() );
	}

	$textThen$( block )
	{
		this.js.text()
		.then( ( string ) => block.js( stString$class.$fromJs$( string ) ) );
		return this;
	}

}

export class StReadableStream extends StJsObject
{
	$class()
	{
		return stReadableStream$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$locked()
	{
		return stBoolean$class.$fromJs$( this.js.locked );
	}

	$cancelThen$( block )
	{
		this.js.cancel().then( block.js );
		return this;
	}

	$getReader()
	{
		return stReadableStreamDefaultReader$class.$fromJs$( this.js.getReader() );
	}

	$pipeThrough$options$( transformStream, options )
	{
		return stReadableStream$class.$fromJs$( this.js.pipeThrough( transformStream.js, options.js ) );
	}

	$pipeTo$options$then$( writeableStream, options, block )
	{
		this.js.pipeTo( writeableStream.js, options.js ).then( block.js );
		return this;
	}

	$tee()
	{
		return stArray$class.$fromJs$elementClass$( this.js.tee(), stReadableStream$class );
	}

}

export class StReadableStreamDefaultReader extends StJsObject
{
	$class()
	{
		return stReadableStreamDefaultReader$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$closedThen$( block )
	{
		return stBoolean$class.$fromJs$( this.js.closed().then( block.js ) );
	}

	$cancelThen$( block )
	{
		this.js.cancel().then( block.js );
		return this;
	}

	$readThen$( block )
	{
		this.js.read().then(
		( { value, done } ) => block.js( stArrayBuffer.$fromJs$( value ), stBoolean$class.$fromJs$( done ) ) );
		return this;
	}

}

export class StReadableStreamDefaultWriter extends StJsObject
{
	$class()
	{
		return stReadableStreamDefaultWriter$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$closedThen$( block )
	{
		this.js.closed.then( block.js );
		return this;
	}

	$desiredSize()
	{
		return stInteger$class.$fromJs$( this.js.desiredSize );
	}

	$readyThen$( block )
	{
		this.js.ready.then( block.js );
		return this;
	}

	$abortThen$( block )
	{
		this.js.abort().then( block.js );
		return this;
	}

	$closeThen$( block )
	{
		this.js.close().then( block.js );
		return this;
	}

	$releaseLock()
	{
		this.js.releaseLock();
		return this;
	}

	$write$then$( chunk, block )
	{
		this.js.write( chunk.js ).then( block.js );
		return this;
	}

}

export class StWritableStream extends StJsObject
{
	$class()
	{
		return stWritableStream$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$locked()
	{
		return stBoolean$class.$fromJs$( this.js.locked );
	}

	$abort()
	{
		return stReadableStreamDefaultReader$class.$fromJs$( this.js.abort() );
	}

	$getWriter()
	{
		return stReadableStreamDefaultWriter$class.$fromJs$( this.js.getWriter() );
	}

}

export class StPoint3d extends StPoint
{
	z = stNil;

	$class()
	{
		return stPoint3d$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$z()
	{
		return this.z;
	}

	$z$( aZ )
	{
		this.z = aZ;
		return this;
	}

	$toString()
	{
		return stString$class.$fromJs$( '( ' ).$$comma( this.x.$toString() ).$$comma( stString$class.$fromJs$( ' @ ' ) ).$$comma( this.y.$toString() ).$$comma( stString$class.$fromJs$( ' @ ' ) ).$$comma( this.z.$toString() ).$$comma( stString$class.$fromJs$( ' )' ) );
	}

	$$equeals( point3d )
	{
		return this.x.$$equeals( point3d.$x() ).$$amp( this.y.$$equeals( point3d.$y() ) ).$$amp( this.z.$$equeals( point3d.$z() ) );
	}

	$$lt( point3d )
	{
		return this.x.$$lt( point3d.$x() ).$$amp( this.y.$$lt( point3d.$y() ) );
		this.z.$$lt( point3d.$z() );
	}

	$$lt$equeals( point3d )
	{
		return this.x.$$lt$equeals( point3d.$x() ).$$amp( this.y.$$lt$equeals( point3d.$y() ) ).$$amp( this.z.$$lt$equeals( point3d.$z() ) );
	}

	$$gt( point3d )
	{
		return this.x.$$gt( point3d.$x() ).$$amp( this.y.$$gt( point3d.$y() ) ).$$amp( this.z.$$gt( point3d.$z() ) );
	}

	$$gt$equeals( point3d )
	{
		return this.x.$$gt$equeals( point3d.$x() ).$$amp( this.y.$$gt$equeals( point3d.$y() ) ).$$amp( this.z.$$gt$equeals( point3d.$z() ) );
	}

	$$plus( magnitude )
	{
		return magnitude.$addToPoint3d$( this );
	}

	$$minus( magnitude )
	{
		return magnitude.$subtractFromPoint3d$( this );
	}

	$$ast( magnitude )
	{
		return magnitude.$multiplyByPoint3d$( this );
	}

	$$sol( magnitude )
	{
		return magnitude.$divideIntoPoint3d$( this );
	}

	$$sol$sol( magnitude )
	{
		return magnitude.$integerDivideIntoPoint3d$( this );
	}

	$$percnt( magnitude )
	{
		return magnitude.$moduloFromPoint3d$( this );
	}

	$addToInteger$( integer )
	{
		return stPoint3d$class.$x$y$z$( integer.$$plus( this.x ), integer.$$plus( this.y ), integer.$$plus( this.z ) );
	}

	$subtractFromInteger$( integer )
	{
		return stPoint3d$class.$x$y$z$( integer.$$minus( this.x ), integer.$$minus( this.y ), integer.$$minus( this.z ) );
	}

	$multiplyByInteger$( integer )
	{
		return stPoint3d$class.$x$y$z$( integer.$$ast( this.x ), integer.$$ast( this.y ), integer.$$ast( this.z ) );
	}

	$divideIntoInteger$( integer )
	{
		return stPoint3d$class.$x$y$z$( integer.$$sol( this.x ), integer.$$sol( this.y ), integer.$$sol( this.z ) );
	}

	$integerDivideIntoInteger$( integer )
	{
		return stPoint3d$class.$x$y$z$( integer.$$sol$sol( this.x ), integer.$$sol$sol( this.y ), integer.$$sol$sol( this.z ) );
	}

	$moduloFromInteger$( integer )
	{
		return stPoint3d$class.$x$y$z$( integer.$$percnt( this.x ), integer.$$percnt( this.y ), integer.$$percnt( this.z ) );
	}

	$addToBigInt$( bigInt )
	{
		return stPoint3d$class.$x$y$z$( bigInt.$$plus( this.x ), bigInt.$$plus( this.y ), bigInt.$$plus( this.z ) );
	}

	$subtractFromBigInt$( bigInt )
	{
		return stPoint3d$class.$x$y$z$( bigInt.$$minus( this.x ), bigInt.$$minus( this.y ), bigInt.$$minus( this.z ) );
	}

	$multiplyByBigInt$( bigInt )
	{
		return stPoint3d$class.$x$y$z$( bigInt.$$ast( this.x ), bigInt.$$ast( this.y ), bigInt.$$ast( this.z ) );
	}

	$divideIntoBigInt$( bigInt )
	{
		return stPoint3d$class.$x$y$z$( bigInt.$$sol( this.x ), bigInt.$$sol( this.y ), bigInt.$$sol( this.z ) );
	}

	$integerDivideIntoBigInt$( bigInt )
	{
		return stPoint3d$class.$x$y$z$( bigInt.$$sol$sol( this.x ), bigInt.$$sol$sol( this.y ), bigInt.$$sol$sol( this.z ) );
	}

	$moduloFromBigInt$( bigInt )
	{
		return stPoint3d$class.$x$y$z$( bigInt.$$percnt( this.x ), bigInt.$$percnt( this.y ), bigInt.$$percnt( this.z ) );
	}

	$addToFraction$( fraction )
	{
		return stPoint3d$class.$x$y$z$( fraction.$$plus( this.x ), fraction.$$plus( this.y ), fraction.$$plus( this.z ) );
	}

	$subtractFromFraction$( fraction )
	{
		return stPoint3d$class.$x$y$z$( fraction.$$minus( this.x ), fraction.$$minus( this.y ), fraction.$$minus( this.z ) );
	}

	$multiplyByFraction$( fraction )
	{
		return stPoint3d$class.$x$y$z$( fraction.$$ast( this.x ), fraction.$$ast( this.y ), fraction.$$ast( this.z ) );
	}

	$divideIntoFraction$( fraction )
	{
		return stPoint3d$class.$x$y$z$( fraction.$$sol( this.x ), fraction.$$sol( this.y ), fraction.$$sol( this.z ) );
	}

	$integerDivideIntoFraction$( fraction )
	{
		return stPoint3d$class.$x$y$z$( fraction.$$sol$sol( this.x ), fraction.$$sol$sol( this.y ), fraction.$$sol$sol( this.z ) );
	}

	$moduloFromFraction$( fraction )
	{
		return stPoint3d$class.$x$y$z$( fraction.$$percnt( this.x ), fraction.$$percnt( this.y ), fraction.$$percnt( this.z ) );
	}

	$addToFloat$( float )
	{
		return stPoint3d$class.$x$y$z$( float.$$plus( this.x ), float.$$plus( this.y ), float.$$plus( this.z ) );
	}

	$subtractFromFloat$( float )
	{
		return stPoint3d$class.$x$y$z$( float.$$minus( this.x ), float.$$minus( this.y ), float.$$minus( this.z ) );
	}

	$multiplyByFloat$( float )
	{
		return stPoint3d$class.$x$y$z$( float.$$ast( this.x ), float.$$ast( this.y ), float.$$ast( this.z ) );
	}

	$divideIntoFloat$( float )
	{
		return stPoint3d$class.$x$y$z$( float.$$sol( this.x ), float.$$sol( this.y ), float.$$sol( this.z ) );
	}

	$integerDivideIntoFloat$( float )
	{
		return stPoint3d$class.$x$y$z$( float.$$sol$sol( this.x ), float.$$sol$sol( this.y ), float.$$sol$sol( this.z ) );
	}

	$moduloFromFloat$( float )
	{
		return stPoint3d$class.$x$y$z$( float.$$percnt( this.x ), float.$$percnt( this.y ), float.$$percnt( this.z ) );
	}

	$addToPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$plus( this.x ), point3d.$y().$$plus( this.y ), point3d.$z().$$plus( this.z ) );
	}

	$subtractFromPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$minus( this.x ), point3d.$y().$$minus( this.y ), point3d.$z().$$minus( this.z ) );
	}

	$multiplyByPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$ast( this.x ), point3d.$y().$$ast( this.y ), point3d.$z().$$ast( this.z ) );
	}

	$divideIntoPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$sol( this.x ), point3d.$y().$$sol( this.y ), point3d.$z().$$sol( this.z ) );
	}

	$integerDivideIntoPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$sol$sol( this.x ), point3d.$y().$$sol$sol( this.y ), point3d.$z().$$sol$sol( this.z ) );
	}

	$moduloFromPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$percnt( this.x ), point3d.$y().$$percnt( this.y ), point3d.$z().$$percnt( this.z ) );
	}

	$negated()
	{
		return stPoint3d$class.$x$y$z$( this.x.$negated(), this.y.$negated(), this.z.$negated() );
	}

	$abs()
	{
		return stPoint3d$class.$x$y$z$( this.x.$abs(), this.y.$abs(), this.z.$abs() );
	}

	$dotProduct$( point3d )
	{
		return this.x.$$ast( point3d.$x() ).$$plus( this.y.$$ast( point3d.$y() ) ).$$plus( this.z.$$ast( point3d.$z() ) );
	}

}

export class StAbstractArray extends StCollection
{
	$class()
	{
		return stAbstractArray$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$copy()
	{
		return this.$class().$fromJs$( this.js.slice() );
	}

	$toString()
	{
		return stString$class.$fromJs$( '#( ' ).$$comma( this.$join$( stString$class.$fromJs$( ' ' ) ) ).$$comma( stString$class.$fromJs$( ' )' ) );
	}

	$toLocaleString()
	{
		return stString$class.$fromJs$( '#( ' ).$$comma( this.$join$toStringConverter$( stString$class.$fromJs$( ' ' ), stBlock$class.$fromJs$( ( element ) => {
				return element.$toLocaleString();
			} ) ) ).$$comma( stString$class.$fromJs$( ' )' ) );
	}

	$join$( separator )
	{
		return this.$join$toStringConverter$( separator, stBlock$class.$fromJs$( ( element ) => {
				return element.$toString();
			} ) );
	}

	$join$toStringConverter$( separator, block )
	{
		let string = stNil;
		let first = stNil;
		string = stString$class.$fromJs$( '' );
		first = stTrue;
		this.$do$( stBlock$class.$fromJs$( ( element ) => {
				first.$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return first = stFalse;
			} ), stBlock$class.$fromJs$( (  ) => {
				return string = string.$$plus( separator );
			} ) );
				return string = string.$$plus( block.$value$( element ) );
			} ) );
		return string;
	}

	$entries()
	{
		let result = stNil;
		result = stArray$class.$new$( this.$length() );
		stInteger$class.$fromJs$( 0 ).$to$do$( this.$length().$$minus( stInteger$class.$fromJs$( 1 ) ), stBlock$class.$fromJs$( ( index ) => {
				return result.$at$put$( index, stArray$class.$with$with$( index, this.$at$( index ) ) );
			} ) );
		return result;
	}

	$length()
	{
		return stInteger$class.$fromJs$( this.js.length );
	}

	$isEmpty()
	{
		return this.$length().$$equeals( stInteger$class.$fromJs$( 0 ) );
	}

	$first()
	{
		return this.$at$( stInteger$class.$fromJs$( 0 ) );
	}

	$last()
	{
		return this.$at$( this.$length().$$minus( stInteger$class.$fromJs$( 1 ) ) );
	}

	$copyWithin$start$end$( target, start, end )
	{
		this.js.copyWithin( target.js, start.js, end.js );
		return this;
	}

	$fill$start$end$( value, start, end )
	{
		this.js.fill( value.js, start.js, end.js );
		return this;
	}

	$slice$( start )
	{
		return this.$class().$fromJs$( this.js.slice( start.js ) );
	}

	$slice$to$( start, end )
	{
		return this.$class().$fromJs$( this.js.slice( start.js, end.js ) );
	}

	$reverse()
	{
		this.js.reverse();
		return this;
	}

	$swap$with$( index1, index2 )
	{
		let temp = stNil;
		temp = this.$at$( index1 );
		this.$at$put$( index1, this.$at$( index2 ) );
		this.$at$put$( index2, temp );
		return this;
	}

	$subarray$( start )
	{
		return this.$class().$fromJs$( this.js.subarray( start.js ) );
	}

	$subarray$to$( start, end )
	{
		return this.$class().$fromJs$( this.js.subarray( start.js, end.js ) );
	}

}

export class StDictionary extends StCollection
{
	keyValues = stNil;

	$class()
	{
		return stDictionary$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	constructor()
	{
		super();
		this.keyValues = stArray$class.$new();
	}

	$at$ifAbsent$( key, block )
	{
		try {
		this.keyValues.$do$( stBlock$class.$fromJs$( ( keyValue ) => {
				return keyValue.$at$( stInteger$class.$fromJs$( 0 ) ).$$equeals( key ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( keyValue.$at$( stInteger$class.$fromJs$( 1 ) ) );
			} ) );
			} ) );
		return block.$value();
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$at$put$( key, value )
	{
		let keyValue = stNil;
		keyValue = this.$at$ifAbsent$( key, stBlock$class.$fromJs$( (  ) => {
				keyValue = stArray$class.$new$( stInteger$class.$fromJs$( 2 ) );
				this.keyValues.$add$( keyValue );
				return keyValue.$at$put$( stInteger$class.$fromJs$( 0 ), key );
			} ) );
		keyValue.$at$put$( stInteger$class.$fromJs$( 1 ), value );
		return this;
	}

	$removeAt$( key )
	{
		let index = stNil;
		index = this.keyValues.$findIndex$( stBlock$class.$fromJs$( ( keyValue ) => {
				return keyValue.$at$( stInteger$class.$fromJs$( 0 ) ).$$equeals( key );
			} ) );
		index.$$gt$equeals( stInteger$class.$fromJs$( 0 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.keyValues.$removeAt$( index );
			} ) );
		return this;
	}

	$do$( block )
	{
		this.keyValues.$do$( stBlock$class.$fromJs$( ( keyValue ) => {
				return block.$value$value$( keyValue.$at$( stInteger$class.$fromJs$( 0 ) ), keyValue.$at$( stInteger$class.$fromJs$( 1 ) ) );
			} ) );
		return this;
	}

	$size()
	{
		return this.keyValues.$length();
	}

}

export class StMap extends StCollection
{
	$class()
	{
		return stMap$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	constructor()
	{
		super();
		this.js = new Map();
	}

	$size()
	{
		return stInteger$class.$fromJs$( this.js.size );
	}

	$clear()
	{
		this.js.clear();
		return this;
	}

	$delete$( key )
	{
		return stBoolean$class.$fromJs$( this.js.delete( key.js ) );
	}

	$get$( key )
	{
		return this.js.get( key.js );
	}

	$has$( key )
	{
		return stBoolean$class.$fromJs$( this.js.has( key.js ) );
	}

	$set$value$( key, value )
	{
		this.js.set( key.js, value );
		return this;
	}

	$keys()
	{
		return stArray$class.$fromJs$elementClass$( Array.from( this.js.keys() ), stString$class );
	}

	$values()
	{
		return stArray$class.$fromJs$( Array.from( this.js.values() ) );
	}

	$entries()
	{
		return stArray$class.$fromJs$elementConverter$( Array.from( this.js.entries() ), stBlock$class.$fromJs$( ( jsEntry ) => {
				return stArray$class.$with$with$( stString$class.$fromJs$( jsEntry[ 0 ] ), jsEntry[ 1 ] );
			} ) );
	}

	$forEach$( block )
	{
		this.js.forEach( ( value, key ) => block.js( key, value ) );
		return this;
	}

}

export class StUiEvent extends StEvent
{
	$class()
	{
		return stUiEvent$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

}

export class StAbortSignal extends StEventTarget
{
	$class()
	{
		return stAbortSignal$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$aborted()
	{
		return stBoolean$class.$fromJs$( this.js.aborted );
	}

	$reason()
	{
		return stString$class.$fromJs$( this.js.reason );
	}

	$throwIfAborted()
	{
		this.js.throwIfAborted();
		return this;
	}

}

export class StCharacter extends StMagnitude
{
	$class()
	{
		return stCharacter$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$code()
	{
		return stInteger$class.$fromJs$( this.js );
	}

	$toString()
	{
		return stString$class.$fromCharacter$( this );
	}

	$$equeals( character )
	{
		return stBoolean$class.$fromJs$( this.js == character.js );
	}

	$$lt( character )
	{
		return stBoolean$class.$fromJs$( this.js < character.js );
	}

	$$lt$equeals( character )
	{
		return stBoolean$class.$fromJs$( this.js <= character.js );
	}

	$isUppercase()
	{
		return stBoolean$class.$fromJs$( this.js >= 65 && this.js <= 90 );
	}

	$isLowercase()
	{
		return stBoolean$class.$fromJs$( this.js >= 97 && this.js <= 122 );
	}

	$isLetter()
	{
		return this.$isUppercase().$$verbar( this.$isLowercase() );
	}

	$isDigit()
	{
		return stBoolean$class.$fromJs$( this.js >= 48 && this.js <= 57 );
	}

}

export class StDate extends StMagnitude
{
	$class()
	{
		return stDate$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$copy()
	{
		return stDate$class.$fromJs$( new Date( this.js ) );
	}

	$toString()
	{
		return stString$class.$fromJs$( this.js.toString() );
	}

	$toDateString()
	{
		return stString$class.$fromJs$( this.js.toDateString() );
	}

	$toLocaleDateString()
	{
		return stString$class.$fromJs$( this.js.toLocaleDateString() );
	}

	$toTimeString()
	{
		return stString$class.$fromJs$( this.js.toTimeString() );
	}

	$toLocaleTimeString()
	{
		return stString$class.$fromJs$( this.js.toLocaleTimeString() );
	}

	$toIsoString()
	{
		return stString$class.$fromJs$( this.js.toISOString() );
	}

	$toUtcString()
	{
		return stString$class.$fromJs$( this.js.toUTCString() );
	}

	$toJson()
	{
		return stString$class.$fromJs$( this.js.toJSON() );
	}

	$toMilliseconds()
	{
		return stInteger$class.$fromJs$( this.js.getTime() );
	}

	$year()
	{
		return stInteger$class.$fromJs$( this.js.getFullYear() );
	}

	$year$( year )
	{
		this.js.setFullYear( year.js );
		return this;
	}

	$month()
	{
		return stInteger$class.$fromJs$( this.js.getMonth() + 1 );
	}

	$month$( month )
	{
		this.js.setMonth( month.js - 1 );
		return this;
	}

	$day()
	{
		return stInteger$class.$fromJs$( this.js.getDate() );
	}

	$day$( day )
	{
		this.js.setDate( day.js );
		return this;
	}

	$dayOfWeek()
	{
		return stInteger$class.$fromJs$( this.js.getDay() );
	}

	$hours()
	{
		return stInteger$class.$fromJs$( this.js.getHours() );
	}

	$hours$( hours )
	{
		this.js.setHours( hours.js );
		return this;
	}

	$minutes()
	{
		return stInteger$class.$fromJs$( this.js.getMinutes() );
	}

	$minutes$( minutes )
	{
		this.js.setMinutes( minutes.js );
		return this;
	}

	$seconds()
	{
		return stInteger$class.$fromJs$( this.js.getSeconds() );
	}

	$seconds$( seconds )
	{
		this.js.setSeconds( seconds.js );
		return this;
	}

	$milliseconds()
	{
		return stInteger$class.$fromJs$( this.js.getMilliseconds() );
	}

	$milliseconds$( milliseconds )
	{
		this.js.setMilliseconds( milliseconds.js );
		return this;
	}

	$utcYear()
	{
		return stInteger$class.$fromJs$( this.js.getUTCFullYear() );
	}

	$utcMonth()
	{
		return stInteger$class.$fromJs$( this.js.getMonth() );
	}

	$utcDay()
	{
		return stInteger$class.$fromJs$( this.js.getUTCDate() );
	}

	$uctDayOfWeek()
	{
		return stInteger$class.$fromJs$( this.js.getUTCDay() );
	}

	$utcHours()
	{
		return stInteger$class.$fromJs$( this.js.getUTCHours() );
	}

	$utcMinutes()
	{
		return stInteger$class.$fromJs$( this.js.getUTCMinutes() );
	}

	$utcSeconds()
	{
		return stInteger$class.$fromJs$( this.js.getUTCSeconds() );
	}

	$utcMilliseconds()
	{
		return stInteger$class.$fromJs$( this.js.getUTCMilliseconds() );
	}

	$utcYear$( utcYear )
	{
		this.js.setUTCFullYear( utcYear.js );
		return this;
	}

	$utcMonth$( utcMonth )
	{
		this.js.setUTCMonth( utcMonth.js );
		return this;
	}

	$utcDay$( utcDay )
	{
		this.js.setUTCDate( utcDay.js );
		return this;
	}

	$utcHours$( utcHours )
	{
		this.js.setUTCHours( utcHours.js );
		return this;
	}

	$utcMinutes$( utcMinutes )
	{
		this.js.setUTCMinutes( utcMinutes.js );
		return this;
	}

	$utcSeconds$( utcSeconds )
	{
		return this.js.setUTCSeconds( utcSeconds.js );
	}

	$utcMilliseconds$( utcMilliseconds )
	{
		return this.js.setUTCMilliseconds( utcMilliseconds.js );
	}

	$$equeals( date )
	{
		return stBoolean$class.$fromJs$( this.js.valueOf() == date.js.valueOf() );
	}

	$$lt( date )
	{
		return stBoolean$class.$fromJs$( this.js < date.js );
	}

	$$lt$equeals( date )
	{
		return stBoolean$class.$fromJs$( this.js <= date.js );
	}

	$timezoneOffset()
	{
		return stInteger$class.$fromJs$( this.js.getTimezoneOffset() );
	}

	$dstOffset()
	{
		return this.$timezoneOffset().$$minus( stDate$class.$year$month$day$( this.$year(), stInteger$class.$fromJs$( 0 ), stInteger$class.$fromJs$( 1 ) ).$timezoneOffset() );
	}

	$timezoneDstOffset()
	{
		return this.$timezoneOffset().$$plus( this.$dstOffset() );
	}

}

import { NumUtil } from "./Runtime.js";

export class StNumber extends StMagnitude
{
	$class()
	{
		return stNumber$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$$commat( number )
	{
		return stPoint$class.$new().$x$y$( this, number );
	}

	$addToPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$plus( this ), point.$y().$$plus( this ) );
	}

	$subtractFromPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$minus( this ), point.$y().$$minus( this ) );
	}

	$multiplyByPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$ast( this ), point.$y().$$ast( this ) );
	}

	$divideIntoPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$sol( this ), point.$y().$$sol( this ) );
	}

	$integerDivideIntoPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$sol$sol( this ), point.$y().$$sol$sol( this ) );
	}

	$moduloFromPoint$( point )
	{
		return stPoint$class.$x$y$( point.$x().$$percnt( this ), point.$y().$$percnt( this ) );
	}

	$addToPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$plus( this ), point3d.$y().$$plus( this ), point3d.$z().$$plus( this ) );
	}

	$subtractFromPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$minus( this ), point3d.$y().$$minus( this ), point3d.$z().$$minus( this ) );
	}

	$multiplyByPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$ast( this ), point3d.$y().$$ast( this ), point3d.$z().$$ast( this ) );
	}

	$divideIntoPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$sol( this ), point3d.$y().$$sol( this ), point3d.$z().$$sol( this ) );
	}

	$integerDivideIntoPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$sol$sol( this ), point3d.$y().$$sol$sol( this ), point3d.$z().$$sol$sol( this ) );
	}

	$moduloFromPoint3d$( point3d )
	{
		return stPoint3d$class.$x$y$z$( point3d.$x().$$percnt( this ), point3d.$y().$$percnt( this ), point3d.$z().$$percnt( this ) );
	}

	$squared()
	{
		return this.$$ast( this );
	}

	$isSquare()
	{
		try {
		this.$$lt( stInteger$class.$fromJs$( 2 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stFalse );
			} ) );
		return this.$toFloat().$sqrt().$toInteger().$squared().$$equeals( this );
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$sqrt()
	{
		return this.$toFloat().$sqrt();
	}

	$negated()
	{
		return stInteger$class.$fromJs$( 0 ).$$minus( this );
	}

	$abs()
	{
		return this.$$lt( stInteger$class.$fromJs$( 0 ) ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return this.$negated();
			} ), stBlock$class.$fromJs$( (  ) => {
				return this;
			} ) );
	}

	$$bsol$bsol( number )
	{
		return this.$$percnt( number );
	}

	$increment()
	{
		this.js++;
		return this;
	}

	$decrement()
	{
		this.js--;
		return this;
	}

	$divisionByZeroError()
	{
		this.$error$( stString$class.$fromJs$( 'Error: Division by zero of number: ' ).$$comma( this.$toString() ) );
		return this;
	}

}

export class StString extends StMagnitude
{
	$class()
	{
		return stString$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toString()
	{
		return this;
	}

	$toInteger()
	{
		return stInteger$class.$fromJs$( parseInt( this.js ) );
	}

	$toFloat()
	{
		return stFloat$class.$fromJs$( parseFloat( this.js ) );
	}

	$length()
	{
		return stInteger$class.$fromJs$( this.js.length );
	}

	$isEmpty()
	{
		return this.$length().$$equeals( stInteger$class.$fromJs$( 0 ) );
	}

	$at$( index )
	{
		index.$$lt( stInteger$class.$fromJs$( 0 ) ).$$verbar( index.$$gt$equeals( this.$length() ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'String index out of bounds.' ) );
			} ) );
		return stCharacter$class.$fromJs$( this.js.charCodeAt( index.js ) );
	}

	$at$put$( index, character )
	{
		index.$$lt( stInteger$class.$fromJs$( 0 ) ).$$verbar( index.$$gt$equeals( this.$length() ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'String index out of bounds.' ) );
			} ) );
		this.js = this.js.substring( 0, index.js ) + String.fromCharCode( character.js ) + this.js.substring( index.js + 1, this.js.length );
		return this;
	}

	$includes$( string )
	{
		return stBoolean$class.$fromJs$( this.js.includes( string.js ) );
	}

	$includes$from$( string, index )
	{
		return stBoolean$class.$fromJs$( this.js.includes( string.js, index.js ) );
	}

	$startsWith$( string )
	{
		return stBoolean$class.$fromJs$( this.js.startsWith( string.js ) );
	}

	$endsWith$( string )
	{
		return stBoolean$class.$fromJs$( this.js.endsWith( string.js ) );
	}

	$indexOf$( string )
	{
		return stInteger$class.$fromJs$( this.js.indexOf( string.js ) );
	}

	$indexOf$from$( string, index )
	{
		return stInteger$class.$fromJs$( this.js.indexOf( string.js, index.js ) );
	}

	$lastIndexOf$( string )
	{
		return stInteger$class.$fromJs$( this.js.lastIndexOf( string.js ) );
	}

	$lastIndexOf$from$( string, index )
	{
		return stInteger$class.$fromJs$( this.js.lastIndexOf( string.js, index.js ) );
	}

	$match$flags$( regexp, flags )
	{
		
		let result = this.js.match( new RegExp( regexp.js, flags.js ) );
		if( result == null )
			return stNil;
		return stArray$class.$fromJs$elementClass$( result, stString$class );
		return this;
	}

	$search$( regexp )
	{
		return stInteger$class.$fromJs$( this.js.search( new RegExp( regexp.js ) ) );
	}

	$$equeals( string )
	{
		return stBoolean$class.$fromJs$( this.js == string.js );
	}

	$$lt( string )
	{
		return stBoolean$class.$fromJs$( this.js < string.js );
	}

	$$lt$equeals( string )
	{
		return stBoolean$class.$fromJs$( this.js <= string.js );
	}

	$$gt( string )
	{
		return stBoolean$class.$fromJs$( this.js > string.js );
	}

	$$gt$equeals( string )
	{
		return stBoolean$class.$fromJs$( this.js >= string.js );
	}

	$localeCompare$( string )
	{
		return stInteger$class.$fromJs$( this.js.localeCompare( string.js ) );
	}

	$$plus( string )
	{
		return stString$class.$fromJs$( this.js + string.js );
	}

	$$comma( string )
	{
		return this.$$plus( string );
	}

	$concat$( string )
	{
		return this.$$plus( string );
	}

	$substring$( start )
	{
		return stString$class.$fromJs$( this.js.substring( start.js ) );
	}

	$substring$to$( start, end )
	{
		return stString$class.$fromJs$( this.js.substring( start.js, end.js ) );
	}

	$slice$( start )
	{
		return stString$class.$fromJs$( this.js.slice( start.js ) );
	}

	$slice$to$( start, end )
	{
		return stString$class.$fromJs$( this.js.slice( start.js, end.js ) );
	}

	$split$( separator )
	{
		return stArray$class.$fromJs$elementClass$( this.js.split( separator.js ), stString$class );
	}

	$padEnd$( length )
	{
		return stString$class.$fromJs$( this.js.padEnd( length.js ) );
	}

	$padEnd$with$( length, string )
	{
		return stString$class.$fromJs$( this.js.padEnd( length.js, string.js ) );
	}

	$padStart$( length )
	{
		return stString$class.$fromJs$( this.js.padStart( length.js ) );
	}

	$padStart$with$( length, string )
	{
		return stString$class.$fromJs$( this.js.padStart( length.js, string.js ) );
	}

	$repeat$( count )
	{
		return stString$class.$fromJs$( this.js.repeat( count.js ) );
	}

	$replace$with$( search, replace )
	{
		return stString$class.$fromJs$( this.js.replace( search.js, replace.js ) );
	}

	$replaceAll$with$( search, replace )
	{
		return stString$class.$fromJs$( this.js.replaceAll( search.js, replace.js ) );
	}

	$trim()
	{
		return stString$class.$fromJs$( this.js.trim() );
	}

	$trimStart()
	{
		return stString$class.$fromJs$( this.js.trimStart() );
	}

	$trimEnd()
	{
		return stString$class.$fromJs$( this.js.trimEnd() );
	}

	$toUpperCase()
	{
		return stString$class.$fromJs$( this.js.toUpperCase() );
	}

	$toLocaleUpperCase()
	{
		return stString$class.$fromJs$( this.js.toLocaleUpperCase() );
	}

	$toLowerCase()
	{
		return stString$class.$fromJs$( this.js.toLowerCase() );
	}

	$toLocaleLowerCase()
	{
		return stString$class.$fromJs$( this.js.toLocaleLowerCase() );
	}

	$do$( block )
	{
		
		for( let $char of this.js ) {
			block.$value$( stCharacter$class.$fromJs$( $char.charCodeAt( 0 ) ) ) };
		return this;
	}

}

export class StFile extends StBlob
{
	$class()
	{
		return stFile$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$lastModified()
	{
		return stInteger$class.$fromJs$( this.js.lastModified );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$webkitRelativePath()
	{
		return stString$class.$fromJs$( this.js.webkitRelativePath );
	}

}

export class StArray extends StAbstractArray
{
	$class()
	{
		return stArray$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toJs()
	{
		
		let array = [];
		for( let element of this.js )
			array.push( element.$toJs() );
		return array;
		return this;
	}

	$$equeals( array )
	{
		try {
		array.$isKindOf$( stArray$class ).$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stFalse );
			} ) );
		this.$length().$$equeals( array.$length() ).$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stFalse );
			} ) );
		stInteger$class.$fromJs$( 0 ).$to$do$( this.$length().$$minus( stInteger$class.$fromJs$( 1 ) ), stBlock$class.$fromJs$( ( index ) => {
				return this.$at$( index ).$$equeals( array.$at$( index ) ).$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stFalse );
			} ) );
			} ) );
		return stTrue;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$at$( index )
	{
		index.$$lt( stInteger$class.$fromJs$( 0 ) ).$$verbar( index.$$gt$equeals( this.$length() ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'Array index out of bounds.' ) );
			} ) );
		return this.js[ index.js ];
	}

	$at$put$( index, value )
	{
		index.$$lt( stInteger$class.$fromJs$( 0 ) ).$$verbar( index.$$gt$equeals( this.$length() ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'Array index out of bounds.' ) );
			} ) );
		this.js[ index.js ] = value;
		return this;
	}

	$$comma( array )
	{
		return this.$concat$( array );
	}

	$concat$( array )
	{
		return this.$class().$fromJs$( this.js.concat( array.js ) );
	}

	$add$( value )
	{
		this.js.push( value );
		return this;
	}

	$pop()
	{
		this.$length().$$equeals( stInteger$class.$fromJs$( 0 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'Pop on empty array.' ) );
			} ) );
		return this.js.pop();
	}

	$find$( block )
	{
		return stNil$class.$fromJs$( this.js.find( ( element ) => block.js( element ).js ) );
	}

	$includes$( findElement )
	{
		return this.$find$( stBlock$class.$fromJs$( ( element ) => {
				return element.$$equeals( findElement );
			} ) ).$notNil();
	}

	$findIndex$( block )
	{
		return stInteger$class.$fromJs$( this.js.findIndex( ( element ) => block.js( element ).js ) );
	}

	$indexOf$( findElement )
	{
		return this.$findIndex$( stBlock$class.$fromJs$( ( element ) => {
				return element.$$equeals( findElement );
			} ) );
	}

	$do$( block )
	{
		this.$forEach$( block );
		return this;
	}

	$forEach$( block )
	{
		this.js.forEach( block.js );
		return this;
	}

	$every$( block )
	{
		return stBoolean$class.$fromJs$( this.js.every( ( element ) => block.js( element ).js ) );
	}

	$some$( block )
	{
		return stBoolean$class.$fromJs$( this.js.some( ( element ) => block.js( element ).js ) );
	}

	$filter$( block )
	{
		return this.$class().$fromJs$( this.js.filter( ( element ) => block.js( element ).js ) );
	}

	$map$( block )
	{
		return this.$class().$fromJs$( this.js.map( block.js ) );
	}

	$reduce$( block )
	{
		return this.js.reduce( block.js );
	}

	$reduce$with$( block, value )
	{
		return this.js.reduce( block.js, value );
	}

	$reduceRight$( block )
	{
		return this.js.reduceRight( block.js );
	}

	$reduceRight$with$( block, value )
	{
		return this.js.reduceRight( block.js, value );
	}

	$shift()
	{
		return this.js.shift();
	}

	$unshift$( element )
	{
		this.js.unshift( element );
		return this;
	}

	$splice$( start )
	{
		this.js.splice( start.js );
		return this;
	}

	$splice$count$( start, count )
	{
		this.js.splice( start.js, count.js );
		return this;
	}

	$removeAt$( index )
	{
		this.$splice$count$( index, stInteger$class.$fromJs$( 1 ) );
		return this;
	}

	$sort()
	{
		this.$sortWith$( stBlock$class.$fromJs$( ( a, b ) => {
				return a.$compare$( b );
			} ) );
		return this;
	}

	$sortWith$( compareBlock )
	{
		let jsCompareBlock = stNil;
		jsCompareBlock = stBlock$class.$fromJs$( ( a, b ) => {
				return compareBlock.$value$value$( a, b ).$js();
			} );
		this.js.sort( jsCompareBlock.js );
		return this;
	}

}

export class StTypedArray extends StAbstractArray
{
	$class()
	{
		return stTypedArray$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toArray()
	{
		return stArray$class.$fromJs$elementClass$( Array.from( this.js ), this.$elementClass() );
	}

	$elementClass()
	{
		return this.$class().$elementClass();
	}

	$buffer()
	{
		return stArrayBuffer$class.$fromJs$( this.js.buffer );
	}

	$byteLength()
	{
		return stInteger$class.$fromJs$( this.js.byteLength );
	}

	$byteOffset()
	{
		return stInteger$class.$fromJs$( this.js.byteOffset );
	}

	$at$( index )
	{
		index.$$lt( stInteger$class.$fromJs$( 0 ) ).$$verbar( index.$$gt$equeals( this.$length() ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'Array index out of bounds.' ) );
			} ) );
		return this.$elementClass().$fromJs$( this.js.at( index.js ) );
	}

	$at$put$( index, value )
	{
		index.$$lt( stInteger$class.$fromJs$( 0 ) ).$$verbar( index.$$gt$equeals( this.$length() ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'Array index out of bounds.' ) );
			} ) );
		this.js[ index.js ] = value.js;
		return this;
	}

	$set$offset$( typedArray, offset )
	{
		this.js.set( typedArray.js, offset.js );
		return this;
	}

	$find$( block )
	{
		return this.$elementClass().$fromJs$( this.js.find( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js ) );
	}

	$findLast$( block )
	{
		return this.$elementClass().$fromJs$( this.js.findLast( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js ) );
	}

	$includes$( element )
	{
		return stBoolean$class.$fromJs$( this.js.includes( element.js ) );
	}

	$findIndex$( block )
	{
		return stInteger$class.$fromJs$( this.js.findIndex( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js ) );
	}

	$findLastIndex$( block )
	{
		return stInteger$class.$fromJs$( this.js.findLastIndex( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js ) );
	}

	$indexOf$( element )
	{
		return stInteger$class.$fromJs$( this.js.indexOf( element.js ) );
	}

	$lastIndexOf$( element )
	{
		return stInteger$class.$fromJs$( this.js.lastIndexOf( element.js ) );
	}

	$do$( block )
	{
		this.$forEach$( block );
		return this;
	}

	$forEach$( block )
	{
		this.js.forEach( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ) );
		return this;
	}

	$every$( block )
	{
		return stBoolean$class.$fromJs$( this.js.every( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js ) );
	}

	$some$( block )
	{
		return stBoolean$class.$fromJs$( this.js.some( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js ) );
	}

	$filter$( block )
	{
		return this.$class().$fromJs$( this.js.filter( ( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js ) );
	}

	$map$( block )
	{
		return this.$class().$fromJs$( this.js.map(
		( element ) => block.js( this.$elementClass().$fromJs$( element ) ).js ) );
	}

	$reduce$( block )
	{
		return this.$elementClass().$fromJs$( this.js.reduce(
		( element1, element2 ) => block.js( this.$elementClass().$fromJs$( element1 ), this.$elementClass().$fromJs$( element2 ) ).js ) );
	}

	$reduce$with$( block, value )
	{
		return this.$elementClass().$fromJs$( this.js.reduce(
		( element1, element2 ) => block.js( this.$elementClass().$fromJs$( element1 ), this.$elementClass().$fromJs$( element2 ) ).js,
		value.js ) );
	}

	$reduceRight$( block )
	{
		return this.$elementClass().$fromJs$( this.js.reduceRight(
		( element1, element2 ) => block.js( this.$elementClass().$fromJs$( element1 ), this.$elementClass().$fromJs$( element2 ) ).js ) );
	}

	$reduceRight$with$( block, value )
	{
		return this.$elementClass().$fromJs$( this.js.reduceRight(
		( element1, element2 ) => block.js( this.$elementClass().$fromJs$( element1 ), this.$elementClass().$fromJs$( element2 ) ).js,
		value.js ) );
	}

}

export class StMouseEvent extends StUiEvent
{
	$class()
	{
		return stMouseEvent$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

}

export class StAbstractInteger extends StNumber
{
	$class()
	{
		return stAbstractInteger$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toInteger()
	{
		return this;
	}

	$argIsEqualToFraction$( fraction )
	{
		return fraction.$numerator().$$equeals( this.$$ast( fraction.$denominator() ) );
	}

	$argIsSmallerThanFraction$( fraction )
	{
		return fraction.$numerator().$$lt( this.$$ast( fraction.$denominator() ) );
	}

	$argIsSmallerOrEqualToFraction$( fraction )
	{
		return fraction.$numerator().$$lt$equeals( this.$$ast( fraction.$denominator() ) );
	}

	$addToFraction$( fraction )
	{
		return stFraction$class.$numerator$denominator$( fraction.$numerator().$$plus( this.$$ast( fraction.$denominator() ) ), fraction.$denominator() );
	}

	$subtractFromFraction$( fraction )
	{
		return stFraction$class.$numerator$denominator$( fraction.$numerator().$$minus( this.$$ast( fraction.$denominator() ) ), fraction.$denominator() );
	}

	$multiplyByFraction$( fraction )
	{
		return stFraction$class.$numerator$denominator$( fraction.$numerator().$$ast( this ), fraction.$denominator() );
	}

	$divideIntoFraction$( fraction )
	{
		return stFraction$class.$numerator$denominator$( fraction.$numerator(), fraction.$denominator().$$ast( this ) );
	}

	$integerDivideIntoFraction$( fraction )
	{
		return fraction.$numerator().$$sol$sol( fraction.$denominator().$$ast( this ) );
	}

	$moduloFromFraction$( fraction )
	{
		return fraction.$numerator().$$percnt( this.$$ast( fraction.$denominator() ) ).$$sol( fraction.$denominator() );
	}

	$to$do$( max, block )
	{
		let index = stNil;
		index = this;
		stBlock$class.$fromJs$( (  ) => {
				return index.$$lt$equeals( max );
			} ).$whileTrue$( stBlock$class.$fromJs$( (  ) => {
				block.$value$( index );
				return index = index.$$plus( stInteger$class.$fromJs$( 1 ) );
			} ) );
		return this;
	}

	$to$by$do$( limit, by, block )
	{
		let index = stNil;
		by.$$equeals( stInteger$class.$fromJs$( 0 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'to:by:do: By is 0.' ) );
			} ) );
		index = this;
		stBlock$class.$fromJs$( (  ) => {
				return by.$$gt( stInteger$class.$fromJs$( 0 ) ).$$amp( index.$$lt$equeals( limit ) ).$$verbar( by.$$lt( stInteger$class.$fromJs$( 0 ) ).$$amp( index.$$gt$equeals( limit ) ) );
			} ).$whileTrue$( stBlock$class.$fromJs$( (  ) => {
				block.$value$( index );
				return index = index.$$plus( by );
			} ) );
		return this;
	}

	$timesRepeat$( block )
	{
		let count = stNil;
		count = this;
		stBlock$class.$fromJs$( (  ) => {
				return count.$$gt( stInteger$class.$fromJs$( 0 ) );
			} ).$whileTrue$( stBlock$class.$fromJs$( (  ) => {
				block.$value();
				return count = count.$$minus( stInteger$class.$fromJs$( 1 ) );
			} ) );
		return this;
	}

	$even()
	{
		return this.$$percnt( stInteger$class.$fromJs$( 2 ) ).$$equeals( stInteger$class.$fromJs$( 0 ) );
	}

	$odd()
	{
		return this.$$percnt( stInteger$class.$fromJs$( 2 ) ).$$tilde$equeals( stInteger$class.$fromJs$( 0 ) );
	}

	$factorial()
	{
		let fac = stNil;
		this.$$lt( stInteger$class.$fromJs$( 0 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'Negative factorial.' ) );
			} ) );
		fac = stInteger$class.$fromJs$( 1 );
		stInteger$class.$fromJs$( 1 ).$to$do$( this, stBlock$class.$fromJs$( ( num ) => {
				return fac = fac.$$ast( num );
			} ) );
		return fac;
	}

	$isPrime()
	{
		let divider = stNil;
		try {
		this.$$lt$equeals( stInteger$class.$fromJs$( 3 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( this.$$gt( stInteger$class.$fromJs$( 1 ) ) );
			} ) );
		this.$even().$or$( stBlock$class.$fromJs$( (  ) => {
				return this.$$bsol$bsol( stInteger$class.$fromJs$( 3 ) ).$$equeals( stInteger$class.$fromJs$( 0 ) );
			} ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stFalse );
			} ) );
		divider = stInteger$class.$fromJs$( 5 );
		stBlock$class.$fromJs$( (  ) => {
				return divider.$$ast( divider ).$$lt$equeals( this );
			} ).$whileTrue$( stBlock$class.$fromJs$( (  ) => {
				this.$$bsol$bsol( divider ).$$equeals( stInteger$class.$fromJs$( 0 ) ).$or$( stBlock$class.$fromJs$( (  ) => {
				return this.$$bsol$bsol( divider.$$plus( stInteger$class.$fromJs$( 2 ) ) ).$$equeals( stInteger$class.$fromJs$( 0 ) );
			} ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stFalse );
			} ) );
				return divider = divider.$$plus( stInteger$class.$fromJs$( 6 ) );
			} ) );
		return stTrue;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$factors()
	{
		let factors = stNil;
		let remainder = stNil;
		let divider = stNil;
		factors = stArray$class.$new();
		remainder = this;
		stBlock$class.$fromJs$( (  ) => {
				return remainder.$$gt( stInteger$class.$fromJs$( 1 ) );
			} ).$whileTrue$( stBlock$class.$fromJs$( (  ) => {
				divider = remainder.$firstDivider();
				factors.$add$( divider );
				return remainder = remainder.$$sol$sol( divider );
			} ) );
		return factors;
	}

	$firstDivider()
	{
		let maxDivider = stNil;
		let positiveReceiver = stNil;
		try {
		positiveReceiver = this.$abs();
		maxDivider = positiveReceiver.$sqrt().$toInteger().$$plus( stInteger$class.$fromJs$( 1 ) );
		stInteger$class.$fromJs$( 2 ).$to$do$( maxDivider, stBlock$class.$fromJs$( ( divider ) => {
				return positiveReceiver.$$bsol$bsol( divider ).$$equeals( stInteger$class.$fromJs$( 0 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( divider );
			} ) );
			} ) );
		return positiveReceiver;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

}

export class StFloat extends StNumber
{
	$class()
	{
		return stFloat$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toString()
	{
		return stString$class.$fromJs$( this.js.toString() );
	}

	$toInteger()
	{
		if( Number.isSafeInteger( Math.floor( this.js ) ) )
			return stInteger$class.$fromJs$( this.js );
		return stBigInt$class.$fromJs$( BigInt( this.js ) );
		return this;
	}

	$toFixed$( decimals )
	{
		return stString$class.$fromJs$( this.js.toFixed( decimals.js ) );
	}

	$isSafeInteger()
	{
		return stBoolean$class.$fromJs$( Number.isSafeInteger( this.js ) );
	}

	$$equeals( number )
	{
		return number.$argIsEqualToFloat$( this );
	}

	$$lt( number )
	{
		return number.$argIsSmallerThanFloat$( this );
	}

	$$lt$equeals( number )
	{
		return number.$argIsSmallerOrEqualToFloat$( this );
	}

	$equals$precision$( float, precision )
	{
		return stBoolean$class.$fromJs$( Math.abs( this.js - float.js ) < precision.js );
	}

	$argIsEqualToInteger$( integer )
	{
		return stBoolean$class.$fromJs$( Math.abs( integer.js - this.js ) < Number.EPSILON );
	}

	$argIsSmallerThanInteger$( integer )
	{
		return stBoolean$class.$fromJs$( integer.js < this.js );
	}

	$argIsSmallerOrEqualToInteger$( integer )
	{
		return stBoolean$class.$fromJs$( integer.js <= this.js );
	}

	$argIsEqualToBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( Math.abs( Number( bigInt.js ) - this.js ) < Number.EPSILON );
	}

	$argIsSmallerThanBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( Number( bigInt.js ) < this.js );
	}

	$argIsSmallerOrEqualToBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( Number( bigInt.js ) <= this.js );
	}

	$argIsEqualToFraction$( fraction )
	{
		return fraction.$toFloat().$$equeals( this );
	}

	$argIsSmallerThanFraction$( fraction )
	{
		return fraction.$toFloat().$$lt( this );
	}

	$argIsSmallerOrEqualToFraction$( fraction )
	{
		return fraction.$toFloat().$$lt$equeals( this );
	}

	$argIsEqualToFloat$( float )
	{
		return stBoolean$class.$fromJs$( Math.abs( float.js - this.js ) < Number.EPSILON );
	}

	$argIsSmallerThanFloat$( float )
	{
		return stBoolean$class.$fromJs$( float.js < this.js );
	}

	$argIsSmallerOrEqualToFloat$( float )
	{
		return stBoolean$class.$fromJs$( float.js <= this.js );
	}

	$$plus( number )
	{
		return number.$addToFloat$( this );
	}

	$$minus( number )
	{
		return number.$subtractFromFloat$( this );
	}

	$$ast( number )
	{
		return number.$multiplyByFloat$( this );
	}

	$$sol( number )
	{
		return number.$divideIntoFloat$( this );
	}

	$$sol$sol( number )
	{
		return number.$integerDivideIntoFloat$( this );
	}

	$$percnt( number )
	{
		return number.$moduloFromFloat$( this );
	}

	$addToInteger$( integer )
	{
		return stFloat$class.$fromJs$( integer.js + this.js );
	}

	$subtractFromInteger$( integer )
	{
		return stFloat$class.$fromJs$( integer.js - this.js );
	}

	$multiplyByInteger$( integer )
	{
		return stFloat$class.$fromJs$( integer.js * this.js );
	}

	$divideIntoInteger$( integer )
	{
		return stFloat$class.$fromJs$( integer.js / this.js );
	}

	$integerDivideIntoInteger$( integer )
	{
		return stFloat$class.$fromJs$( Math.trunc( integer.js / this.js ) );
	}

	$moduloFromInteger$( integer )
	{
		return stFloat$class.$fromJs$( integer.js % this.js );
	}

	$addToBigInt$( bigInt )
	{
		return stFloat$class.$fromJs$( Number( bigInt.js ) + this.js );
	}

	$subtractFromBigInt$( bigInt )
	{
		return stFloat$class.$fromJs$( Number( bigInt.js ) - this.js );
	}

	$multiplyByBigInt$( bigInt )
	{
		return stFloat$class.$fromJs$( Number( bigInt.js ) * this.js );
	}

	$divideIntoBigInt$( bigInt )
	{
		return stFloat$class.$fromJs$( Number( bigInt.js ) / this.js );
	}

	$integerDivideIntoBigInt$( bigInt )
	{
		return stFloat$class.$fromJs$( Math.trunc( Number( bigInt.js ) / this.js ) );
	}

	$moduloFromBigInt$( bigInt )
	{
		return stFloat$class.$fromJs$( Number( bigInt.js ) % this.js );
	}

	$addToFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js + this.js );
	}

	$subtractFromFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js - this.js );
	}

	$multiplyByFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js * this.js );
	}

	$divideIntoFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js / this.js );
	}

	$integerDivideIntoFloat$( float )
	{
		return stFloat$class.$fromJs$( Math.trunc( float.js / this.js ) );
	}

	$moduloFromFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js % this.js );
	}

	$sqrt()
	{
		return stFloat$class.$fromJs$( Math.sqrt( this.js ) );
	}

	$ln()
	{
		return stFloat$class.$fromJs$( Math.log( this.js ) );
	}

	$log()
	{
		return stFloat$class.$fromJs$( Math.log( this.js ) / Math.log( 10 ) );
	}

	$exp()
	{
		return stFloat$class.$fromJs$( Math.exp( this.js ) );
	}

	$$ast$ast( power )
	{
		return stFloat$class.$fromJs$( Math.pow( this.js, power.js ) );
	}

	$sin()
	{
		return stFloat$class.$fromJs$( Math.sin( this.js ) );
	}

	$cos()
	{
		return stFloat$class.$fromJs$( Math.cos( this.js ) );
	}

	$tan()
	{
		return stFloat$class.$fromJs$( Math.tan( this.js ) );
	}

}

export class StFraction extends StNumber
{
	numerator = stNil;
	denominator = stNil;

	$class()
	{
		return stFraction$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$numerator()
	{
		return this.numerator;
	}

	$denominator()
	{
		return this.denominator;
	}

	$numerator$denominator$( aNumerator, aDenominator )
	{
		this.numerator = aNumerator;
		this.denominator = aDenominator;
		return this.$normalize();
	}

	$normalize()
	{
		let gcd = stNil;
		try {
		this.denominator.$$equeals( stInteger$class.$fromJs$( 0 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$divisionByZeroError();
			} ) );
		gcd = this.numerator.$gcd$( this.denominator );
		gcd.$$gt( stInteger$class.$fromJs$( 1 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				this.numerator = this.numerator.$$sol$sol( gcd );
				return this.denominator = this.denominator.$$sol$sol( gcd );
			} ) );
		this.denominator.$$lt( stInteger$class.$fromJs$( 0 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				this.denominator = this.denominator.$negated();
				return this.numerator = this.numerator.$negated();
			} ) );
		this.denominator.$$equeals( stInteger$class.$fromJs$( 1 ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( this.numerator );
			} ) );
		return this;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$toString()
	{
		return stString$class.$fromJs$( '( ' ).$$comma( this.numerator.$toString() ).$$comma( stString$class.$fromJs$( ' / ' ) ).$$comma( this.denominator.$toString() ).$$comma( stString$class.$fromJs$( ' )' ) );
	}

	$toFloat()
	{
		return this.numerator.$toFloat().$$sol( this.denominator.$toFloat() );
	}

	$toInteger()
	{
		return this.numerator.$toFloat().$$sol$sol( this.denominator.$toFloat() );
	}

	$$equeals( number )
	{
		return number.$argIsEqualToFraction$( this );
	}

	$$lt( number )
	{
		return number.$argIsSmallerThanFraction$( this );
	}

	$$lt$equeals( number )
	{
		return number.$argIsSmallerOrEqualToFraction$( this );
	}

	$argIsEqualToInteger$( integer )
	{
		return integer.$$ast( this.denominator ).$$equeals( this.numerator );
	}

	$argIsSmallerThanInteger$( integer )
	{
		return integer.$$ast( this.denominator ).$$lt( this.numerator );
	}

	$argIsSmallerOrEqualToInteger$( integer )
	{
		return integer.$$ast( this.denominator ).$$lt$equeals( this.numerator );
	}

	$argIsEqualToBigInt$( bigInt )
	{
		return bigInt.$$ast( this.denominator ).$$equeals( this.numerator );
	}

	$argIsSmallerThanBigInt$( bigInt )
	{
		return bigInt.$$ast( this.denominator ).$$lt( this.numerator );
	}

	$argIsSmallerOrEqualToBigInt$( bigInt )
	{
		return bigInt.$$ast( this.denominator ).$$lt$equeals( this.numerator );
	}

	$argIsEqualToFraction$( fraction )
	{
		return fraction.$numerator().$$ast( fraction.$denominator() ).$$equeals( this.numerator.$$ast( this.denominator ) );
	}

	$argIsSmallerThanFraction$( fraction )
	{
		return fraction.$numerator().$$ast( this.denominator ).$$lt( this.numerator.$$ast( fraction.$denominator() ) );
	}

	$argIsSmallerOrEqualToFraction$( fraction )
	{
		return fraction.$numerator().$$ast( this.denominator ).$$lt$equeals( this.numerator.$$ast( fraction.$denominator() ) );
	}

	$argIsEqualToFloat$( float )
	{
		return float.$$equeals( this.$toFloat() );
	}

	$argIsSmallerThanFloat$( float )
	{
		return float.$$lt( this.$toFloat() );
	}

	$argIsSmallerOrEqualToFloat$( float )
	{
		return float.$$lt$equeals( this.$toFloat() );
	}

	$$plus( number )
	{
		return number.$addToFraction$( this );
	}

	$$minus( number )
	{
		return number.$subtractFromFraction$( this );
	}

	$$ast( number )
	{
		return number.$multiplyByFraction$( this );
	}

	$$sol( number )
	{
		return number.$divideIntoFraction$( this );
	}

	$$sol$sol( number )
	{
		return number.$integerDivideIntoFraction$( this );
	}

	$$percnt( number )
	{
		return number.$moduloFromFraction$( this );
	}

	$addToInteger$( integer )
	{
		return stFraction$class.$numerator$denominator$( integer.$$ast( this.denominator ).$$plus( this.numerator ), this.denominator );
	}

	$subtractFromInteger$( integer )
	{
		return stFraction$class.$numerator$denominator$( integer.$$ast( this.denominator ).$$minus( this.numerator ), this.denominator );
	}

	$multiplyByInteger$( integer )
	{
		return stFraction$class.$numerator$denominator$( integer.$$ast( this.numerator ), this.denominator );
	}

	$divideIntoInteger$( integer )
	{
		return stFraction$class.$numerator$denominator$( integer.$$ast( this.denominator ), this.numerator );
	}

	$integerDivideIntoInteger$( integer )
	{
		return integer.$$ast( this.denominator ).$$sol$sol( this.numerator );
	}

	$moduloFromInteger$( integer )
	{
		return integer.$$ast( this.denominator ).$$percnt( this.numerator ).$$sol( this.denominator );
	}

	$addToBigInt$( bigInt )
	{
		return stFraction$class.$numerator$denominator$( bigInt.$$ast( this.denominator ).$$plus( this.numerator ), this.denominator );
	}

	$subtractFromBigInt$( bigInt )
	{
		return stFraction$class.$numerator$denominator$( bigInt.$$ast( this.denominator ).$$minus( this.numerator ), this.denominator );
	}

	$multiplyByBigInt$( bigInt )
	{
		return stFraction$class.$numerator$denominator$( bigInt.$$ast( this.numerator ), this.denominator );
	}

	$divideIntoBigInt$( bigInt )
	{
		return stFraction$class.$numerator$denominator$( bigInt.$$ast( this.denominator ), this.numerator );
	}

	$integerDivideIntoBigInt$( bigInt )
	{
		return bigInt.$$ast( this.denominator ).$$sol$sol( this.numerator );
	}

	$moduloFromBigInt$( bigInt )
	{
		return bigInt.$$ast( this.denominator ).$$percnt( this.numerator ).$$sol( this.denominator );
	}

	$addToFraction$( fraction )
	{
		return stFraction$class.$numerator$denominator$( fraction.$numerator().$$ast( this.denominator ).$$plus( this.numerator.$$ast( fraction.$denominator() ) ), fraction.$denominator().$$ast( this.denominator ) );
	}

	$subtractFromFraction$( fraction )
	{
		return stFraction$class.$numerator$denominator$( fraction.$numerator().$$ast( this.denominator ).$$minus( this.numerator.$$ast( fraction.$denominator() ) ), fraction.$denominator().$$ast( this.denominator ) );
	}

	$multiplyByFraction$( fraction )
	{
		return stFraction$class.$numerator$denominator$( fraction.$numerator().$$ast( this.numerator ), fraction.$denominator().$$ast( this.denominator ) );
	}

	$divideIntoFraction$( fraction )
	{
		return stFraction$class.$numerator$denominator$( fraction.$numerator().$$ast( this.denominator ), fraction.$denominator().$$ast( this.numerator ) );
	}

	$integerDivideIntoFraction$( fraction )
	{
		return fraction.$numerator().$$ast( this.denominator ).$$sol$sol( fraction.$denominator().$$ast( this.numerator ) );
	}

	$moduloFromFraction$( fraction )
	{
		return fraction.$numerator().$$ast( this.denominator ).$$percnt( this.numerator.$$ast( fraction.$denominator() ) ).$$sol( fraction.$denominator().$$ast( this.denominator ) );
	}

	$addToFloat$( float )
	{
		return float.$$plus( this.$toFloat() );
	}

	$subtractFromFloat$( float )
	{
		return float.$$minus( this.$toFloat() );
	}

	$multiplyByFloat$( float )
	{
		return float.$$ast( this.$toFloat() );
	}

	$divideIntoFloat$( float )
	{
		return float.$$sol( this.$toFloat() );
	}

	$integerDivideIntoFloat$( float )
	{
		return float.$$sol$sol( this.$toFloat() );
	}

	$moduloFromFloat$( float )
	{
		return float.$$percnt( this.$toFloat() );
	}

	$negated()
	{
		return stFraction$class.$numerator$denominator$( this.numerator.$negated(), this.denominator );
	}

}

export class StUint8Array extends StTypedArray
{
	$class()
	{
		return stUint8Array$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

}

export class StPointerEvent extends StMouseEvent
{
	$class()
	{
		return stPointerEvent$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

}

export class StBigInt extends StAbstractInteger
{
	$class()
	{
		return stBigInt$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toString()
	{
		return stString$class.$fromJs$( this.js );
	}

	$toFloat()
	{
		return stFloat$class.$fromJs$( Number( this.js ) );
	}

	$$equeals( number )
	{
		return number.$argIsEqualToBigInt$( this );
	}

	$$lt( number )
	{
		return number.$argIsSmallerThanBigInt$( this );
	}

	$$lt$equeals( number )
	{
		return number.$argIsSmallerOrEqualToBigInt$( this );
	}

	$argIsEqualToInteger$( integer )
	{
		return stBoolean$class.$fromJs$( BigInt( integer.js ) == this.js );
	}

	$argIsSmallerThanInteger$( integer )
	{
		return stBoolean$class.$fromJs$( BigInt( integer.js ) < this.js );
	}

	$argIsSmallerOrEqualToInteger$( integer )
	{
		return stBoolean$class.$fromJs$( BigInt( integer.js ) <= this.js );
	}

	$argIsEqualToBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( bigInt.js == this.js );
	}

	$argIsSmallerThanBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( bigInt.js < this.js );
	}

	$argIsSmallerOrEqualToBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( bigInt.js <= this.js );
	}

	$argIsEqualToFloat$( float )
	{
		return stBoolean$class.$fromJs$( float.js == this.js );
	}

	$argIsSmallerThanFloat$( float )
	{
		return stBoolean$class.$fromJs$( float.js < this.js );
	}

	$argIsSmallerOrEqualToFloat$( float )
	{
		return stBoolean$class.$fromJs$( float.js <= this.js );
	}

	$$plus( number )
	{
		return number.$addToBigInt$( this );
	}

	$$minus( number )
	{
		return number.$subtractFromBigInt$( this );
	}

	$$ast( number )
	{
		return number.$multiplyByBigInt$( this );
	}

	$$sol( number )
	{
		return number.$divideIntoBigInt$( this );
	}

	$$sol$sol( number )
	{
		return number.$integerDivideIntoBigInt$( this );
	}

	$$percnt( number )
	{
		return number.$moduloFromBigInt$( this );
	}

	$addToInteger$( integer )
	{
		return stBigInt$class.$fromJs$( BigInt( integer.js ) + this.js );
	}

	$subtractFromInteger$( integer )
	{
		return stBigInt$class.$fromJs$( BigInt( integer.js ) - this.js );
	}

	$multiplyByInteger$( integer )
	{
		return stBigInt$class.$fromJs$( BigInt( integer.js ) * this.js );
	}

	$divideIntoInteger$( integer )
	{
		return stFraction$class.$numerator$denominator$( integer, this );
	}

	$integerDivideIntoInteger$( integer )
	{
		return stBigInt$class.$fromJs$( BigInt( integer.js ) / this.js );
	}

	$moduloFromInteger$( integer )
	{
		return stBigInt$class.$fromJs$( BigInt( integer.js ) % this.js );
	}

	$addToBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js + this.js );
	}

	$subtractFromBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js - this.js );
	}

	$multiplyByBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js * this.js );
	}

	$divideIntoBigInt$( bigInt )
	{
		return stFraction$class.$numerator$denominator$( bigInt, this );
	}

	$integerDivideIntoBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js / this.js );
	}

	$moduloFromBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js % this.js );
	}

	$addToFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js + Number( this.js ) );
	}

	$subtractFromFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js - Number( this.js ) );
	}

	$multiplyByFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js * Number( this.js ) );
	}

	$divideIntoFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js / Number( this.js ) );
	}

	$integerDivideIntoFloat$( float )
	{
		return stFloat$class.$fromJs$( Math.floor( float.js / Number( this.js ) ) );
	}

	$moduloFromFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js % Number( this.js ) );
	}

	$$amp( number )
	{
		return stBigInt$class.$fromJs$( this.js & number.js );
	}

	$$verbar( number )
	{
		return stBigInt$class.$fromJs$( this.js | number.js );
	}

	$xor$( number )
	{
		return stBigInt$class.$fromJs$( this.js ^ number.js );
	}

	$$gt$gt( count )
	{
		return stBigInt$class.$fromJs$( this.js >> count.js );
	}

	$$lt$lt( count )
	{
		return stBigInt$class.$fromJs$( this.js << count.js );
	}

	$gcd$( number )
	{
		return stBigInt$class.$fromJs$( NumUtil.gcdBigInt( this.js, BigInt( number.js ) ) );
	}

	$gcdInteger$( integer )
	{
		return this.$gcd$( integer );
	}

}

export class StInteger extends StAbstractInteger
{
	$class()
	{
		return stInteger$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Core' );
	}

	$toString()
	{
		return stString$class.$fromJs$( String( this.js ) );
	}

	$toBigInt()
	{
		return stBigInt$class.$fromJs$( this.js );
	}

	$toFloat()
	{
		return stFloat$class.$fromJs$( this.js );
	}

	$$equeals( number )
	{
		return number.$argIsEqualToInteger$( this );
	}

	$$lt( number )
	{
		return number.$argIsSmallerThanInteger$( this );
	}

	$$lt$equeals( number )
	{
		return number.$argIsSmallerOrEqualToInteger$( this );
	}

	$argIsEqualToInteger$( integer )
	{
		return stBoolean$class.$fromJs$( integer.js == this.js );
	}

	$argIsSmallerThanInteger$( integer )
	{
		return stBoolean$class.$fromJs$( integer.js < this.js );
	}

	$argIsSmallerOrEqualToInteger$( integer )
	{
		return stBoolean$class.$fromJs$( integer.js <= this.js );
	}

	$argIsEqualToBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( bigInt.js == BigInt( this.js ) );
	}

	$argIsSmallerThanBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( bigInt.js < BigInt( this.js ) );
	}

	$argIsSmallerOrEqualToBigInt$( bigInt )
	{
		return stBoolean$class.$fromJs$( bigInt.js <= BigInt( this.js ) );
	}

	$argIsEqualToFloat$( float )
	{
		return stBoolean$class.$fromJs$( Math.abs( float.js - this.js ) < Number.EPSILON );
	}

	$argIsSmallerThanFloat$( float )
	{
		return stBoolean$class.$fromJs$( float.js < this.js );
	}

	$argIsSmallerOrEqualToFloat$( float )
	{
		return stBoolean$class.$fromJs$( float.js <= this.js );
	}

	$$plus( number )
	{
		return number.$addToInteger$( this );
	}

	$$minus( number )
	{
		return number.$subtractFromInteger$( this );
	}

	$$ast( number )
	{
		return number.$multiplyByInteger$( this );
	}

	$$sol( number )
	{
		return number.$divideIntoInteger$( this );
	}

	$$sol$sol( number )
	{
		return number.$integerDivideIntoInteger$( this );
	}

	$$percnt( number )
	{
		return number.$moduloFromInteger$( this );
	}

	$addToInteger$( integer )
	{
		
		let jsResult = integer.js + this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt$class.$fromJs$( BigInt( integer.js ) + BigInt( this.js ) );
		return this;
	}

	$subtractFromInteger$( integer )
	{
		
		let jsResult = integer.js - this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt$class.$fromJs$( BigInt( integer.js ) - BigInt( this.js ) );
		return this;
	}

	$multiplyByInteger$( integer )
	{
		
		let jsResult = integer.js * this.js ;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stBigInt$class.$fromJs$( BigInt( integer.js ) * BigInt( this.js ) );
		return this;
	}

	$divideIntoInteger$( integer )
	{
		
		let jsResult = integer.js / this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		return stFraction$class.$numerator$denominator$( integer, this );
	}

	$integerDivideIntoInteger$( integer )
	{
		
		let jsResult = Math.floor( integer.js / this.js );
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		this.$divisionByZeroError();
		return this;
	}

	$moduloFromInteger$( integer )
	{
		
		let jsResult = integer.js % this.js;
		if( Number.isSafeInteger( jsResult ) )
			return stInteger$class.$fromJs$( jsResult );
		this.$divisionByZeroError();
		return this;
	}

	$addToBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js + BigInt( this.js ) );
	}

	$subtractFromBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js - BigInt( this.js ) );
	}

	$multiplyByBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js * BigInt( this.js ) );
	}

	$divideIntoBigInt$( bigInt )
	{
		
		let modulo = bigInt.js % BigInt( this.js );
		if( modulo == 0 )
			return stBigInt$class.$fromJs$( bigInt.js / BigInt( this.js ) );;
		return stFraction$class.$numerator$denominator$( bigInt, this );
	}

	$integerDivideIntoBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js / BigInt( this.js ) );
	}

	$moduloFromBigInt$( bigInt )
	{
		return stBigInt$class.$fromJs$( bigInt.js % BigInt( this.js ) );
	}

	$addToFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js + this.js );
	}

	$subtractFromFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js - this.js );
	}

	$multiplyByFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js * this.js );
	}

	$divideIntoFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js / this.js );
	}

	$integerDivideIntoFloat$( float )
	{
		return stFloat$class.$fromJs$( Math.floor( float.js / this.js ) );
	}

	$moduloFromFloat$( float )
	{
		return stFloat$class.$fromJs$( float.js % this.js );
	}

	$$amp( number )
	{
		return stInteger$class.$fromJs$( this.js & number.js );
	}

	$$verbar( number )
	{
		return stInteger$class.$fromJs$( this.js | number.js );
	}

	$xor$( number )
	{
		return stInteger$class.$fromJs$( this.js ^ number.js );
	}

	$$gt$gt( count )
	{
		return stInteger$class.$fromJs$( this.js >> count.js );
	}

	$$lt$lt( count )
	{
		return stInteger$class.$fromJs$( this.js << count.js );
	}

	$gcd$( number )
	{
		return number.$gcdInteger$( this );
	}

	$gcdInteger$( number )
	{
		return stInteger$class.$fromJs$( NumUtil.gcd( this.js, number.js ) );
	}

}

export class StObject$class extends StClass
{
	$basicNew()
	{
		return new StObject();
	}

	$jsClass()
	{
		return StObject.prototype;
	}

	$myTest()
	{
		( () => { let $object$ = stInteger$class.$fromJs$( 4 );
			$object$.$squared();
			return $object$.$squared();
		} ) ();
		return this;
	}

	$new()
	{
		return this.$basicNew();
	}

	$fromJs$( js )
	{
		let jsClassName = stNil;
		let float = stNil;
		let object = stNil;
		let jsObject = stNil;
		try {
		if( js == null ) return stNil;
		jsClassName = stString$class.$fromJs$( js.constructor.name );
		jsClassName.$$equeals( stString$class.$fromJs$( 'String' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stString$class.$fromJs$( js ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Number' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				float = stFloat$class.$fromJs$( js );
				throw new BlockReturn( float.$isSafeInteger().$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return float.$toInteger();
			} ), stBlock$class.$fromJs$( (  ) => {
				return float;
			} ) ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Boolean' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stBoolean$class.$fromJs$( js ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Array' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stArray$class.$fromJs$elementConverter$( js, stBlock$class.$fromJs$( ( element ) => {
				return stObject$class.$fromJs$( element );
			} ) ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Object' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				object = stObject$class.$new();
				jsObject = stJsObject$class.$fromJs$( js );
				jsObject.$ownJsPropertyNames().$do$( stBlock$class.$fromJs$( ( name ) => {
				return object.$atProperty$put$( name, jsObject.$atJsProperty$( name ) );
			} ) );
				throw new BlockReturn( object );
			} ) );
		this.$error$( stString$class.$fromJs$( 'Unknown JS classname: ' ).$$comma( jsClassName ) );
		return this;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$parse$( json )
	{
		return stObject$class.$fromJs$( JSON.parse( json.js ) );
	}

}

export class StClass$class extends StObject$class
{
	classes = stNil;

	$basicNew()
	{
		return new StClass();
	}

	$jsClass()
	{
		return StClass.prototype;
	}

	$classes()
	{
		this.classes.$isNil().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.classes = stArray$class.$new();
			} ) );
		return this.classes;
	}

}

export class StConsole$class extends StObject$class
{
	$basicNew()
	{
		return new StConsole();
	}

	$jsClass()
	{
		return StConsole.prototype;
	}

	$clear()
	{
		console.clear();
		return this;
	}

	$assert$message$( boolean, message )
	{
		console.assert( boolean.js, message.js );
		return this;
	}

	$debug$( message )
	{
		console.debug( message.js );
		return this;
	}

	$error$( message )
	{
		console.error( message.js );
		return this;
	}

	$info$( message )
	{
		console.info( message.js );
		return this;
	}

	$log$( message )
	{
		console.log( message.js );
		return this;
	}

	$warn$( message )
	{
		console.warn( message.js );
		return this;
	}

	$count$( label )
	{
		console.count( label.js );
		return this;
	}

	$countReset$( label )
	{
		console.countReset( label.js );
		return this;
	}

	$dir$( object )
	{
		console.dir( object );
		return this;
	}

	$dirxml$( object )
	{
		console.dirxml( object );
		return this;
	}

	$table$( array )
	{
		console.table( array.js );
		return this;
	}

	$trace()
	{
		console.trace();
		return this;
	}

	$group$( label )
	{
		console.group( label.js );
		return this;
	}

	$groupCollapsed$( label )
	{
		console.groupCollapsed( label.js );
		return this;
	}

	$groupEnd$( label )
	{
		console.groupEnd( label.js );
		return this;
	}

	$time$( label )
	{
		console.time( label.js );
		return this;
	}

	$timeLog$( label )
	{
		console.timeLog( label.js );
		return this;
	}

	$timeStamp$( label )
	{
		console.timeStamp( label.js );
		return this;
	}

	$timeEnd$( label )
	{
		console.timeEnd( label.js );
		return this;
	}

}

export class StJsObject$class extends StObject$class
{
	$basicNew()
	{
		return new StJsObject();
	}

	$jsClass()
	{
		return StJsObject.prototype;
	}

	$newEmpty()
	{
		return this.$fromJs$( {} );
	}

	$fromJs$( aJs )
	{
		if( aJs == null ) return stNil;
		return this.$basicNew().$js$( aJs );
	}

}

export class StSqlObject$class extends StObject$class
{
	$basicNew()
	{
		return new StSqlObject();
	}

	$jsClass()
	{
		return StSqlObject.prototype;
	}

	$fromRows$( rows )
	{
		let sqlObjects = stNil;
		sqlObjects = stArray$class.$new();
		rows.$do$( stBlock$class.$fromJs$( ( row ) => {
				return sqlObjects.$add$( this.$fromRow$( row ) );
			} ) );
		return sqlObjects;
	}

	$fromRow$( row )
	{
		let sqlObject = stNil;
		sqlObject = this.$new();
		sqlObject.$id$( row.$atProperty$( stString$class.$fromJs$( 'id' ) ) );
		this.$columns().$do$( stBlock$class.$fromJs$( ( column ) => {
				return sqlObject.$atProperty$put$( column, row.$atProperty$( column ) );
			} ) );
		return sqlObject;
	}

	$columns()
	{
		this.$error$( stString$class.$fromJs$( 'Overload this method to return an array of column names (strings) that are also equal to instvars names to store.' ) );
		return this;
	}

}

export class StTest$class extends StObject$class
{
	globalAssertCount = stNil;
	disabledModuleCount = stNil;

	$basicNew()
	{
		return new StTest();
	}

	$jsClass()
	{
		return StTest.prototype;
	}

	$all()
	{
		this.$allThen$( stBlock$class.$fromJs$( (  ) => {
			} ) );
		return this;
	}

	$allThen$( block )
	{
		let aClass = stNil;
		stTest$class.$resetAssertCount();
		stTest$class.$resetDisabledModuleCount();
		stClass$class.$classes().$do$( stBlock$class.$fromJs$( ( aClass ) => {
				return aClass.$inheritsFrom$( stTest$class ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return aClass.$new().$all();
			} ) );
			} ) );
		this.$log$( stString$class.$fromJs$( 'Successfully run sync tests: ' ).$$comma( stTest$class.$globalAssertCount() ) );
		stTest$class.$resetAssertCount();
		stTimer$class.$timeout$then$( stInteger$class.$fromJs$( 2000 ), stBlock$class.$fromJs$( (  ) => {
				this.$log$( stString$class.$fromJs$( 'Successfully run async tests: ' ).$$comma( stTest$class.$globalAssertCount() ) );
				this.$log$( stString$class.$fromJs$( 'Disabled test modules: ' ).$$comma( stTest$class.$disabledModuleCount() ) );
				return block.$value();
			} ) );
		return this;
	}

	$resetAssertCount()
	{
		this.globalAssertCount = stInteger$class.$fromJs$( 0 );
		return this;
	}

	$resetDisabledModuleCount()
	{
		this.disabledModuleCount = stInteger$class.$fromJs$( 0 );
		return this;
	}

	$globalAssertCount()
	{
		this.globalAssertCount.$isNil().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.globalAssertCount = stInteger$class.$fromJs$( 0 );
			} ) );
		return this.globalAssertCount;
	}

	$disabledModuleCount()
	{
		this.disabledModuleCount.$isNil().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.disabledModuleCount = stInteger$class.$fromJs$( 0 );
			} ) );
		return this.disabledModuleCount;
	}

}

export class StTimer$class extends StObject$class
{
	$basicNew()
	{
		return new StTimer();
	}

	$jsClass()
	{
		return StTimer.prototype;
	}

	$timeout$then$( timeout, block )
	{
		return this.$new().$timeout$then$( timeout, block );
	}

	$interval$then$( interval, block )
	{
		return this.$new().$interval$then$( interval, block );
	}

}

export class StEventId$class extends StObject$class
{
	$basicNew()
	{
		return new StEventId();
	}

	$jsClass()
	{
		return StEventId.prototype;
	}

	$fromType$block$jsBlock$( type, block, jsBlock )
	{
		return ( () => { let $object$ = this.$new();
			$object$.$type$( type );
			$object$.$block$( block );
			return $object$.$jsBlock$( jsBlock );
		} ) ();
	}

}

export class StPoint$class extends StObject$class
{
	$basicNew()
	{
		return new StPoint();
	}

	$jsClass()
	{
		return StPoint.prototype;
	}

	$x$y$( x, y )
	{
		return this.$new().$x$y$( x, y );
	}

	$jsX$jsY$( jsX, jsY )
	{
		return this.$x$y$( stInteger$class.$fromJs$( jsX ), stInteger$class.$fromJs$( jsY ) );
	}

}

export class StRect$class extends StObject$class
{
	$basicNew()
	{
		return new StRect();
	}

	$jsClass()
	{
		return StRect.prototype;
	}

	$origin$extent$( origin, extent )
	{
		return this.$new().$origin$extent$( origin, extent );
	}

	$fromJs$( jsDomRect )
	{
		if( jsDomRect == null ) return stNil;
		return this.$origin$extent$( stPoint$class.$jsX$jsY$( jsDomRect.x, jsDomRect.x ), stPoint$class.$jsX$jsY$( jsDomRect.width, jsDomRect.height ) );
	}

}

export class StBlock$class extends StJsObject$class
{
	$basicNew()
	{
		return new StBlock();
	}

	$jsClass()
	{
		return StBlock.prototype;
	}

}

export class StBoolean$class extends StJsObject$class
{
	$basicNew()
	{
		return new StBoolean();
	}

	$jsClass()
	{
		return StBoolean.prototype;
	}

	$fromJs$( jsBool )
	{
		if( jsBool == null ) return stNil;
		return ( jsBool ? stTrue : stFalse );
	}

}

export class StError$class extends StJsObject$class
{
	$basicNew()
	{
		return new StError();
	}

	$jsClass()
	{
		return StError.prototype;
	}

	$new()
	{
		return super.$new().$js$( new Error() );
	}

	$new$( message )
	{
		return this.$fromJs$( new Error( message.$toString().js ) );
	}

	$throw$( message )
	{
		throw new Error( message.$toString().js );
		return this;
	}

}

export class StNil$class extends StJsObject$class
{
	$basicNew()
	{
		return new StNil();
	}

	$jsClass()
	{
		return StNil.prototype;
	}

	$fromJs$( jsObject )
	{
		return jsObject == null ? stNil : jsObject;
	}

}

export class StPromise$class extends StJsObject$class
{
	$basicNew()
	{
		return new StPromise();
	}

	$jsClass()
	{
		return StPromise.prototype;
	}

	$new$( resolveRejectBlock )
	{
		return stPromise$class.$fromJs$( this.js = new Promise( ( resolve, reject ) => resolveRejectBlock.$value$value$(
			new StBlock().$js$( resolve ), new StBlock().$js$( reject ) ) ) );
	}

	$resolve$( object )
	{
		return stPromise$class.$fromJs$( Promise.resolve( object ) );
	}

	$reject$( reason )
	{
		return stPromise$class.$fromJs$( Promise.reject( reason ) );
	}

	$all$then$( promises, block )
	{
		return stPromise$class.$fromJs$( Promise.all( promises.$toJs() ) ).$then$( stBlock$class.$fromJs$( ( jsArray ) => {
				return block.$value$( stArray$class.$new().$js$( jsArray ) );
			} ) );
	}

	$allSettled$then$( promises, block )
	{
		return stPromise$class.$fromJs$( Promise.allSettled( promises.$toJs() ) ).$then$( stBlock$class.$fromJs$( ( jsArray ) => {
				return block.$value$( stArray$class.$fromJs$elementClass$( jsArray, stPromiseStatus$class ) );
			} ) );
	}

	$any$then$( promises, block )
	{
		return stPromise$class.$fromJs$( Promise.any( promises.$toJs() ) ).$then$( stBlock$class.$fromJs$( ( value ) => {
				return block.$value$( value );
			} ) );
	}

	$race$then$( promises, block )
	{
		return stPromise$class.$fromJs$( Promise.race( promises.$toJs() ) ).$then$( stBlock$class.$fromJs$( ( value ) => {
				return block.$value$( value );
			} ) );
	}

}

export class StPromiseStatus$class extends StJsObject$class
{
	$basicNew()
	{
		return new StPromiseStatus();
	}

	$jsClass()
	{
		return StPromiseStatus.prototype;
	}

}

export class StArrayBuffer$class extends StJsObject$class
{
	$basicNew()
	{
		return new StArrayBuffer();
	}

	$jsClass()
	{
		return StArrayBuffer.prototype;
	}

	$new$( byteLength )
	{
		return this.$fromJs$( new ArrayBuffer( byteLength.js ) );
	}

	$isView$( buffer )
	{
		return stBoolean$class.$fromJs$( ArrayBuffer.isView( buffer ) );
	}

}

export class StCollection$class extends StJsObject$class
{
	$basicNew()
	{
		return new StCollection();
	}

	$jsClass()
	{
		return StCollection.prototype;
	}

}

export class StEvent$class extends StJsObject$class
{
	$basicNew()
	{
		return new StEvent();
	}

	$jsClass()
	{
		return StEvent.prototype;
	}

	$type$( type )
	{
		return this.$fromJs$( new Event( type.js ) );
	}

	$fromJsSubEvent$( jsEvent )
	{
		let jsClassName = stNil;
		try {
		if( jsEvent == null ) return stNil;
		jsClassName = stString$class.$fromJs$( jsEvent.constructor.name );
		jsClassName.$$equeals( stString$class.$fromJs$( 'UiEvent' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stUiEvent$class.$fromJs$( jsEvent ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'MouseEvent' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stMouseEvent$class.$fromJs$( jsEvent ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'PointerEvent' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stPointerEvent$class.$fromJs$( jsEvent ) );
			} ) );
		return this.$fromJs$( jsEvent );
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

}

export class StEventTarget$class extends StJsObject$class
{
	$basicNew()
	{
		return new StEventTarget();
	}

	$jsClass()
	{
		return StEventTarget.prototype;
	}

}

export class StAbortController$class extends StJsObject$class
{
	$basicNew()
	{
		return new StAbortController();
	}

	$jsClass()
	{
		return StAbortController.prototype;
	}

	$new()
	{
		return this.$fromJs$( new AbortController() );
	}

}

export class StFormData$class extends StJsObject$class
{
	$basicNew()
	{
		return new StFormData();
	}

	$jsClass()
	{
		return StFormData.prototype;
	}

	$form$( form )
	{
		return stFormData$class.$fromJs$( new FormData( form.js ) );
	}

	$form$submitter$( form, button )
	{
		return stFormData$class.$fromJs$( new FormData( form.js, button.js ) );
	}

}

export class StHeaders$class extends StJsObject$class
{
	$basicNew()
	{
		return new StHeaders();
	}

	$jsClass()
	{
		return StHeaders.prototype;
	}

	$new()
	{
		return this.$fromJs$( new Headers() );
	}

	$init$( strings )
	{
		return this.$fromJs$( strings.$toJs() );
	}

}

export class StRequest$class extends StJsObject$class
{
	$basicNew()
	{
		return new StRequest();
	}

	$jsClass()
	{
		return StRequest.prototype;
	}

	$url$( url )
	{
		return this.$fromJs$( new Request( url.js ) );
	}

	$url$options$( url, options )
	{
		return this.$fromJs$( new Request( url.js, options.js ) );
	}

}

export class StRequestOptions$class extends StJsObject$class
{
	$basicNew()
	{
		return new StRequestOptions();
	}

	$jsClass()
	{
		return StRequestOptions.prototype;
	}

	$new()
	{
		return this.$newEmpty();
	}

}

export class StResponse$class extends StJsObject$class
{
	$basicNew()
	{
		return new StResponse();
	}

	$jsClass()
	{
		return StResponse.prototype;
	}

	$error()
	{
		return stResponse$class.$fromJs$( Response.error() );
	}

	$json$( data )
	{
		return stResponse$class.$fromJs$( Response.json( data.js ) );
	}

	$redirect$( url )
	{
		return stResponse$class.$fromJs$( Response.json( url.js ) );
	}

}

export class StMagnitude$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMagnitude();
	}

	$jsClass()
	{
		return StMagnitude.prototype;
	}

}

export class StBlob$class extends StJsObject$class
{
	$basicNew()
	{
		return new StBlob();
	}

	$jsClass()
	{
		return StBlob.prototype;
	}

	$fromArray$( array )
	{
		return stBlob$class.$fromJs$( new Blob( array.js ) );
	}

}

export class StReadableStream$class extends StJsObject$class
{
	$basicNew()
	{
		return new StReadableStream();
	}

	$jsClass()
	{
		return StReadableStream.prototype;
	}

}

export class StReadableStreamDefaultReader$class extends StJsObject$class
{
	$basicNew()
	{
		return new StReadableStreamDefaultReader();
	}

	$jsClass()
	{
		return StReadableStreamDefaultReader.prototype;
	}

}

export class StReadableStreamDefaultWriter$class extends StJsObject$class
{
	$basicNew()
	{
		return new StReadableStreamDefaultWriter();
	}

	$jsClass()
	{
		return StReadableStreamDefaultWriter.prototype;
	}

}

export class StWritableStream$class extends StJsObject$class
{
	$basicNew()
	{
		return new StWritableStream();
	}

	$jsClass()
	{
		return StWritableStream.prototype;
	}

}

export class StPoint3d$class extends StPoint$class
{
	$basicNew()
	{
		return new StPoint3d();
	}

	$jsClass()
	{
		return StPoint3d.prototype;
	}

	$x$y$z$( x, y, z )
	{
		return ( () => { let $object$ = this.$new();
			$object$.$x$( x );
			$object$.$y$( y );
			return $object$.$z$( z );
		} ) ();
	}

	$jsX$jsY$jsZ$( jsX, jsY, jsZ )
	{
		return this.$x$y$z$( stInteger$class.$fromJs$( jsX ), stInteger$class.$fromJs$( jsY ), stInteger$class.$fromJs$( jsZ ) );
	}

}

export class StAbstractArray$class extends StCollection$class
{
	$basicNew()
	{
		return new StAbstractArray();
	}

	$jsClass()
	{
		return StAbstractArray.prototype;
	}

	$with$( element )
	{
		return this.$new$( stInteger$class.$fromJs$( 1 ) ).$at$put$( stInteger$class.$fromJs$( 0 ), element );
	}

	$with$with$( element1, element2 )
	{
		return ( () => { let $object$ = this.$new$( stInteger$class.$fromJs$( 2 ) );
			$object$.$at$put$( stInteger$class.$fromJs$( 0 ), element1 );
			return $object$.$at$put$( stInteger$class.$fromJs$( 1 ), element2 );
		} ) ();
	}

}

export class StDictionary$class extends StCollection$class
{
	$basicNew()
	{
		return new StDictionary();
	}

	$jsClass()
	{
		return StDictionary.prototype;
	}

}

export class StMap$class extends StCollection$class
{
	$basicNew()
	{
		return new StMap();
	}

	$jsClass()
	{
		return StMap.prototype;
	}

}

export class StUiEvent$class extends StEvent$class
{
	$basicNew()
	{
		return new StUiEvent();
	}

	$jsClass()
	{
		return StUiEvent.prototype;
	}

}

export class StAbortSignal$class extends StEventTarget$class
{
	$basicNew()
	{
		return new StAbortSignal();
	}

	$jsClass()
	{
		return StAbortSignal.prototype;
	}

	$new()
	{
		return this.$formJs$( new AbortSignal() );
	}

	$abort()
	{
		return stAbortSignal$class.$fromJs$( AbortSignal.abort() );
	}

	$any$( abortSignals )
	{
		return stAbortSignal$class.$fromJs$( AbortSignal.any( abortSignals.$toJs() ) );
	}

	$timeout$( time )
	{
		return stAbortSignal$class.$fromJs$( AbortSignal.timeout( time.js ) );
	}

}

export class StCharacter$class extends StMagnitude$class
{
	$basicNew()
	{
		return new StCharacter();
	}

	$jsClass()
	{
		return StCharacter.prototype;
	}

	$fromCode$( code )
	{
		return this.$new().$js$( code.$js() );
	}

	$newline()
	{
		return this.$fromCode$( stInteger$class.$fromJs$( 10 ) );
	}

}

export class StDate$class extends StMagnitude$class
{
	$basicNew()
	{
		return new StDate();
	}

	$jsClass()
	{
		return StDate.prototype;
	}

	$new()
	{
		return this.$fromJs$( new Date() );
	}

	$now()
	{
		return stInteger$class.$fromJs$( Date.now() );
	}

	$fromMilliseconds$( milliseconds )
	{
		return this.$fromJs$( milliseconds.$js() );
	}

	$fromString$( string )
	{
		return this.$fromJs$( new Date( string.js ) );
	}

	$year$month$day$( year, month, day )
	{
		return this.$fromJs$( new Date( year.js, month.js - 1, day.js ) );
	}

	$year$month$day$hours$minutes$seconds$( year, month, day, hours, minutes, seconds )
	{
		return this.$fromJs$( new Date( year.js, month.js - 1, day.js, hours.js, minutes.js, seconds.js ) );
	}

	$utcYear$month$day$hours$minutes$seconds$( year, month, day, hours, minutes, seconds )
	{
		return this.$fromJs$( new Date( Date.UTC( year.js, month.js - 1, day.js, hours.js, minutes.js, seconds.js ) ) );
	}

}

export class StNumber$class extends StMagnitude$class
{
	$basicNew()
	{
		return new StNumber();
	}

	$jsClass()
	{
		return StNumber.prototype;
	}

}

export class StString$class extends StMagnitude$class
{
	$basicNew()
	{
		return new StString();
	}

	$jsClass()
	{
		return StString.prototype;
	}

	$new()
	{
		return this.$basicNew().$js$( "" );
	}

	$fromCharacter$( character )
	{
		return this.$fromJs$( String.fromCharCode( character.js ) );
	}

	$fromCharCode$( code )
	{
		return this.$fromJs$( String.fromCharCode( code.js ) );
	}

	$newline()
	{
		return this.$fromCharacter$( stCharacter$class.$newline() );
	}

}

export class StFile$class extends StBlob$class
{
	$basicNew()
	{
		return new StFile();
	}

	$jsClass()
	{
		return StFile.prototype;
	}

}

export class StArray$class extends StAbstractArray$class
{
	$basicNew()
	{
		return new StArray();
	}

	$jsClass()
	{
		return StArray.prototype;
	}

	$new()
	{
		return this.$basicNew().$js$( [] );
	}

	$new$( length )
	{
		let array = new StArray(); array.js = Array.from( { length: length.js }, ( value, index ) => stNil ); return array;
		return this;
	}

	$fromJs$elementClass$( jsArray, aClass )
	{
		return this.$fromJs$elementConverter$( jsArray, stBlock$class.$fromJs$( ( jsObject ) => {
				return aClass.$fromJs$( jsObject );
			} ) );
	}

	$fromJs$elementConverter$( jsArray, block )
	{
		let array = stNil;
		if( jsArray == null ) return stNil;
		array = stArray$class.$new();
		
		for( let jsObject of jsArray )
			array.js.push( block.$value$( jsObject ) );
		return array;
	}

	$fromJsStrings$( jsArray )
	{
		return stArray$class.$fromJs$elementClass$( jsArray, stString$class );
	}

}

export class StTypedArray$class extends StAbstractArray$class
{
	$basicNew()
	{
		return new StTypedArray();
	}

	$jsClass()
	{
		return StTypedArray.prototype;
	}

	$from$( array )
	{
		let result = stNil;
		result = this.$new$( array.$length() );
		stInteger$class.$fromJs$( 0 ).$to$do$( array.$length().$$minus( stInteger$class.$fromJs$( 1 ) ), stBlock$class.$fromJs$( ( index ) => {
				return result.$at$put$( index, array.$at$( index ) );
			} ) );
		return result;
	}

}

export class StMouseEvent$class extends StUiEvent$class
{
	$basicNew()
	{
		return new StMouseEvent();
	}

	$jsClass()
	{
		return StMouseEvent.prototype;
	}

}

export class StAbstractInteger$class extends StNumber$class
{
	$basicNew()
	{
		return new StAbstractInteger();
	}

	$jsClass()
	{
		return StAbstractInteger.prototype;
	}

}

export class StFloat$class extends StNumber$class
{
	$basicNew()
	{
		return new StFloat();
	}

	$jsClass()
	{
		return StFloat.prototype;
	}

	$fromJs$( jsNumber )
	{
		if( jsNumber == null ) return stNil;
		return this.$basicNew().$js$( Number( jsNumber ) );
	}

	$pi()
	{
		return stFloat$class.$fromJs$( Math.PI );
	}

	$epsilon()
	{
		return stFloat$class.$fromJs$( Number.EPSILON );
	}

	$random()
	{
		return stFloat$class.$fromJs$( Math.random() );
	}

}

export class StFraction$class extends StNumber$class
{
	$basicNew()
	{
		return new StFraction();
	}

	$jsClass()
	{
		return StFraction.prototype;
	}

	$numerator$denominator$( numerator, denominator )
	{
		return this.$new().$numerator$denominator$( numerator, denominator );
	}

}

export class StUint8Array$class extends StTypedArray$class
{
	$basicNew()
	{
		return new StUint8Array();
	}

	$jsClass()
	{
		return StUint8Array.prototype;
	}

	$new()
	{
		return super.$new().$js$( new Uint8Array() );
	}

	$new$( length )
	{
		return super.$new().$js$( new Uint8Array( length.js ) );
	}

	$buffer$( arrayBuffer )
	{
		return new Uint8Array( arrayBuffer.js );
	}

	$buffer$offset$( arrayBuffer, offset )
	{
		return new Uint8Array( arrayBuffer.js, offset.js );
	}

	$buffer$offset$length$( arrayBuffer, offset, length )
	{
		return new Uint8Array( arrayBuffer.js, offset.js, length.js );
	}

	$bytesPerElement()
	{
		return stInteger$class.$fromJs$( Uint8Array.BYTES$PER$ELEMENT );
	}

	$name()
	{
		return stString$class.$fromJs$( Uint8Array.name );
	}

	$elementClass()
	{
		return stInteger$class;
	}

}

export class StPointerEvent$class extends StMouseEvent$class
{
	$basicNew()
	{
		return new StPointerEvent();
	}

	$jsClass()
	{
		return StPointerEvent.prototype;
	}

}

export class StBigInt$class extends StAbstractInteger$class
{
	$basicNew()
	{
		return new StBigInt();
	}

	$jsClass()
	{
		return StBigInt.prototype;
	}

	$fromJs$( jsBigInt )
	{
		if( jsBigInt == null ) return stNil;
		return this.$basicNew().$js$( BigInt( jsBigInt ) );
	}

}

export class StInteger$class extends StAbstractInteger$class
{
	$basicNew()
	{
		return new StInteger();
	}

	$jsClass()
	{
		return StInteger.prototype;
	}

	$fromJs$( jsNumber )
	{
		if( jsNumber == null ) return stNil;
		return this.$basicNew().$js$( Number( Math.floor( jsNumber ) ) );
	}

	$randomFrom$to$( min, max )
	{
		return stFloat$class.$random().$$ast( max.$$minus( min ).$$plus( stInteger$class.$fromJs$( 1 ) ) ).$$plus( min ).$toInteger();
	}

}

export let stNil = new StNil().$js$( null );
export let stTrue = new StBoolean().$js$( true );
export let stFalse = new StBoolean().$js$( false );

export let stObject$class = new StObject$class();
export let stClass$class = new StClass$class();
export let stConsole$class = new StConsole$class();
export let stJsObject$class = new StJsObject$class();
export let stSqlObject$class = new StSqlObject$class();
export let stTest$class = new StTest$class();
export let stTimer$class = new StTimer$class();
export let stEventId$class = new StEventId$class();
export let stPoint$class = new StPoint$class();
export let stRect$class = new StRect$class();
export let stBlock$class = new StBlock$class();
export let stBoolean$class = new StBoolean$class();
export let stError$class = new StError$class();
export let stNil$class = new StNil$class();
export let stPromise$class = new StPromise$class();
export let stPromiseStatus$class = new StPromiseStatus$class();
export let stArrayBuffer$class = new StArrayBuffer$class();
export let stCollection$class = new StCollection$class();
export let stEvent$class = new StEvent$class();
export let stEventTarget$class = new StEventTarget$class();
export let stAbortController$class = new StAbortController$class();
export let stFormData$class = new StFormData$class();
export let stHeaders$class = new StHeaders$class();
export let stRequest$class = new StRequest$class();
export let stRequestOptions$class = new StRequestOptions$class();
export let stResponse$class = new StResponse$class();
export let stMagnitude$class = new StMagnitude$class();
export let stBlob$class = new StBlob$class();
export let stReadableStream$class = new StReadableStream$class();
export let stReadableStreamDefaultReader$class = new StReadableStreamDefaultReader$class();
export let stReadableStreamDefaultWriter$class = new StReadableStreamDefaultWriter$class();
export let stWritableStream$class = new StWritableStream$class();
export let stPoint3d$class = new StPoint3d$class();
export let stAbstractArray$class = new StAbstractArray$class();
export let stDictionary$class = new StDictionary$class();
export let stMap$class = new StMap$class();
export let stUiEvent$class = new StUiEvent$class();
export let stAbortSignal$class = new StAbortSignal$class();
export let stCharacter$class = new StCharacter$class();
export let stDate$class = new StDate$class();
export let stNumber$class = new StNumber$class();
export let stString$class = new StString$class();
export let stFile$class = new StFile$class();
export let stArray$class = new StArray$class();
export let stTypedArray$class = new StTypedArray$class();
export let stMouseEvent$class = new StMouseEvent$class();
export let stAbstractInteger$class = new StAbstractInteger$class();
export let stFloat$class = new StFloat$class();
export let stFraction$class = new StFraction$class();
export let stUint8Array$class = new StUint8Array$class();
export let stPointerEvent$class = new StPointerEvent$class();
export let stBigInt$class = new StBigInt$class();
export let stInteger$class = new StInteger$class();

stClass$class.$superclass$( stObject$class );
stConsole$class.$superclass$( stObject$class );
stJsObject$class.$superclass$( stObject$class );
stSqlObject$class.$superclass$( stObject$class );
stTest$class.$superclass$( stObject$class );
stTimer$class.$superclass$( stObject$class );
stEventId$class.$superclass$( stObject$class );
stPoint$class.$superclass$( stObject$class );
stRect$class.$superclass$( stObject$class );
stBlock$class.$superclass$( stJsObject$class );
stBoolean$class.$superclass$( stJsObject$class );
stError$class.$superclass$( stJsObject$class );
stNil$class.$superclass$( stJsObject$class );
stPromise$class.$superclass$( stJsObject$class );
stPromiseStatus$class.$superclass$( stJsObject$class );
stArrayBuffer$class.$superclass$( stJsObject$class );
stCollection$class.$superclass$( stJsObject$class );
stEvent$class.$superclass$( stJsObject$class );
stEventTarget$class.$superclass$( stJsObject$class );
stAbortController$class.$superclass$( stJsObject$class );
stFormData$class.$superclass$( stJsObject$class );
stHeaders$class.$superclass$( stJsObject$class );
stRequest$class.$superclass$( stJsObject$class );
stRequestOptions$class.$superclass$( stJsObject$class );
stResponse$class.$superclass$( stJsObject$class );
stMagnitude$class.$superclass$( stJsObject$class );
stBlob$class.$superclass$( stJsObject$class );
stReadableStream$class.$superclass$( stJsObject$class );
stReadableStreamDefaultReader$class.$superclass$( stJsObject$class );
stReadableStreamDefaultWriter$class.$superclass$( stJsObject$class );
stWritableStream$class.$superclass$( stJsObject$class );
stPoint3d$class.$superclass$( stPoint$class );
stAbstractArray$class.$superclass$( stCollection$class );
stDictionary$class.$superclass$( stCollection$class );
stMap$class.$superclass$( stCollection$class );
stUiEvent$class.$superclass$( stEvent$class );
stAbortSignal$class.$superclass$( stEventTarget$class );
stCharacter$class.$superclass$( stMagnitude$class );
stDate$class.$superclass$( stMagnitude$class );
stNumber$class.$superclass$( stMagnitude$class );
stString$class.$superclass$( stMagnitude$class );
stFile$class.$superclass$( stBlob$class );
stArray$class.$superclass$( stAbstractArray$class );
stTypedArray$class.$superclass$( stAbstractArray$class );
stMouseEvent$class.$superclass$( stUiEvent$class );
stAbstractInteger$class.$superclass$( stNumber$class );
stFloat$class.$superclass$( stNumber$class );
stFraction$class.$superclass$( stNumber$class );
stUint8Array$class.$superclass$( stTypedArray$class );
stPointerEvent$class.$superclass$( stMouseEvent$class );
stBigInt$class.$superclass$( stAbstractInteger$class );
stInteger$class.$superclass$( stAbstractInteger$class );

stClass$class.$classes().$add$( stObject$class );
stClass$class.$classes().$add$( stClass$class );
stClass$class.$classes().$add$( stConsole$class );
stClass$class.$classes().$add$( stJsObject$class );
stClass$class.$classes().$add$( stSqlObject$class );
stClass$class.$classes().$add$( stTest$class );
stClass$class.$classes().$add$( stTimer$class );
stClass$class.$classes().$add$( stEventId$class );
stClass$class.$classes().$add$( stPoint$class );
stClass$class.$classes().$add$( stRect$class );
stClass$class.$classes().$add$( stBlock$class );
stClass$class.$classes().$add$( stBoolean$class );
stClass$class.$classes().$add$( stError$class );
stClass$class.$classes().$add$( stNil$class );
stClass$class.$classes().$add$( stPromise$class );
stClass$class.$classes().$add$( stPromiseStatus$class );
stClass$class.$classes().$add$( stArrayBuffer$class );
stClass$class.$classes().$add$( stCollection$class );
stClass$class.$classes().$add$( stEvent$class );
stClass$class.$classes().$add$( stEventTarget$class );
stClass$class.$classes().$add$( stAbortController$class );
stClass$class.$classes().$add$( stFormData$class );
stClass$class.$classes().$add$( stHeaders$class );
stClass$class.$classes().$add$( stRequest$class );
stClass$class.$classes().$add$( stRequestOptions$class );
stClass$class.$classes().$add$( stResponse$class );
stClass$class.$classes().$add$( stMagnitude$class );
stClass$class.$classes().$add$( stBlob$class );
stClass$class.$classes().$add$( stReadableStream$class );
stClass$class.$classes().$add$( stReadableStreamDefaultReader$class );
stClass$class.$classes().$add$( stReadableStreamDefaultWriter$class );
stClass$class.$classes().$add$( stWritableStream$class );
stClass$class.$classes().$add$( stPoint3d$class );
stClass$class.$classes().$add$( stAbstractArray$class );
stClass$class.$classes().$add$( stDictionary$class );
stClass$class.$classes().$add$( stMap$class );
stClass$class.$classes().$add$( stUiEvent$class );
stClass$class.$classes().$add$( stAbortSignal$class );
stClass$class.$classes().$add$( stCharacter$class );
stClass$class.$classes().$add$( stDate$class );
stClass$class.$classes().$add$( stNumber$class );
stClass$class.$classes().$add$( stString$class );
stClass$class.$classes().$add$( stFile$class );
stClass$class.$classes().$add$( stArray$class );
stClass$class.$classes().$add$( stTypedArray$class );
stClass$class.$classes().$add$( stMouseEvent$class );
stClass$class.$classes().$add$( stAbstractInteger$class );
stClass$class.$classes().$add$( stFloat$class );
stClass$class.$classes().$add$( stFraction$class );
stClass$class.$classes().$add$( stUint8Array$class );
stClass$class.$classes().$add$( stPointerEvent$class );
stClass$class.$classes().$add$( stBigInt$class );
stClass$class.$classes().$add$( stInteger$class );


//# sourceMappingURL=Core.js.map
