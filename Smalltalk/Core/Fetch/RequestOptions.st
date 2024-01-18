CLASS RequestOptions  EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

	"Implements the JS object that can be sent with a request.
	 The Request object cannot be changed after it was created with these options.
	 The setter methods creates properties in the containted JS object,
	 that cannot be unset but can be changed."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

method
	^ String fromJs: INLINE 'this.js.method'.
!
method: method
	INLINE 'this.js.method = method.js'.
!
headers
	^ Headers fromJs: INLINE 'this.js.headers'.
!
headers: headers
	INLINE 'this.js.headers = headers.js'.
!
body
	^ ArrayBuffer fromJs: INLINE 'this.js.body'.
!
body: body
	INLINE 'this.js.body = body.js'.
!
mode
	^ String fromJs: INLINE 'this.js.mode'.
!
mode: mode
	INLINE 'this.js.mode = mode.js'.
!
credentials
	^ String fromJs: INLINE 'this.js.credentials'.
!
credentials: credentials
	INLINE 'this.js.credentials = credentials.js'.
!
cache
	^ String fromJs: INLINE 'this.js.cache'.
!
cache: cache
	INLINE 'this.js.cache = cache.js'.
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
signal
	^ AbortSignal fromJs: INLINE 'this.js.signal'.
!
signal: signal
	INLINE 'this.js.signal = signal.js'.
!
priority
	^ String fromJs: INLINE 'this.js.priority'.
!
priority: priority
	INLINE 'this.js.priority = priority.js'.
!

