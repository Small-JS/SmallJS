CLASS TestAnthropic EXTENDS Test MODULE TestAi CLASSVARS '' VARS 'anthropic'

"Also tests classes: AnthropicCreateMessageParams, AnthropicMessage."

disabled
	^ Anthropic available not.
!
test
	| messageParam createMessageParams |

	anthropic := Anthropic new.
	self assert: [ anthropic apiKey startsWith: 'sk-ant' ].
	self assert: [ anthropic authToken isNil ].
	self assert: [ anthropic baseUrl startsWith: 'https:' ].
	self assert: [ anthropic maxRetries >= 0 ].
	self assert: [ anthropic timeout > 0 ].

	messageParam := AnthropicMessageParam new
		role: 'user';
		content: 'Say this is a test'.
	self assert: [ messageParam role = 'user' ].
	self assert: [ messageParam content = 'Say this is a test' ].

	createMessageParams := AnthropicCreateMessageParams new
		model: anthropic model;
		maxTokens: 1024;
		messages: ( Array with: messageParam ).
	self assert: [ createMessageParams model = anthropic model ].
	self assert: [ createMessageParams maxTokens = 1024 ].
	self assert: [ createMessageParams stream not ].

	messageParam := createMessageParams messages first.
	self assert: [ messageParam role = 'user' ].
	self assert: [ messageParam content = 'Say this is a test' ].

	anthropic create: createMessageParams
		then: [ :message | self onCreate: message ].
!
onCreate: message
	| textBlock usage |

	self assert: [ message class = AnthropicMessage ].
	self assert: [ message content length = 1 ].
	self assert: [ message id startsWith: 'msg' ].
	self assert: [ message model = anthropic model ].
	self assert: [ message role = 'assistant' ].
	self assert: [ message stopReason = 'end_turn' ].
	self assert: [ message stopSequence isNil ].
	self assert: [ message type = 'message' ].

	textBlock := message content first.
	self assert: [ textBlock class = AnthropicTextBlock ].
	self assert: [ textBlock text toLowerCase includes: 'test' ].

	usage := message usage.
	self assert: [ usage class = AnthropicUsage ].
	self assert: [ usage cacheCreationInputTokens >= 0 ].
	self assert: [ usage cacheReadInputTokens >= 0 ].
	self assert: [ usage inputTokens > 0 ].
	self assert: [ usage outputTokens > 0 ].
!
