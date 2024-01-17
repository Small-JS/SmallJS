CLASS Express EXTENDS JsObject MODULE Server CLASSVARS '' VARS 'port'
	"This class implements the Express framework.
	 Variable 'js' will contain an instance of the express() application object (function)'."

INLINE 'import express from "express";'
INLINE 'import cors from "express";'
INLINE 'import session from "express-session";'

METHODS

constructor
	INLINE 'this.js = express()'.
!
get: path then: block
	"Block should take 2 arguments, an IncomingMessage and a ServerResonse."

	INLINE 'this.js.get( path.js,
		( request, response ) => block.js(
			stIncomingMessage$class.$fromJs$( request ),
			stServerResonse$class.$fromJs$( response ) ) )'.
!
listen: port then: block
	Error. "Force import."
	^ Server fromJs: INLINE 'this.js.listen( port.js, ( error ) => block.js( stError$class.$fromJs$( error ) ) )'.
!
useSession
	| key |
	key := self generateSessionKey.
	INLINE 'this.js.use( session( { secret: key.js, resave: false, saveUninitialized: true } ) );'.
!
generateSessionKey
	| key |
	key := ''.
	8 timesRepeat: [
		key := key + ( ( Float random * 100 ) toInteger toString padStart: 2 with: '0' ) ].
	^ key.
!
useCors
	INLINE 'this.js.use( cors() )'.
!
static: path
	"Serve static files with from path."
	INLINE 'this.js.use( express.static( path.js ) )'.
!
