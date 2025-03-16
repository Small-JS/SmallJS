CLASS Ai EXTENDS JsObject MODULE Ai CLASSVARS '' VARS 'model'

"Base class with functionality common to all AI providers.
 Specific AI providers extend this class."

CLASSMETHODS

"Meta"

aiClasses
	^ #( Openai Deepseek Googleai ).
!
classNamed: name
	| class |
	name := name toLowerCase.
	class := self aiClasses find: [ :aClass | aClass name toLowerCase = name ].
	class ifNil: [
		self error: 'Unknown AI class name: ', name ].
	^ class.
!

"Creation"

new
	self error: 'Subclass responsibility.'.
!
new: name
	^ ( self classNamed: name ) new.
!

"Testing"

available
	"Overloads should return true if the AI provider is available for use.
	 E.g.: If it's API key is set."
	^ self error: 'Subclass responsibility.'.
!
available: name
	^ ( self classNamed: name ) available.
!

METHODS

"Models"

models
	"Overloads should return a list of available model names,
	 Preferably set by in an environment varable, e.g.: OPENAI_MODELS"
	^ self error: 'Subclass responsibility.'.
!
model
	model ifNil: [
		model := self models first ].
	^ model.
!
model: aModel
	model := aModel.
!

"Chat"

chat: request then: block
	"Ask a single text question to this AI provider,
	 and call the block with the response text."
	self error: 'Subclass responsibility.'.
!
