CLASS Ai EXTENDS JsObject MODULE Ai CLASSVARS ''
	VARS 'model embeddingModel id'

"Base class with functionality common to all AI providers.
 Specific AI providers extend this class."

CLASSMETHODS

"Creation"

new
	self error: 'Subclass responsibility.'.
!

"Configuration"

baseUrl
	"Return base URL key set in varable <classname>_BASE_URL, e.g.: OPENAI_BASE_URL"
	| variableName |
	variableName := self name toUpperCase, '_BASE_URL'.
	^ Environment at: variableName.
!
models
	"Return list of model names set in variable <classname>_MODELS, e.g.: OPENAI_MODELS"
	^ self modelsFor: '_MODELS'.
!
embeddingModels
	"Return list of embedding model names set in variable <classname>_EMBEDDING_MODELS, e.g.: OPENAI_MODELS"
	^ self modelsFor: '_EMBEDDING_MODELS'.
!
modelsFor: extension
	"Return list of embedding model names set in variable"
	| variableName modelsString |
	variableName := self name toUpperCase, extension.
	modelsString := Environment at: variableName.
	^ modelsString split: ' '.
!
apiKey
	"Return API key set in varable <classname>_API_KEY, e.g.: OPENAI_API_KEY"
	| variableName |
	variableName := self name toUpperCase, '_API_KEY'.
	^ Environment at: variableName.
!
available
	"Return true if the base URL key is set for this AI."
	^ self baseUrl notNil.
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
embeddingModel
	embeddingModel ifNil: [
		embeddingModel := self class embeddingModels first ].
	^ embeddingModel.
!
embeddingModel: aEmbeddingModel
	embeddingModel := aEmbeddingModel.
!

"Chat"

chat: messages
	"Ask a question to this AI provider with the text strings in the messages array,
	 and call the block with the response text."
	self error: 'Subclass responsibility.'.
!

"Id"

nextId
	"Generate unique ID to use for differentiating AI responses."
	id := id + 1.
	^ self name, '-', id toString.
!
