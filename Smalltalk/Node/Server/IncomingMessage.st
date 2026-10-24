CLASS IncomingMessage EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''

METHODS

"Original"

body
	"Answer the request body as ST object, if parsed by a body parser like Express>>useJson.
	 Otherwise answer nil."
	^ Object fromJs: INLINE 'this.js.body'.
!
headers
	^ Headers fromJs: INLINE 'this.js.headers'.
!
method
	^ String fromJs: INLINE 'this.js.method'.
!
query
	^ Object fromJs: INLINE 'this.js.query'.
!
session
	^ Session fromJs: INLINE 'this.js.session'.
!
sessionId
	^ String fromJs: INLINE 'this.js.sessionID'.
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
