CLASS OsConstants EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

"Constant values can be retrieved by calling: atJsProperty: '<constant name>'
 on the objects returned from methods 'errno', 'signals' and 'priority'.
 Constant names can be found here:
	https://nodejs.org/api/os.html#osconstants"

CLASSMETHODS

errno
	^ JsObject fromJs: INLINE 'os$.constants.errno'.
!
signals
	^ JsObject fromJs: INLINE 'os$.constants.signals'.
!
priority
	^ JsObject fromJs: INLINE 'os$.constants.priority'.
!

