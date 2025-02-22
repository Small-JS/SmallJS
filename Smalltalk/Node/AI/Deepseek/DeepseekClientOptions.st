CLASS DeekseepClientOptions EXTENDS OpenaiClientOptions MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	self newEmpty
		baseUrl: ( Process envAt: 'DEEPSEEK_BASE_URL' );
		apiKey: ( Process envAt: 'DEEPSEEK_API_KEY' );
		organization: ( Process envAt: 'DEEPSEEK_ORG_ID' );
		project: ( Process envAt: 'DEEPSEEK_PROJECT_ID' ).
!
