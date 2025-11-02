CLASS Block EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"The inherited variable js contains the associated JS function."

METHODS

script
	^ String fromJs: INLINE 'this.js.toString()'.
!
value
	^ INLINE 'this.js()'.
!
value: arg1
	^ INLINE 'this.js( arg1 )'.
!
value: arg1 value: arg2
	^ INLINE 'this.js( arg1, arg2 )'.
!
tryCatch: block
	INLINE 'try { return this.$value() }
		catch( error ) { return block.$value$( stError$class.$fromJs$( error ) ) }'.
!
whileTrue: block
	INLINE 'while( this.$value().js )
		block.$value()'.
!
whileTrue
	INLINE 'while( this.$value().js )'.
!
and: block
	^ self value ifTrue: [ block value ].
!
or: block
	^ self value ifFalse: [ block value ].
!
