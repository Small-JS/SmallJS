CLASS Ai EXTENDS JsObject MODULE Ai CLASSVARS '' VARS 'model id'

"Base class with functionality common to all AI providers.
 Specific AI providers extend this class."

CLASSMETHODS

"Creation"

new
	self error: 'Subclass responsibility.'.
!
new: name
	^ ( self classNamed: name ) new.
!

"Providers"

aiClasses
	^ #( Ollama Openai Deepseek Googleai Anthropic ).
!
classNamed: name
	| class |
	name := name toLowerCase.
	class := self aiClasses find: [ :aClass | aClass name toLowerCase = name ].
	class ifNil: [
		self error: 'Unknown AI class name: ', name ].
	^ class.
!
providers
	"Return available AI providers as an instance of AiProviders,
	 loaded from environment variables."
	| providers |

	providers := AiProviders new.

	self aiClasses do: [ :class |
		class available ifTrue: [
			providers setProvider: class name toLowerCase models: class models  ] ].

	^ providers.
!

"Configuration"

baseUrl
	"Return base URL key set in varable <classname>_BASE_URL, e.g.: OPENAI_BASE_URL"
	| variableName |
	variableName := self name toUpperCase, '_BASE_URL'.
	^ Process envAt: variableName.
!
models
	"Return list of model names set in varable <classname>_MODELS, e.g.: OPENAI_MODELS"
	| variableName modelsString |
	variableName := self name toUpperCase, '_MODELS'.
	modelsString := Process envAt: variableName.
	^ modelsString split: ' '.
!
apiKey
	"Return API key set in varable <classname>_API_KEY, e.g.: OPENAI_API_KEY"
	| variableName |
	variableName := self name toUpperCase, '_API_KEY'.
	^ Process envAt: variableName.
!
available
	"Return true if the base URL key is set for this AI."
	^ self baseUrl notNil.
!
available: name
	"Return true if the API key is set for the named AI."
	^ ( self classNamed: name ) available.
!

METHODS

constructor
	id := 0.
!

"Accessing"

name
	^ self class name toLowerCase.
!
model
	model ifNil: [
		model := self class models first ].
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

"Id"

nextId
	"Generate unique ID to use for differentiating AI responses."
	id := id + 1.
	^ self name, '-', id toString.
!
