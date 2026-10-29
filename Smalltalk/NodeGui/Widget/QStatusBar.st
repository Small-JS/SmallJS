CLASS QStatusBar EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"A horizontal bar for status information, set on a window with QMainWindow setStatusBar:.
 It shows a temporary message on the left, normal widgets after it,
 and permanent widgets on the right, that are not hidden by messages."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QStatusBar()'.
!

METHODS

"Messages"

showMessage: message
	"Show message until it is cleared or replaced."
	INLINE 'this.js.showMessage( message.js )'.
!
showMessage: message timeout: timeout
	"Show message for timeout milliseconds."
	INLINE 'this.js.showMessage( message.js, timeout.js )'.
!
clearMessage
	INLINE 'this.js.clearMessage()'.
!
currentMessage
	^ String fromJs: INLINE 'this.js.currentMessage()'.
!

"Widgets"

addWidget: widget
	self addWidget: widget stretch: 0.
!
addWidget: widget stretch: stretch
	"A normal widget is hidden by a temporary message."
	INLINE 'this.js.addWidget( widget.js, stretch.js )'.
!
insertWidget: widget at: index
	"Answer the index of widget."
	^ Integer fromJs: INLINE 'this.js.insertWidget( index.js, widget.js )'.
!
addPermanentWidget: widget
	self addPermanentWidget: widget stretch: 0.
!
addPermanentWidget: widget stretch: stretch
	INLINE 'this.js.addPermanentWidget( widget.js, stretch.js )'.
!
insertPermanentWidget: widget at: index
	"Index counts all widgets, the permanent widgets come after the normal widgets.
	 If index is out of range, widget is added at the end. Answer the index of widget."
	^ Integer fromJs: INLINE 'this.js.insertPermanentWidget( index.js, widget.js )'.
!
removeWidget: widget
	"Remove and hide widget. It is not deleted."
	INLINE 'this.js.removeWidget( widget.js )'.
!

"Options"

setSizeGripEnabled: enabled
	"The size grip in the bottom right corner resizes the window."
	INLINE 'this.js.setSizeGripEnabled( enabled.js )'.
!
isSizeGripEnabled
	^ Boolean fromJs: INLINE 'this.js.isSizeGripEnabled()'.
!

"Events"

onMessageChange: block
	"Block is called when the temporary message changes, also when it is cleared."
	self addEventListener: 'messageChanged' then: [ block value ].
!
