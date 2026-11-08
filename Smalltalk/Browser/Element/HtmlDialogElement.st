CLASS HtmlDialogElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLDialogElement.
	 Not implemented: closedBy, because it is not supported by all major browsers."

METHODS

"Properties"

open
	^ Boolean fromJs: INLINE 'this.js.open'.
!
open: open
	"Note: Use show, showModal and close instead of setting open directly,
	 because setting it does not send events or change the modal state."
	INLINE 'this.js.open = open.js'.
!
returnValue
	"The value passed to close: or requestClose:, or the value of the button that submitted
	 a form with method 'dialog' in the dialog."
	^ String fromJs: INLINE 'this.js.returnValue'.
!
returnValue: returnValue
	INLINE 'this.js.returnValue = returnValue.js'.
!

"Methods"

show
	"Show the dialog non-modal: the rest of the page can still be used."
	INLINE 'this.js.show()'.
!
showModal
	"Show the dialog modal, on top of the page, that cannot be used until the dialog is closed.
	 The dialog must be connected to a document."
	INLINE 'this.js.showModal()'.
!
close
	INLINE 'this.js.close()'.
!
close: returnValue
	INLINE 'this.js.close( returnValue.js )'.
!
requestClose
	"Send a cancel event first, that can prevent closing the dialog."
	INLINE 'this.js.requestClose()'.
!
requestClose: returnValue
	INLINE 'this.js.requestClose( returnValue.js )'.
!

"Events"

onCancel: block
	"Block is called with an Event when the user presses Escape, or requestClose is called.
	 Call preventDefault on the event to keep the dialog open."
	self addEventListener: 'cancel' then: block.
!
onClose: block
	"Block is called with an Event after the dialog is closed."
	self addEventListener: 'close' then: block.
!
