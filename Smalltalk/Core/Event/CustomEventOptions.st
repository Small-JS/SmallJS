CLASS CustomEventOptions EXTENDS EventOptions MODULE Core CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a CustomEvent instance."

METHODS

detail
	^ JsObject fromJs: INLINE 'this.js.detail'.
!
detail: detail
	INLINE 'this.js.detail = detail.$toJs()'.
!
