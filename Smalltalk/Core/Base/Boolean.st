CLASS Boolean EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"The inherited variable 'js' contains the associated JS boolean object.
	 Only 2 unmutable global instances are created and used: stTrue and stFalse."

CLASSMETHODS

fromJs: jsBool
	INLINE 'if( jsBool == null ) return stNil'.
	^ INLINE '( jsBool ? stTrue : stFalse )'.
!
fromInteger: integer
	^ ( integer = 0 | integer isNil ) not.
!

METHODS

"Conversion"

toString
	^ self ifTrue: [ 'true' ] ifFalse: [ 'false' ].
!
toInteger
	^ self ifTrue: [ 1 ] ifFalse: [ 0 ].
!

"Comparing"

< boolean
	^ Boolean fromJs: INLINE 'this.js < boolean.js'.
!
> boolean
	^ Boolean fromJs: INLINE 'this.js > boolean.js'.
!
<= boolean
	^ Boolean fromJs: INLINE 'this.js <= boolean.js'.
!
>= boolean
	^ Boolean fromJs: INLINE 'this.js >= boolean.js'.
!
compare: boolean
	"Returns -1, 0 or if self is respectively smaller than, equal to or larger than aMagnitude."
	^ self < boolean ifTrue: [ -1 ] ifFalse: [ self > boolean ifTrue: [ 1 ] ifFalse: [ 0 ] ].
!


"If true or false then block."

ifTrue: block
	^ INLINE '( this.js ? block.$value() : this )'.
!
ifFalse: block
	^ INLINE '( this.js ? this : block.$value() )'.
!
ifTrue: trueBlock ifFalse: falseBlock
	^ INLINE '( this.js ? trueBlock.$value() : falseBlock.$value() )'.
!
ifFalse: falseBlock ifTrue: trueBlock
	^ INLINE '( this.js ? trueBlock.$value() : falseBlock.$value() )'.
!
and: block
	^ self ifTrue: [ block value ] ifFalse: [ self ].
!
or: block
	^ self ifTrue: [ self ] ifFalse: [ block value ].
!

"Async - await"

async ifTrueAwait: block
	^ INLINE '( this.js ? await block.$valueAwait() : this )'.
!
async ifFalseAwait: block
	^ INLINE '( this.js ? this : await block.$valueAwait() )'.
!
async ifTrueAwait: trueBlock ifFalseAwait: falseBlock
	^ INLINE '( this.js ? await trueBlock.$valueAwait() : await falseBlock.$valueAwait() )'.
!
async ifFalseAwait: falseBlock ifTrueAwait: trueBlock
	^ INLINE '( this.js ? await trueBlock.$valueAwait() : await falseBlock.$valueAwait() )'.
!

"Operations"

not
	^ Boolean fromJs: INLINE '! this.js'.
!
& boolean
	^ Boolean fromJs: INLINE 'this.js && boolean.js'.
!
| boolean
	^ Boolean fromJs: INLINE 'this.js || boolean.js'.
!
