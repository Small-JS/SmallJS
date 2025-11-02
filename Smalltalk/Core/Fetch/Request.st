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

"Reading body as types"

async arrayBuffer
	^ ArrayBuffer fromJs: INLINE 'await this.js.arrayBuffer()'.
!
async blob
	^ Blob fromJs: INLINE 'await this.js.blob()'.
!
async bytes
	^ Uint8Array fromJs: INLINE 'await this.js.bytes()'.
!
async text
	^ String fromJs: INLINE 'await this.js.text()'.
!
async json
	^ Object fromJs: INLINE 'await this.js.json()'.
!
async formData
	^ FormData fromJs: INLINE 'await this.js.formData()'.
!
