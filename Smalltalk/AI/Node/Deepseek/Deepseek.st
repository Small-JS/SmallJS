CLASS Deepseek EXTENDS Openai MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	| baseUrl apiKey |
	baseUrl := Environment at: 'DEEPSEEK_BASE_URL'.
	apiKey := Environment at: 'DEEPSEEK_API_KEY'.
	^ self fromJs: INLINE 'new OpenAI( { baseURL: baseUrl.js, apiKey: apiKey.js } )'.
!

"Models"

models
	| modelsString |
	modelsString := Environment at: 'DEEPSEEK_MODELS'.
	modelsString ifNil: [ ^ #( 'deepseek-chat' ) ].  "Default"
	^ modelsString split: ' '.
!

METHODS

