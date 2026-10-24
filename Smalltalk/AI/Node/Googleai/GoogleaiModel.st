CLASS GoogleaiModel EXTENDS JsObject MODULE AiGoogleai CLASSVARS '' VARS ''

"Implements JS class: GenerativeModel"

"Accessing"

apiKey
	^ String fromJs: INLINE 'this.js.apiKey'.
!
model
	^ String fromJs: INLINE 'this.js.model'.
!

"Content"

async generateContent: messages
	"Answer the ContentResponse for the message Strings, each sent as a separate user turn,
	 like the other AI providers do.
	 ContentResult is skipped because it only has the one response member."
	^ GoogleaiContentResponse fromJs: INLINE '( await this.js.generateContent( {
		contents: messages.$toJs().map( text => ( { role: "user", parts: [ { text } ] } ) ) } ) ).response'.
!
