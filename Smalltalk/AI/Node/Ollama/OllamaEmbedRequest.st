CLASS OllamaEmbedRequest EXTENDS JsObject MODULE AiOllama CLASSVARS '' VARS ''

"Note: options are not implemented yet."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

model: model
	INLINE 'this.js.model = model.js'.
!
input: input
	"String or Array of Strings."
	INLINE 'this.js.input = input.$toJs()'.
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

