CLASS Anthropic EXTENDS Ai MODULE AiAnthropic CLASSVARS '' VARS ''

"This class also implements JS class Anthropic.Messages"

INLINE 'import { Anthropic } from "@anthropic-ai/sdk";'

CLASSMETHODS

new
	"Use api key from environment variable ANTHROPIC_API_KEY by default"
	| apiKey options |

	apiKey := self apiKey.
	apiKey ifNil: [
		self error: 'Environment variable not set: ANTHROPIC_API_KEY' ].

	options := AnthropicClientOptions new apiKey: apiKey.

	^ self new: options.
!
new: options
	^ self fromJs: INLINE 'new Anthropic( options.js )'.
!

"Configuration"

maxTokens
	"The Anthropic API requires a maximum number of output tokens per chat.
	 Longer answers are cut off, with stop reason 'max_tokens'."
	^ 4096.
!

METHODS

"Chat"

async chat: messages model: aModel
	"Answer the text of the first text block. Other blocks, like thinking, are skipped."
	| messageParams createMessageParams message textBlock |

	messageParams := Array new.
	0 to: messages length - 1 do: [ :index |
		messageParams add: ( AnthropicMessageParam new
			role: ( self roleAt: index );
			content: ( messages at: index ) ) ].

	createMessageParams := AnthropicMessageCreateParams new
		model: aModel;
		maxTokens: self class maxTokens;
		messages: messageParams.

	message := await self create: createMessageParams.
	textBlock := message content find: [ :block | block type = 'text' ].
	textBlock ifNil: [
		self error: 'Anthropic response has no text, stop reason: ', message stopReason toString ].
	^ textBlock text.
!
async create: params
	^ AnthropicMessage fromJs: INLINE 'await this.js.messages.create( params.js )'.
!

"Options set"

apiKey
	^ String fromJs: INLINE 'this.js.apiKey'.
!
authToken
	^ String fromJs: INLINE 'this.js.authToken'.
!
baseUrl
	^ String fromJs: INLINE 'this.js.baseURL'.
!
webhookKey
	^ String fromJs: INLINE 'this.js.webhookKey'.
!
logLevel
	^ String fromJs: INLINE 'this.js.logLevel'.
!
maxRetries
	^ Integer fromJs: INLINE 'this.js.maxRetries'.
!
timeout
	^ Integer fromJs: INLINE 'this.js.timeout'.
!
