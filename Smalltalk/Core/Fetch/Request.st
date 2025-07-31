CLASS Request EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Implements the JS Request API used inn the JS fetch() API in browsers."

CLASSMETHODS

new
	self error: 'Create a new Request with method: Request.url:[options:]'.
!
url: url
	^ self fromJs: INLINE 'new Request( url.js )'.
!
url: url options: requestInit
	^ self fromJs: INLINE 'new Request( url.js, requestInit.js )'.
!

METHODS

"Properties"

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
keepalive
	^ Boolean fromJs: INLINE 'this.js.keepalive'.
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

"Copying"

clone
	Request fromJs: INLINE 'this.js.clone()'.
!

"Reading body"

arrayBufferThen: block
	INLINE 'this.js.arrayBuffer().then( buffer =>
		block.$value$( stArrayBuffer$class.$fromJs$( buffer ) ) )'.
!
blobThen: block
	INLINE 'this.js.blob().then( blob =>
		block.$value$( stBlob$class.$fromJs$( blob ) ) )'.
!
bytesThen: block
	INLINE 'this.js.bytes().then( bytes =>
		block.$value$( stUint8Array$class.$fromJs$( bytes ) ) )'.
!
textThen: block
	INLINE 'this.js.text().then( string =>
		block.$value$( stString$class.$fromJs$( string ) ) )'.
!
jsonThen: block
	INLINE 'this.js.json().then( object =>
		block.$value$( stObject$class.$fromJs$( object ) ) )'.
!
formDataThen: block
	INLINE 'this.js.formData().then( formData =>
		block.$value$( stFormData$class.$fromJs$( formData ) ) )'.
!
