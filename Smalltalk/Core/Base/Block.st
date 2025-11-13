CLASS Block EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"The inherited variable js contains the associated JS function."

METHODS

"Conversion"

script
	^ String fromJs: INLINE 'this.js.toString()'.
!

"Evaluating"

value
	^ INLINE 'this.js()'.
!
value: arg1
	^ INLINE 'this.js( arg1 )'.
!
value: arg1 value: arg2
	^ INLINE 'this.js( arg1, arg2 )'.
!

"Evaluating - Await"

async valueAwait
	^ INLINE 'await this.js()'.
!
async valueAwait: arg1
	^ INLINE 'await this.js( arg1 )'.
!
async valueAwait: arg1 value: arg2
	^ INLINE 'await this.js( arg1, arg2 )'.
!

"Try/catch"

tryCatch: block
	INLINE 'try { return this.$value() }
		catch( error ) { return block.$value$( stError$class.$fromJs$( error ) ) }'.
!
async tryAwaitCatch: block
	INLINE 'try { return await this.$value() }
		catch( error ) { return block.$value$( stError$class.$fromJs$( error ) ) }'.
!

"Iterating"

whileTrue
	INLINE 'while( this.$value().js )'.
!
whileTrue: block
	INLINE 'while( this.$value().js )
		block.$value()'.
!
async whileTrueAwait
	INLINE 'while( await this.$value().js )'.
!
async whileTrueAwait: block
	INLINE 'while( await this.$value().js )
		await block.$value()'.
!

"Boolean operations"

and: block
	^ self value ifTrue: [ block value ].
!
or: block
	^ self value ifFalse: [ block value ].
!

