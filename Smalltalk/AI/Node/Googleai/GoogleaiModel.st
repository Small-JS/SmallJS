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

generateContent: messages then: block
	"This evaluates block with a ContentResponse.
	 ContentResult is skipped because it only has the one reponse member."
	INLINE 'this.js.generateContent( messages.$toJs() )
		.then( result => block.$value$( stGoogleaiContentResponse$class.$fromJs$( result.response ) ) )'.
!

