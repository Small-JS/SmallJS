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
	"Answer the ContentResponse for the message Strings, each sent as a separate turn.
	 Like with the other AI providers, the messages alternate user questions and AI answers,
	 so even (zero based) indexes get role 'user' and odd indexes role 'model', see Ai>>roleAt:.
	 ContentResult is skipped because it only has the one response member."
	^ GoogleaiContentResponse fromJs: INLINE '( await this.js.generateContent( {
		contents: messages.$toJs().map( ( text, index ) =>
			( { role: index % 2 == 0 ? "user" : "model", parts: [ { text } ] } ) ) } ) ).response'.
!
