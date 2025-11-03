CLASS GoogleaiModel EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

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
	"This evaluates block with a ContentResponse.
	 ContentResult is skipped because it only has the one reponse member."
	^ GoogleaiContentResponse fromJs: INLINE '( await this.js.generateContent( messages.$toJs() ) ).response'.
!
