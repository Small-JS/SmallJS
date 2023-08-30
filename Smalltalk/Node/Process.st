CLASS Process EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

"Environment"

env
	^ JsObject fromJs: INLINE 'process.env'.
!
envAt: name
	^ String fromJs: INLINE 'process.env[ name.js ]'.
!
envAt: name put: value
	INLINE 'process.env[ name.js ] = value.js'.
!
envDeleteAt: name
	INLINE 'delete process.env[ name.js ]'.
!
cwd
	^ String fromJs: INLINE 'process.cwd()'.
!
