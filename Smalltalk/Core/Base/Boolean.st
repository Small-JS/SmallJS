CLASS Boolean EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"The inherited variable 'js' contains the associated JS boolean object.
	 Only 2 unmutable global instances are created and used: stTrue and stFalse."

CLASSMETHODS

fromJs: jsBool
	INLINE 'if( jsBool == null ) return stNil'.
	^ INLINE '( jsBool ? stTrue : stFalse )'.
!

METHODS

not
	^ Boolean fromJs: INLINE '! this.js'.
!
ifTrue: aBlock
	^ INLINE '( this.js ? aBlock.$value() : this )'.
!
ifFalse: aBlock
	^ INLINE '( this.js ? this : aBlock.$value() )'.
!
ifTrue: trueBlock ifFalse: falseBlock
	^ INLINE '( this.js ? trueBlock.$value() : falseBlock.$value() )'.
!
ifFalse: falseBlock ifTrue: trueBlock
	^ INLINE '( this.js ? trueBlock.$value() : falseBlock.$value() )'.
!
toString
	^ self ifTrue: [ 'true' ] ifFalse: [ 'false' ].
!
& boolean
	^ Boolean fromJs: INLINE 'this.js && boolean.js'.
!
| boolean
	^ Boolean fromJs: INLINE 'this.js || boolean.js'.
!
and: block
	^ self ifTrue: [ block value ] ifFalse: [ self ].
!
or: block
	^ self ifTrue: [ self ] ifFalse: [ block value ].
!
