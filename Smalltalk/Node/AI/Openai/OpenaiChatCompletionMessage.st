CLASS OpenaiChatCompletionMessage EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

content
 	^ String fromJs: INLINE 'this.js.content'.
!
refusal
	"2025-02-16: This is NULL, even for refused requests."
 	^ String fromJs: INLINE 'this.js.refusal'.
!
role
 	^ String fromJs: INLINE 'this.js.role'.
!
