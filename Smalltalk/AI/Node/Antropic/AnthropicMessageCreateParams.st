CLASS AnthropicCreateMessageParams EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

"This class implements JS interfaces: MessageCreateParamsNonStreaming, MessageCreateParamsStreaming"

CLASSMETHODS

new
	^ self newEmpty
		stream: false.
!

METHODS

maxTokens: maxTokens
	INLINE 'this.js.max_tokens = maxTokens.js'.
!
maxTokens
 	^ Integer fromJs: INLINE 'this.js.max_tokens'.
!
messages: messages
	INLINE 'this.js.messages = messages.$toJs()'.
!
messages
	^ Array fromJs: INLINE 'this.js.messages' elementClass: AnthropicMessageParam.
!
model: model
	INLINE 'this.js.model = model.js'.
!
model
 	^ String fromJs: INLINE 'this.js.model'.
!
stream: stream
	INLINE 'this.js.stream = stream.js'.
!
stream
 	^ Boolean fromJs: INLINE 'this.js.stream'.
!
temperature: temperature
	INLINE 'this.js.temperature = temperature.js'.
!
temperature
 	^ Float fromJs: INLINE 'this.js.temperature'.
!

"TODO: Implement more params"

