CLASS IncomingMessage EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''
	"Implements the IncomingMessage class from Node.js module 'http',
	 extended by Express with properties like body, query and session."

INLINE 'import * as consumers from "node:stream/consumers";'
INLINE 'import { Readable } from "node:stream";'

METHODS

"Original"

body
	"Answer the request body as ST object, if parsed by a body parser like Express>>useJson.
	 Otherwise answer nil."
	^ Object fromJs: INLINE 'this.js.body'.
!
headers
	"Node.js answers the headers as plain JS object, so convert it to Headers.
	 Repeated headers, like set-cookie, are joined with ', '."
	^ Headers fromJs: INLINE 'new Headers( this.js.headers )'.
!
method
	^ String fromJs: INLINE 'this.js.method'.
!
params
	"Answer the route parameters as ST object.
	 E.g. for route '/products/:id' and URL '/products/42?x=1', property 'id' is '42'."
	^ Object fromJs: INLINE 'this.js.params'.
!
path
	"Answer the path part of the URL, e.g. '/products/42' for URL '/products/42?x=1'."
	^ String fromJs: INLINE 'this.js.path'.
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

"Reading the body.
 The body is a stream that can be read only once,
 and not at all if it was already parsed by a body parser like Express>>useJson."

arrayBufferThen: block
	ArrayBuffer. "Force import."
	INLINE 'consumers.arrayBuffer( this.js ).then( buffer =>
		block.$value$( stArrayBuffer$class.$fromJs$( buffer ) ) )'.
!
blobThen: block
	Blob. "Force import."
	INLINE 'consumers.blob( this.js ).then( blob =>
		block.$value$( stBlob$class.$fromJs$( blob ) ) )'.
!
formDataThen: block
	"Parse a 'multipart/form-data' or 'application/x-www-form-urlencoded' body,
	 using the Fetch Response class."
	FormData. "Force import."
	INLINE 'new Response( Readable.toWeb( this.js ),
		{ headers: { "content-type": this.js.headers[ "content-type" ] ?? "" } } )
		.formData().then( formData =>
			block.$value$( stFormData$class.$fromJs$( formData ) ) )'.
!
jsonThen: block
	INLINE 'consumers.json( this.js ).then( object =>
		block.$value$( stObject$class.$fromJs$( object ) ) )'.
!
textThen: block
	INLINE 'consumers.text( this.js ).then( string =>
		block.$value$( stString$class.$fromJs$( string ) ) )'.
!
