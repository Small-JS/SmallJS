CLASS Deepseek EXTENDS Openai MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	| baseUrl apiKey |
	baseUrl := Process envAt: 'DEEPSEEK_BASE_URL'.
	apiKey := Process envAt: 'DEEPSEEK_API_KEY'.
	^ self fromJs: INLINE 'new OpenAI( { baseURL: baseUrl.js, apiKey: apiKey.js } )'.
!

"Models"

models
	| modelsString |
	modelsString := Process envAt: 'DEEPSEEK_MODELS'.
	modelsString ifNil: [ ^ #( 'deepseek-chat' ) ].  "Default"
	^ modelsString split: ' '.
!

METHODS

