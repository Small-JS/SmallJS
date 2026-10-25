CLASS Response EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Implements the JS Response API used in the JS fetch() API in browsers."

CLASSMETHODS

error
	^ Response fromJs: INLINE 'Response.error()'.
!
json: data
	"Data is converted to JS first, so ST objects and collections give the expected JSON."
	^ Response fromJs: INLINE 'Response.json( data.$toJs() )'.
!
redirect: url
	^ Response fromJs: INLINE 'Response.redirect( url.js )'.
!

METHODS

"Properties"

body
	^ ReadableStream fromJs: INLINE 'this.js.body'.
!
bodyUsed
	^ Boolean fromJs: INLINE 'this.js.bodyUsed'.
!
headers
	^ Headers fromJs: INLINE 'this.js.headers'.
!
ok
	^ Boolean fromJs: INLINE 'this.js.ok'.
!
redirected
	^ Boolean fromJs: INLINE 'this.js.redirected'.
!
status
	^ Integer fromJs: INLINE 'this.js.status'.
!
statusText
	^ String fromJs: INLINE 'this.js.statusText'.
!
statusAndText
	^ self status toString, ': ', self statusText.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
url
	^ String fromJs: INLINE 'this.js.url'.
!

"Copying"

clone
	^ Response fromJs: INLINE 'this.js.clone()'.
!

"Conversion"

async text
	^ String fromJs: INLINE 'await this.js.text()'.
!
async bytes
	^ Uint8Array fromJs: INLINE 'await this.js.bytes()'.
!
async arrayBuffer
	^ ArrayBuffer fromJs: INLINE 'await this.js.arrayBuffer()'.
!
async blob
	^ Blob fromJs: INLINE 'await this.js.blob()'.
!
async json
	^ Object fromJs: INLINE 'await this.js.json()'.
!
async formData
	^ FormData fromJs: INLINE 'await this.js.formData()'.
!

"Cookies"

cookie
	^ String fromJs: INLINE 'this.js.headers.get( "set-cookie" )'.
!
