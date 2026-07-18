CLASS GoogleaiContentResponse EXTENDS JsObject MODULE AiGoogleai CLASSVARS '' VARS ''

"Implements JS classes: GenerateContentResponse, EnhancedGenerateContentResponse"

text
	^ String fromJs: INLINE 'this.js.text()'.
!
