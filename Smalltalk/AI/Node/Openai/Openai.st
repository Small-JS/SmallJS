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

METHODS

"Chat"

async chat: messages
	| request chatCompletion |
	request := OpenaiChatCompletionRequest new
		model: self model.
	messages do: [ :message |
		request addRole: 'user' content: message ].

	chatCompletion := await self createChatCompletion: request.
	^ chatCompletion choices first message content.
!
async createChatCompletion: request
	^ OpenaiChatCompletion fromJs: INLINE 'await this.js.chat.completions.create( request.js )'.
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
