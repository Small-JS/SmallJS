CLASS OpenaiChatCompletionChoice EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

finishReason
 	^ String fromJs: INLINE 'this.js.finish_reason'.
!
index
 	^ Integer fromJs: INLINE 'this.js.index'.
!
message
 	^ OpenaiChatCompletionMessage fromJs: INLINE 'this.js.message'.
!
