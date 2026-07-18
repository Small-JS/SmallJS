CLASS AnthropicTextBlock EXTENDS JsObject MODULE AiAnthropic CLASSVARS '' VARS ''

text
 	^ String fromJs: INLINE 'this.js.text'.
!
type
 	^ String fromJs: INLINE 'this.js.type'.
!

"TODO: Implement more properties."
