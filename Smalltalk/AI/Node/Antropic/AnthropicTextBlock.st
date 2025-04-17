CLASS AnthropicTextBlock EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

text
 	^ String fromJs: INLINE 'this.js.text'.
!
type
 	^ String fromJs: INLINE 'this.js.type'.
!

"TODO: Implement more properties."
