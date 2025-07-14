CLASS Error EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Variable js encapsulates the JS class: Error."

CLASSMETHODS

new
	^ super new js: INLINE 'new Error()'.
!
new: message
	^ self fromJs: INLINE 'new Error( message.$toString().js )'.
!
new: message cause: cause
	^ self fromJs: INLINE 'new Error( message.$toString().js, { cause: cause.js } )'.
!
throw: message
	INLINE 'throw new Error( message.$toString().js )'.
!

METHODS

"Properties"

name
	^ String fromJs: INLINE 'this.js.name'.
!
message
	^ String fromJs: INLINE 'this.js.message'.
!
message: message
	INLINE 'this.js.message = message.js'.
!
cause
	^ Error fromJs: INLINE 'this.js.cause'.
!
cause: cause
	INLINE 'this.js.cause = cause.js'.
!

"Conversion"

toString
	^ 'Error: ', self name, ': ', self message.
!

"Handling"

throw
	INLINE 'throw this.js'.
!
