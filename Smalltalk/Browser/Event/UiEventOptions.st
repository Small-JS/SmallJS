CLASS UiEventOptions EXTENDS EventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a UIEvent instance."

METHODS

detail
	^ Integer fromJs: INLINE 'this.js.detail'.
!
detail: detail
	INLINE 'this.js.detail = detail.js'.
!
view
	^ Window fromJs: INLINE 'this.js.view'.
!
view: view
	INLINE 'this.js.view = view.js'.
!
