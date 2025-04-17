CLASS OpenaiClientOptions EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty
		baseUrl: ( Process envAt: 'OPENAI_BASE_URL' );
		apiKey: ( Process envAt: 'OPENAI_API_KEY' );
		organization: ( Process envAt: 'OPENAI_ORG_ID' );
		project: ( Process envAt: 'OPENAI_PROJECT_ID' ).
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
organization
	^ String fromJs: INLINE 'this.js.organization'.
!
organization: organization
	INLINE 'this.js.organization = organization.js'.
!
project
	^ String fromJs: INLINE 'this.js.project'.
!
project: project
	INLINE 'this.js.project = project.js'.
!
