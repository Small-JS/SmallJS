CLASS Response EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Implements the JS Response API used in the JS fetch() API in browsers."

CLASSMETHODS

error
	^ Response fromJs: INLINE 'Response.error()'.
!
json: data
	^ Response fromJs: INLINE 'Response.json( data.js )'.
!
redirect: url
	^ Response fromJs: INLINE 'Response.json( url.js )'.
!

METHODS

"Properties"

body
	^ ReadableStream fromJs: INLINE 'this.js.body'.
!
bodyUsed
	^ Boolean fromJs: INLINE 'this.js.bodyUsed'.
!
bodyUsed: aBool
	INLINE 'this.js.bodyUsed = aBool.js'.
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

textThen: block
	INLINE 'this.js.text().then( string =>
		block.$value$( stString$class.$fromJs$( string ) ) )'.
!
bytesThen: block
	INLINE 'this.js.bytes().then( uint8Array =>
		block.$value$( stUint8Array$class.$fromJs$( uint8Array ) ) )'.
!
arrayBufferThen: block
	INLINE 'this.js.arrayBuffer().then( buffer =>
		block.$value$( stArrayBuffer$class.$fromJs$( buffer ) ) )'.
!
blobThen: block
	INLINE 'this.js.blob().then( blob =>
		block.$value$( stBlob$class.$fromJs$( blob ) ) )'.
!
jsonThen: block
	INLINE 'this.js.json().then( object =>
		block.$value$( stObject$class.$fromJs$( object ) ) )'.
!
formDataThen: block
	INLINE 'this.js.formData().then( formData =>
		block.$value$( stFormData$class.$fromJs$( buffer ) ) )'.
!

"Cookies"

cookie
	^ String fromJs: INLINE 'this.js.headers.get( "set-cookie" )'.
!
