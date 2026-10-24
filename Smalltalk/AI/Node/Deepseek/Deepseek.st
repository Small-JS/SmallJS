CLASS Deepseek EXTENDS Openai MODULE AiOpenai CLASSVARS '' VARS ''

CLASSMETHODS

new
	| baseUrl apiKey |
	baseUrl := Environment at: 'DEEPSEEK_BASE_URL'.
	apiKey := Environment at: 'DEEPSEEK_API_KEY'.
	^ self fromJs: INLINE 'new OpenAI( { baseURL: baseUrl.js, apiKey: apiKey.js } )'.
!

"Models"

models
	"Default to deepseek-chat if DEEPSEEK_MODELS is not set."
	| models |
	models := self modelsFor: '_MODELS'.
	models isEmpty ifTrue: [ ^ #( 'deepseek-chat' ) ].
	^ models.
!

METHODS

