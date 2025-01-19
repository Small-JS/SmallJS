CLASS MyType EXTENDS SqlObject MODULE TestDatabase CLASSVARS ''
	VARS 'string integer float date boolean binary anil'

CLASSMETHODS

columns
	^ #( #( 'string' String )
		#( 'integer' Integer )
		#( 'float' Float )
		#( 'date' Date )
		#( 'boolean' Boolean )
		#( 'binary' Uint8Array )
		#( 'anil' Nil ) ).
!

fromObject: object
	^ self new
		id: ( object atProperty: 'id' );
		string: ( object atProperty: 'string' );
		integer: ( object atProperty: 'integer');
		float: ( object atProperty: 'float' );
		date: ( object atProperty: 'date' );
		boolean: ( object atProperty: 'boolean' );
		binary: ( object atProperty: 'binary' );
		anil: ( object atProperty: 'anil' ).
!

METHODS

"Accessing"

string
	^ string.
!
string: aString
	string := aString.
!
integer
	^ integer.
!
integer: aInteger
	integer := aInteger.
!
float
	^ float.
!
float: aFloat
	float := aFloat.
!
date
	^ date.
!
date: aDate
	date := aDate.
!
boolean
	^ boolean.
!
boolean: aBoolean
	boolean := aBoolean.
!
binary
	^ binary.
!
binary: aBinary
	binary := aBinary.
!
anil
	^ anil.
!
anil: aAnil
	anil := aAnil.
!

"Comparing"

= aType
	^ ( id = aType id ) &
		( string = aType string ) &
		( integer = aType integer ) &
		( ( float - aType float ) abs < 0.000001 ) &
		( date = aType date ) &
		( boolean = aType boolean ) &
		( binary = aType binary ) &
		( anil = aType anil ).
!

"Conversion"

toString
	^ 'Type: id: ', string toString,
		', string: ', string,
		', integer: ', integer toString,
		', float: ', float toString,
		', date: ', date toString,
		', boolean: ', boolean toString,
		', binary: ', binary toString,
		', anil: ', anil toString.
!
