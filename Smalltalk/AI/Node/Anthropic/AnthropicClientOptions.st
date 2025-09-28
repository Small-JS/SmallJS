CLASS AnthropicClientOptions EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty
		baseUrl: ( Environment at: 'ANTHROPIC_BASE_URL' );
		apiKey: ( Environment at: 'ANTHROPIC_API_KEY' ).
!

METHODS

baseUrl
	^ String fromJs: INLINE 'this.js.baseURL'.
!
baseUrl: baseUrl
	INLINE 'this.js.baseURL = baseUrl.js'.
!
apiKey
	^ String fromJs: INLINE 'this.js.apiKey'.
!
apiKey: apiKey
	INLINE 'this.js.apiKey = apiKey.js'.
!
maxRetries
	^ Integer fromJs: INLINE 'this.js.maxRetries'.
!
maxRetries: maxRetries
	INLINE 'this.js.maxRetries = maxRetries.js'.
!
timeout
	^ Integer fromJs: INLINE 'this.js.timeout'.
!
timeout: timeout
	INLINE 'this.js.timeout = timeout.js'.
!

"TODO: Implement more options."
