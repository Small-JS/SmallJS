CLASS HtmlDetailsElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLDetailsElement."

METHODS

open
	"If true, the details are shown, else only the summary."
	^ Boolean fromJs: INLINE 'this.js.open'.
!
open: open
	INLINE 'this.js.open = open.js'.
!
name
	"Details elements with the same name form a group, in which only one can be open at a time."
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!

"Events"

onToggle: block
	"Block is called with an Event after the details are opened or closed.
	 The event is sent asynchronously."
	self addEventListener: 'toggle' then: block.
!
