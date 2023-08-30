CLASS IncomingMessage EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''

METHODS

query
	^ JsObject fromJs: INLINE 'this.js.query'.
!
