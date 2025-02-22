CLASS Openai EXTENDS Ai MODULE Ai CLASSVARS '' VARS ''

"This class also implements the almost-empty OpenAI JS classes:
 OpenAI.Chat and OpenAI.Chat.Completions."

INLINE 'import OpenAI from "openai";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new OpenAI()'.
!
new: options
	^ self fromJs: INLINE 'new OpenAI( options.js )'.
!

"Testing"

available
	^ ( Process envAt: 'OPENAI_API_KEY') notNil.
!

METHODS

"Models"

models
	| modelsString |
	modelsString := Process envAt: 'OPENAI_MODELS'.
	modelsString ifNil: [ ^ #( 'gpt-4o-mini' ) ].  "Default"
	^ modelsString split: ' '.
!

"Chat"

chat: content then: block
	| request |
	request := OpenaiChatCompletionRequest new
		model: self model; addRole: 'user' content: content.

	self createChatCompletion: request then: [ :chatCompletion |
		block value: chatCompletion choices first message content ].
!
createChatCompletion: request then: block
	INLINE 'this.js.chat.completions.create( request.js )
			.then( chatCompletion => block.$value$( stOpenaiChatCompletion$class.$fromJs$( chatCompletion ) ) )'.
!

"Options set"

apiKey
	^ String fromJs: INLINE 'this.js.apiKey'.
!
organization
	^ String fromJs: INLINE 'this.js.organization'.
!
project
	^ String fromJs: INLINE 'this.js.project'.
!
