CLASS Error EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Variable js encapsulates the JS class: Error."

CLASSMETHODS

throw: message
	INLINE 'throw new Error( message.$toString().js )'.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
message
	^ String fromJs: INLINE 'this.js.message'.
!
toString
	^ 'Error: ', self name, ': ', self message.
!
throw
	INLINE 'throw new this.js'.
!
