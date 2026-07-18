CLASS OllamaEmbedRequest EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

model: model
	INLINE 'this.js.model = model.js'.
!
input: input
	INLINE 'this.js.input = input.js'.
!
truncate: truncate
	INLINE 'this.js.truncate = truncate.js'.
!
keep_alive: keep_alive
	INLINE 'this.js.keep_alive = keep_alive.js'.
!
dimensions: dimensions
	INLINE 'this.js.dimensions = dimensions.js'.
!

"TODO: Implement options"

