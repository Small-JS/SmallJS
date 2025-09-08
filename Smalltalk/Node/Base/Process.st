CLASS Process EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

"Arguments"

argv
	^ Array fromJsStrings: INLINE 'process.argv'
!

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

"Directory"

cwd
	^ String fromJs: INLINE 'process.cwd()'.
!

"Process"

exit: code
	INLINE 'process.exit( code.js )'.
!

"Platform"

platform
	^ String fromJs: INLINE 'process.platform'.
!
isWindows
	^ self platform = 'win32'.
!
