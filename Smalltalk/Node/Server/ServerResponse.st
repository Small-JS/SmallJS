CLASS ServerResponse EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''
	"Implements the ServerResponse class from Node.js module 'http',
	 extended by Express with methods like send, json and redirect.
	 The modifying methods answer self, so they can be cascaded, e.g.:
	 response status: 201; json: object."

METHODS

"Status and headers"

status
	^ Integer fromJs: INLINE 'this.js.statusCode'.
!
status: status
	INLINE 'this.js.status( status.js )'.
!
setHeader: name value: value
	INLINE 'this.js.setHeader( name.js, value.$toJs() )'.
!
getHeader: name
	^ Object fromJs: INLINE 'this.js.getHeader( name.js )'.
!
headersSent
	^ Boolean fromJs: INLINE 'this.js.headersSent'.
!

"Sending"

send: object
	INLINE 'this.js.send( object.$toJs() )'.
!
json: object
	"Send object as JSON, also if it is a String."
	INLINE 'this.js.json( object.$toJs() )'.
!
sendStatus: status message: message
	INLINE 'this.js.status( status.js ).json( { message: message.js } )'.
!
redirect: url
	"Redirect with status 302 (Found)."
	INLINE 'this.js.redirect( url.js )'.
!
redirect: url status: status
	INLINE 'this.js.redirect( status.js, url.js )'.
!
end
	INLINE 'this.js.end()'.
!
