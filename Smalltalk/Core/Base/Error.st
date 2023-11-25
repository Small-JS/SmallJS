CLASS Error EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Variable js encapsulates the JS class: Error."

CLASSMETHODS

new
	^ super new js: INLINE 'new Error()'.
!
new: message
	^ self fromJs: INLINE 'new Error( message.$toString().js )'.
!
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
message: message
	INLINE 'this.js.message = message.js'.
!
toString
	^ 'Error: ', self name, ': ', self message.
!
throw
	INLINE 'throw this.js'.
!
