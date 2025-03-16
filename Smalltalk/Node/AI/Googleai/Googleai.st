CLASS Googleai EXTENDS Ai MODULE Ai CLASSVARS '' VARS ''

"This class implements the JS class GoogleGenerativeAI"

INLINE 'import { GoogleGenerativeAI, GenerativeModel } from "@google/generative-ai";'

CLASSMETHODS

new
	| apiKey |
	apiKey := self apiKey.
	apiKey ifNil: [
		self error: 'Environment variable not set: GOOGLEAI_API_KEY' ].

	^ self fromJs: INLINE 'new GoogleGenerativeAI( apiKey.js )'.
!

"Testing"

available
	^ self apiKey notNil.
!

"Key"

apiKey
	^ Process envAt: 'GOOGLEAI_API_KEY'.
!

METHODS

"Accessing"

myApiKey
	^ String fromJs: INLINE 'this.js.apiKey'.
!

"Models"

models
	| modelsString |
	modelsString := Process envAt: 'GOOGLEAI_MODELS'.
	modelsString ifNil: [ ^ #( 'gemini-2.0-flash-lite' ) ].  "Default"
	^ modelsString split: ' '.
!

generativeModel: params
	^ GoogleaiModel fromJs: INLINE 'this.js.getGenerativeModel( params.js )'.
!

"Chat"

chat: content then: block
	| params generativeModel |

	params := GoogleaiModelParams new model: self model.
	generativeModel := self generativeModel: params.
	generativeModel generateContent: content
		then: [ :response | block value: response text ].
!

