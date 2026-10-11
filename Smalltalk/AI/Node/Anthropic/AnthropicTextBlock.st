CLASS AnthropicTextBlock EXTENDS JsObject MODULE AiAnthropic CLASSVARS '' VARS ''

"Note: citations are not implemented yet."

text
 	^ String fromJs: INLINE 'this.js.text'.
!
type
 	^ String fromJs: INLINE 'this.js.type'.
!

