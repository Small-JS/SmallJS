CLASS ServerResonse EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''

METHODS

send: object
	INLINE 'this.js.send( object.$toJs() )'.
!
sendStatus: status message: message
	INLINE 'this.js.status( status.js ).json( { message: message.js } )'
!
end
	INLINE 'this.js.end()'.
!
