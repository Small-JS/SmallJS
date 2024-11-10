CLASS WorkerOptions EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS object of creaeting a Worker instance."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js'.
!
credentials
	^ String fromJs: INLINE 'this.js.credentials'.
!
credentials: credentials
	INLINE 'this.js.credentials = credentials.js'.
!
