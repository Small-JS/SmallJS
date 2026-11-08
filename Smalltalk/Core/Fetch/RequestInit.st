CLASS RequestInit  EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

	"Implements the JS object that can be sent with a request.
	 The Request object cannot be changed after it was created with these options.
	 The setter methods create properties in the contained JS object,
	 that cannot be unset but can be changed."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

"Properties"

body
	"Returns the body as a String, ArrayBuffer or Blob, or nil if not set.
	 Other body types are not supported yet."
	| jsBody |
	jsBody := INLINE 'this.js.body'.
	INLINE 'if( jsBody == null ) return stNil$'.
	( Boolean fromJs: INLINE 'typeof jsBody === "string"' ) ifTrue: [
		^ String fromJs: jsBody ].
	( Boolean fromJs: INLINE 'jsBody instanceof ArrayBuffer' ) ifTrue: [
		^ ArrayBuffer fromJs: jsBody ].
	( Boolean fromJs: INLINE 'jsBody instanceof Blob' ) ifTrue: [
		^ Blob fromJs: jsBody ].
	self error: 'Unsupported RequestInit body type: ',
		( String fromJs: INLINE '( jsBody.constructor ? jsBody.constructor.name : typeof jsBody )' ).
!
body: body
	INLINE 'this.js.body = body.js'.
!
cache
	^ String fromJs: INLINE 'this.js.cache'.
!
cache: cache
	INLINE 'this.js.cache = cache.js'.
!
credentials
	^ String fromJs: INLINE 'this.js.credentials'.
!
credentials: credentials
	INLINE 'this.js.credentials = credentials.js'.
!
headers
	^ Headers fromJs: INLINE 'this.js.headers'.
!
headers: headers
	INLINE 'this.js.headers = headers.js'.
!
integrity
	^ String fromJs: INLINE 'this.js.integrity'.
!
integrity: integrity
	INLINE 'this.js.integrity = integrity.js'.
!
keepalive
	^ Boolean fromJs: INLINE 'this.js.keepalive'.
!
keepalive: keepalive
	INLINE 'this.js.keepalive = keepalive.js'.
!
method
	^ String fromJs: INLINE 'this.js.method'.
!
method: method
	INLINE 'this.js.method = method.js'.
!
mode
	^ String fromJs: INLINE 'this.js.mode'.
!
mode: mode
	INLINE 'this.js.mode = mode.js'.
!
priority
	^ String fromJs: INLINE 'this.js.priority'.
!
priority: priority
	INLINE 'this.js.priority = priority.js'.
!
redirect
	^ String fromJs: INLINE 'this.js.redirect'.
!
redirect: redirect
	INLINE 'this.js.redirect = redirect.js'.
!
referrer
	^ String fromJs: INLINE 'this.js.referrer'.
!
referrer: referrer
	INLINE 'this.js.referrer = referrer.js'.
!
referrerPolicy
	^ String fromJs: INLINE 'this.js.referrerPolicy'.
!
referrerPolicy: referrerPolicy
	INLINE 'this.js.referrerPolicy = referrerPolicy.js'.
!
signal
	^ AbortSignal fromJs: INLINE 'this.js.signal'.
!
signal: signal
	INLINE 'this.js.signal = signal.js'.
!
