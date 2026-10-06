CLASS ErrorEvent EXTENDS Event MODULE Core CLASSVARS '' VARS ''
	"Encapsulates the JS ErrorEvent class:
	 an error in a script, like a Worker script."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new ErrorEvent( type.js )'.
!
type: type options: options
	^ self fromJs: INLINE 'new ErrorEvent( type.js, options.$toJs() )'.
!

METHODS

message
	^ String fromJs: INLINE 'this.js.message'.
!
filename
	^ String fromJs: INLINE 'this.js.filename'.
!
lineno
	^ Integer fromJs: INLINE 'this.js.lineno'.
!
colno
	^ Integer fromJs: INLINE 'this.js.colno'.
!
error
	"The JS error object. Can be any JS value, or nil when unavailable."
	^ JsObject fromJs: INLINE 'this.js.error'.
!
