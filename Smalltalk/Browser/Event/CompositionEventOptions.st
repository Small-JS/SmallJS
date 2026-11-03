CLASS CompositionEventOptions EXTENDS UiEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a CompositionEvent instance."

METHODS

data
	^ String fromJs: INLINE 'this.js.data'.
!
data: data
	INLINE 'this.js.data = data.js'.
!
