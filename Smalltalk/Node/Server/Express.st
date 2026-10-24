CLASS Express EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''
	"This class implements the Express framework.
	 Variable 'js' will contain an instance of the express() application object (function)'."

INLINE 'import express from "express";'
INLINE 'import session from "express-session";'

constructor
	INLINE 'this.js = express()'.
!
get: path then: block
	"Block should take 2 arguments, an IncomingMessage and a ServerResonse."

	"Force references to prevent minimizing."
	IncomingMessage.
	ServerResponse.

	INLINE 'this.js.get( path.js,
		( request, response ) => block.js(
			stIncomingMessage$class.$fromJs$( request ),
			stServerResponse$class.$fromJs$( response ) ) )'.
!
post: path then: block
	"Block should take 2 arguments, an IncomingMessage and a ServerResonse.
	 Use useJson to make a JSON request body available with IncomingMessage>>body."

	"Force references to prevent minimizing."
	IncomingMessage.
	ServerResponse.

	INLINE 'this.js.post( path.js,
		( request, response ) => block.js(
			stIncomingMessage$class.$fromJs$( request ),
			stServerResponse$class.$fromJs$( response ) ) )'.
!
listen: port then: block
	Error. "Force import."
	^ Server fromJs: INLINE 'this.js.listen( port.js, ( error ) => block.js( stError$class.$fromJs$( error ) ) )'.
!
useSession
	| key |
	key := Crypto randomUuid.
	INLINE 'this.js.use( session( { secret: key.js, resave: false, saveUninitialized: true } ) );'.
!
useCors
	"Allow cross-origin requests from any origin, with the defaults of npm module 'cors':
	 header Access-Control-Allow-Origin '*' on all responses,
	 and preflight (OPTIONS) requests are answered with status 204.
	 Implemented here, so the module does not need to be installed."
	INLINE 'this.js.use( ( request, response, next ) => {
		response.setHeader( "Access-Control-Allow-Origin", "*" );
		if( request.method !== "OPTIONS" ) return next();
		response.setHeader( "Access-Control-Allow-Methods", "GET,HEAD,PUT,PATCH,POST,DELETE" );
		const requestHeaders = request.headers[ "access-control-request-headers" ];
		if( requestHeaders ) {
			response.setHeader( "Access-Control-Allow-Headers", requestHeaders );
			response.setHeader( "Vary", "Access-Control-Request-Headers" ); }
		response.setHeader( "Content-Length", "0" );
		response.status( 204 ).end(); } )'.
!
useJson
	"Parse request bodies with content type 'application/json'.
	 Invalid JSON is answered with status 400 (Bad Request) and a JSON error message,
	 without logging the error stack like the default Express error handler does."
	INLINE 'this.js.use( express.json() )'.
	INLINE 'this.js.use( ( error, request, response, next ) =>
		error.type === "entity.parse.failed"
			? response.status( 400 ).json( { message: error.message } )
			: next( error ) )'.
!
static: path
	"Serve static files with from path."
	INLINE 'this.js.use( express.static( path.js ) )'.
!
