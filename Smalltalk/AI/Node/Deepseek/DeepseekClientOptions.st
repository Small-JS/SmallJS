CLASS DeekseepClientOptions EXTENDS OpenaiClientOptions MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	self newEmpty
		baseUrl: ( Environment at: 'DEEPSEEK_BASE_URL' );
		apiKey: ( Environment at: 'DEEPSEEK_API_KEY' );
		organization: ( Environment at: 'DEEPSEEK_ORG_ID' );
		project: ( Environment at: 'DEEPSEEK_PROJECT_ID' ).
!
