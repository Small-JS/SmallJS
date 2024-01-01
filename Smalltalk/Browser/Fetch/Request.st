CLASS Request EXTENDS JsObject MODULE DOM CLASSVARS '' VARS ''
	"Implements the JS Request API used inn the JS fetch() API in browsers."

CLASSMETHODS

url: url
	^ self fromJs: INLINE 'new Request( url.js )'.
!
url: url options: options
	^ self fromJs: INLINE 'new Request( url.js, options.js )'.
!

METHODS

body
	^ ReadableStream fromJs: INLINE 'this.body'.
!
bodyUsed
	^ Boolean fromJs: INLINE 'this.js.bodyUsed'.
!
bodyUsed: aBool
	INLINE 'this.js.bodyUsed = aBool.js'.
!
cache
	^ String fromJs: INLINE 'this.js.cache'.
!
credentials
	^ String fromJs: INLINE 'this.js.credentials'.
!
destination
	^ String fromJs: INLINE 'this.js.destination'.
!
headers
	^ Headers fromJs: INLINE 'this.js.headers'.
!
integrity
	^ String fromJs: INLINE 'this.js.integrity'.
!
method
	^ String fromJs: INLINE 'this.js.method'.
!
mode
	^ String fromJs: INLINE 'this.js.mode'.
!
redirect
	^ String fromJs: INLINE 'this.js.redirect'.
!
referrer
	^ String fromJs: INLINE 'this.js.referrer'.
!
referrerPolicy
	^ String fromJs: INLINE 'this.js.referrerPolicy'.
!
signal
	^ AbortSignal fromJs: INLINE 'this.js.signal'.
!
url
	^ String fromJs: INLINE 'this.js.url'.
!
arrayBufferThen: block
	INLINE 'this.js.arrayBuffer().then( buffer =>
		block.$value$( stArrayBuffer$class.$fromJs$( buffer ) ) )'.
!
blobThen: block
	INLINE 'this.js.blob().then( blob =>
		block.$value$( stBlob$class.$fromJs$( blob ) ) )'.
!
clone
	Request fromJs: INLINE 'this.js.clone()'.
!
formDataThen: block
	INLINE 'this.js.formData().then( formData =>
		block.$value$( stFormData$class.$fromJs$( formData ) ) )'.
!
jsonThen: block
	INLINE 'this.js.json().then( object =>
		block.$value$( stObject$class.$fromJs$( object ) ) )'.
!
textThen: block
	INLINE 'this.js.text().then( string =>
		block.$value$( stString$class.$fromJs$( string ) ) )'.
!
