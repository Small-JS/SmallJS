CLASS CloseEvent EXTENDS Event MODULE Core CLASSVARS '' VARS ''
	"Encapsulates the JS CloseEvent class:
	 sent to clients using WebSockets when the connection is closed."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new CloseEvent( type.js )'.
!
type: type options: options
	"Options is a CloseEventOptions instance."
	^ self fromJs: INLINE 'new CloseEvent( type.js, options.js )'.
!

METHODS

code
	"The close code sent by the server."
	^ Integer fromJs: INLINE 'this.js.code'.
!
reason
	"The reason the server closed the connection. Specific to the server."
	^ String fromJs: INLINE 'this.js.reason'.
!
wasClean
	"True if the connection closed cleanly."
	^ Boolean fromJs: INLINE 'this.js.wasClean'.
!
