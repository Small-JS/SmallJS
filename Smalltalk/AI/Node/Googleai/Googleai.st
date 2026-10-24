CLASS Googleai EXTENDS Ai MODULE AiGoogleai CLASSVARS '' VARS ''

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

METHODS

"Accessing"

apiKey
	^ String fromJs: INLINE 'this.js.apiKey'.
!

generativeModel: params
	"Uses the base URL in GOOGLEAI_BASE_URL. If nil, the SDK uses its default base URL."
	| baseUrl |
	baseUrl := self class baseUrl.
	^ GoogleaiModel fromJs: INLINE 'this.js.getGenerativeModel( params.js, { baseUrl: baseUrl.js } )'.
!

"Chat"

async chat: messages model: aModel
	| params generativeModel response |

	params := GoogleaiModelParams new model: aModel.
	generativeModel := self generativeModel: params.
	response := await generativeModel generateContent: messages.
	^ response text.
!
