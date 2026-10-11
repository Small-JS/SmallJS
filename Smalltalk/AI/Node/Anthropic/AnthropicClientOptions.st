CLASS AnthropicClientOptions EXTENDS JsObject MODULE AiAnthropic CLASSVARS '' VARS ''

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

authToken
	^ String fromJs: INLINE 'this.js.authToken'.
!
authToken: authToken
	INLINE 'this.js.authToken = authToken.js'.
!
profile
	^ String fromJs: INLINE 'this.js.profile'.
!
profile: profile
	INLINE 'this.js.profile = profile.js'.
!
webhookKey
	^ String fromJs: INLINE 'this.js.webhookKey'.
!
webhookKey: webhookKey
	INLINE 'this.js.webhookKey = webhookKey.js'.
!
defaultHeaders
	^ Headers fromJs: INLINE 'this.js.defaultHeaders'.
!
defaultHeaders: defaultHeaders
	INLINE 'this.js.defaultHeaders = defaultHeaders.js'.
!
defaultQuery
	^ Object fromJs: INLINE 'this.js.defaultQuery'.
!
defaultQuery: defaultQuery
	"Argument is an Object with string properties."
	INLINE 'this.js.defaultQuery = defaultQuery.$toJs()'.
!
dangerouslyAllowBrowser
	^ Boolean fromJs: INLINE 'this.js.dangerouslyAllowBrowser'.
!
dangerouslyAllowBrowser: dangerouslyAllowBrowser
	INLINE 'this.js.dangerouslyAllowBrowser = dangerouslyAllowBrowser.js'.
!
logLevel
	"One of: 'off', 'error', 'warn', 'info', 'debug'."
	^ String fromJs: INLINE 'this.js.logLevel'.
!
logLevel: logLevel
	INLINE 'this.js.logLevel = logLevel.js'.
!

"Not implemented, because they are JS functions or complex objects:
 credentials, config, fetchOptions, fetch, middleware, logger."
