CLASS TestOpenai EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

"Also tests classes:
	OpenaiChatCompletion, OpenaiChatCompletionChoice,
	OpenaiChatCompletionMessage, OpenaiCompletionUsage."

disabled
	^ Openai available not.
!
test
	| openai request |

	openai := Openai new.

	request := OpenaiChatCompletionRequest new
		model: openai model;
		addRole: 'user' content: 'Say this is a test'.

	openai createChatCompletion: request
		then: [ :chatCompletion | self onChatCompletion: chatCompletion ].
!
onChatCompletion: chatCompletion
	| choice message usage |

	self assert: [ chatCompletion class = OpenaiChatCompletion ].
	self assert: [ ( Date new toSeconds - chatCompletion created toSeconds ) < 60 ].
	self assert: [ chatCompletion id startsWith: 'chatcmpl' ].
	self assert: [ #( 'chatgpt' 'gpt' 'o1' 'o4' ) some: [ :modelNameStart |
		chatCompletion model startsWith: modelNameStart ] ].
	self assert: [ chatCompletion object = 'chat.completion' ].
	self assert: [ #( 'scale' 'default' ) includes: chatCompletion serviceTier ].
	chatCompletion systemFingerprint ifNotNil: [
		self assert: [ chatCompletion systemFingerprint startsWith: 'fp_' ] ].
	self assert: [ chatCompletion choices length = 1 ].

	choice := chatCompletion choices first.
	self assert: [ choice class = OpenaiChatCompletionChoice ].
	self assert: [ choice finishReason = 'stop' ].
	self assert: [ choice index = 0 ].

	message := choice message.
	self assert: [ message class = OpenaiChatCompletionMessage ].
	self assert: [ message role = 'assistant' ].
	self assert: [ message content toLowerCase includes: 'test' ].

	usage := chatCompletion usage.
	self assert: [ usage class = OpenaiCompletionUsage ].
	self assert: [ usage completionTokens > 0 ].
	self assert: [ usage promptTokens > 0 ].
	self assert: [ usage totalTokens = ( usage completionTokens + usage promptTokens ) ].

	self assert: [ usage completionAcceptedPredictionTokens = 0 ].
	self assert: [ usage completionAudioTokens = 0 ].
	self assert: [ usage completionReasoningTokens >= 0 ].
	self assert: [ usage completionRejectedPredictionTokens = 0 ].

	self assert: [ usage promptAudioTokens = 0 ].
	self assert: [ usage promptCachedTokens = 0 ].
!
