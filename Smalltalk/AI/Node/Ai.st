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
	"Return list of model names set in variable <classname><extension>, e.g.: OPENAI_MODELS.
	 Names are separated by spaces. Return an empty list if the variable is not set."
	| variableName modelsString |
	variableName := self name toUpperCase, extension.
	modelsString := Environment at: variableName.
	modelsString ifNil: [ ^ #() ].
	^ ( modelsString split: ' ' ) filter: [ :modelName | modelName isEmpty not ].
!
apiKey
	"Return API key set in varable <classname>_API_KEY, e.g.: OPENAI_API_KEY"
	| variableName |
	variableName := self name toUpperCase, '_API_KEY'.
	^ Environment at: variableName.
!
requiresApiKey
	"Return true if this AI needs an API key. Local AIs override this."
	^ true.
!
available
	"Return true if the base URL, the models and, if required, the API key are set for this AI."
	( self isSet: self baseUrl ) ifFalse: [ ^ false ].
	( self requiresApiKey and: [ ( self isSet: self apiKey ) not ] ) ifTrue: [ ^ false ].
	^ self models isEmpty not.
!
isSet: value
	"Return true if the environment variable value is set and not blank."
	^ value notNil and: [ value trim isEmpty not ].
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
		self class models isEmpty ifTrue: [
			self error: 'Environment variable not set: ', self class name toUpperCase, '_MODELS' ].
		model := self class models first ].
	^ model.
!
model: aModel
	model := aModel.
!
embeddingModel
	embeddingModel ifNil: [
		self class embeddingModels isEmpty ifTrue: [
			self error: 'Environment variable not set: ', self class name toUpperCase, '_EMBEDDING_MODELS' ].
		embeddingModel := self class embeddingModels first ].
	^ embeddingModel.
!
embeddingModel: aEmbeddingModel
	embeddingModel := aEmbeddingModel.
!

"Chat"

chat: messages
	"Ask a question to this AI provider with the text strings in the messages array,
	 using the current model. Answer a promise of the response text.
	 The messages alternate user questions and AI answers, starting with a question,
	 so the last message is the new question. See roleAt:."
	^ self chat: messages model: self model.
!
chat: messages model: aModel
	"Ask a question to this AI provider with the text strings in the messages array,
	 using the model named aModel. Answer a promise of the response text.
	 The model is passed per call, so concurrent requests can use different models."
	self error: 'Subclass responsibility.'.
!
roleAt: index
	"Answer the chat role of the message at (zero based) index in a messages array:
	 'user' for questions at even indexes, 'assistant' for AI answers at odd indexes."
	^ index even ifTrue: [ 'user' ] ifFalse: [ 'assistant' ].
!

"Id"

nextId
	"Generate unique ID to use for differentiating AI responses."
	id := id + 1.
	^ self name, '-', id toString.
!
