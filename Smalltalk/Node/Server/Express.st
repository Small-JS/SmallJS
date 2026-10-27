CLASS Express EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''
	"This class implements the Express framework.
	 Variable 'js' will contain an instance of the express() application object (function)'.

	 Handler blocks may be async: Express 5 passes errors of rejected promises to the error handler.
	 Route paths may contain parameters, like '/products/:id', see IncomingMessage>>params."

INLINE 'import express from "express";'
INLINE 'import session from "express-session";'

constructor
	INLINE 'this.js = express()'.
!

"Routing.
 Blocks should take 2 arguments, an IncomingMessage and a ServerResponse."

get: path then: block
	self route: 'get' path: path then: block.
!
post: path then: block
	"Use useJson or useUrlencoded to make the request body available with IncomingMessage>>body."
	self route: 'post' path: path then: block.
!
put: path then: block
	self route: 'put' path: path then: block.
!
patch: path then: block
	self route: 'patch' path: path then: block.
!
delete: path then: block
	self route: 'delete' path: path then: block.
!
all: path then: block
	"Route requests of all HTTP methods."
	self route: 'all' path: path then: block.
!
route: method path: path then: block
	"Force references to prevent minimizing."
	IncomingMessage.
	ServerResponse.

	INLINE 'this.js[ method.js ]( path.js,
		( request, response ) => block.js(
			stIncomingMessage$class.$fromJs$( request ),
			stServerResponse$class.$fromJs$( response ) ) )'.
!

"Middleware.
 Middleware and handlers are called in the order they are added."

use: block
	"Add middleware for all requests.
	 Block should take 3 arguments, an IncomingMessage, a ServerResponse and a next Block.
	 Evaluate 'next value' to continue with the next middleware or route,
	 or 'next value: error' to continue with the error handler.
	 Otherwise the block should send a response."
	self use: '/' then: block.
!
use: path then: block
	"Add middleware for requests with paths starting with path. See use:."
	IncomingMessage.
	ServerResponse.
	Block.

	INLINE 'this.js.use( path.js,
		( request, response, next ) => block.js(
			stIncomingMessage$class.$fromJs$( request ),
			stServerResponse$class.$fromJs$( response ),
			stBlock$class.$fromJs$( ( error ) => next( error?.js ) ) ) )'.
!
onNotFound: block
	"Handle requests that did not match any route.
	 Block should take 2 arguments, an IncomingMessage and a ServerResponse.
	 Add this after all routes."
	IncomingMessage.
	ServerResponse.

	INLINE 'this.js.use(
		( request, response ) => block.js(
			stIncomingMessage$class.$fromJs$( request ),
			stServerResponse$class.$fromJs$( response ) ) )'.
!
onError: block
	"Handle errors thrown by routes and middleware, also by async ones.
	 Block should take 3 arguments, an Error, an IncomingMessage and a ServerResponse.
	 Add this after all routes. Without it, Express logs the error stack
	 and answers with status 500 and an HTML error page."
	Error.
	IncomingMessage.
	ServerResponse.

	INLINE 'this.js.use(
		( error, request, response, next ) => block.js(
			stError$class.$fromJs$( error ),
			stIncomingMessage$class.$fromJs$( request ),
			stServerResponse$class.$fromJs$( response ) ) )'.
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
	 Implemented here, so the module does not need to be installed.
	 Call this before the other use* methods, so their responses also get the CORS header,
	 and preflight requests do not create sessions."
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
useUrlencoded
	"Parse request bodies with content type 'application/x-www-form-urlencoded',
	 as sent by HTML forms. Values are answered by IncomingMessage>>body as Strings."
	INLINE 'this.js.use( express.urlencoded() )'.
!
static: path
	"Serve static files from path."
	INLINE 'this.js.use( express.static( path.js ) )'.
!

"Server"

listen: port then: block
	Error. "Force import."
	^ Server fromJs: INLINE 'this.js.listen( port.js, ( error ) => block.js( stError$class.$fromJs$( error ) ) )'.
!
