CLASS AnthropicMessage EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

"This is the *result* message form an Anthropic.create: call"

id
	^ String fromJs: INLINE 'this.js.id'.
!
content
	^ Array fromJs: INLINE 'this.js.content' elementClass: AnthropicTextBlock.
!
model
	^ String fromJs: INLINE 'this.js.model'.
!
role
	^ String fromJs: INLINE 'this.js.role'.
!
stopReason
	^ String fromJs: INLINE 'this.js.stop_reason'.
!
stopSequence
	^ String fromJs: INLINE 'this.js.stop_sequence'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
usage
	^ AnthropicUsage fromJs: INLINE 'this.js.usage'.
!
