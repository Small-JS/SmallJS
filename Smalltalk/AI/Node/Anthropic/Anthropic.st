CLASS Anthropic EXTENDS Ai MODULE Ai CLASSVARS '' VARS ''

"This class also implements JS class Anthropic.Messages"

INLINE 'import { Anthropic } from "@anthropic-ai/sdk";'

CLASSMETHODS

new
	"Use api key from environment variable ANTHROPIC_API_KEY by default"
	| apiKey options |

	apiKey := self apiKey.
	apiKey ifNil: [
		self error: 'Evironment variable not set: ANTHROPIC_API_KEY' ].

	options := AnthropicClientOptions new apiKey: apiKey.

	^ self new: options.
!
new: options
	^ self fromJs: INLINE 'new Anthropic( options.js )'.
!

METHODS

"Chat"

chat: messages then: block
	| messageParams createMessageParams |

	messageParams := messages map: [ :message |
		AnthropicMessageParam new
			role: 'user';
			content: message ].

	createMessageParams := AnthropicCreateMessageParams new
		model: self model;
		maxTokens: 1024;
		messages: messageParams.

	self create: createMessageParams
		then: [ :message | self onChat: message then: block ].
!
onChat: message then: block
	block value: message content first text.
!
create: params then: block
	INLINE 'this.js.messages.create( params.js )
			.then( message => block.$value$( stAnthropicMessage$class.$fromJs$( message ) ) )'.
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
maxRetries
	^ Integer fromJs: INLINE 'this.js.maxRetries'.
!
timeout
	^ Integer fromJs: INLINE 'this.js.timeout'.
!
