CLASS PromiseStatus EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

METHODS

status
	^ String fromJs: INLINE 'this.js.status'.
!
value
	^ Nil fromJs: INLINE 'this.js.value'.
!
reason
	^ Nil fromJs: INLINE 'this.js.reason'.
!
