CLASS GoogleaiContentResponse EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

"Implements JS classes: GenerateContentResponse, EnhancedGenerateContentResponse"

text
	^ String fromJs: INLINE 'this.js.text()'.
!
