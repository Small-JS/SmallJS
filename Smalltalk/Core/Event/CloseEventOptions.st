CLASS CloseEventOptions EXTENDS EventOptions MODULE Core CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a CloseEvent instance."

METHODS

code
	^ Integer fromJs: INLINE 'this.js.code'.
!
code: code
	INLINE 'this.js.code = code.js'.
!
reason
	^ String fromJs: INLINE 'this.js.reason'.
!
reason: reason
	INLINE 'this.js.reason = reason.js'.
!
wasClean
	^ Boolean fromJs: INLINE 'this.js.wasClean'.
!
wasClean: wasClean
	INLINE 'this.js.wasClean = wasClean.js'.
!
