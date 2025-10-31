CLASS Express EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''
	"This class implements the Express framework.
	 Variable 'js' will contain an instance of the express() application object (function)'."

INLINE 'import express from "express";'
INLINE 'import cors from "express";'
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
	INLINE 'this.js.use( cors() )'.
!
static: path
	"Serve static files with from path."
	INLINE 'this.js.use( express.static( path.js ) )'.
!
