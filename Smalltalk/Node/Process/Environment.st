CLASS Environment EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Encapsulates the JS object returned by 'process.env'"

CLASSMETHODS

new
	^ INLINE 'process$.env'.
!
load: path
	INLINE 'process$.loadEnvFile( path.js )'.
!
at: name
	^ String fromJs: INLINE 'process$.env[ name.js ]'.
!
at: name put: value
	INLINE 'process$.env[ name.js ] = value.js'.
!
deleteAt: name
	INLINE 'delete process$.env[ name.js ]'.
!
