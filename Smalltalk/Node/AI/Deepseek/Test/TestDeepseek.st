CLASS TestDeepseek EXTENDS Test MODULE AiTest CLASSVARS '' VARS ''

"The Deepseek API is fully compatible with that of OpenAI.
 The only configuration differences are environment variables:
 	Base URL: DEEPSEEK_BASE_URL
	API key: DEEPSEEK_API_KEY
	Text models: DEEPSEEK_TEXT_MODELS

The class DeepseekClientOptions uses the Deepseek base URL and API key env vars for defaults."

"This also tests these OpenAI classes for use with DeepSeek:
	OpenaiChatCompletion, OpenaiChatCompletionChoice,
	OpenaiChatCompletionMessage, OpenaiCompletionUsage."

disabled
	^ Deepseek available not.
!
test
	| deepseek request |

	deepseek := Deepseek new.

	request := OpenaiChatCompletionRequest new
		model: deepseek model;
		addRole: 'user' content: 'Say this is a test'.

	deepseek createChatCompletion: request
		then: [ :chatCompletion | self onChatCompletion: chatCompletion ].
!
onChatCompletion: chatCompletion
	| choice message usage |

	self assert: [ chatCompletion class = OpenaiChatCompletion ].
	self assert: [ ( Date new toSeconds - chatCompletion created toSeconds ) < 60 ].
	self assert: [ chatCompletion id length > 10 ].
	self assert: [ chatCompletion model startsWith: 'deepseek' ].
	self assert: [ chatCompletion object = 'chat.completion' ].
	self assert: [ chatCompletion systemFingerprint startsWith: 'fp_' ].
	self assert: [ chatCompletion choices length = 1 ].

	choice := chatCompletion choices first.
	self assert: [ choice class = OpenaiChatCompletionChoice ].
	self assert: [ choice finishReason = 'stop' ].
	self assert: [ choice index = 0 ].

	message := choice message.
	self assert: [ message class = OpenaiChatCompletionMessage ].
	self assert: [ message role = 'assistant' ].
	self assert: [ message content toLowerCase includes: 'this is a test'  ].

	usage := chatCompletion usage.
	self assert: [ usage class = OpenaiCompletionUsage ].
	self assert: [ usage completionTokens > 0 ].
	self assert: [ usage promptTokens > 0 ].
	self assert: [ usage totalTokens = ( usage completionTokens + usage promptTokens ) ].

	self assert: [ usage promptCachedTokens = 0 ].
!
