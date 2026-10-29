CLASS QFlexLayout EXTENDS QLayout MODULE NodeGui CLASSVARS '' VARS ''

"NodeGui's own layout, not a Qt class. It arranges widgets like CSS flexbox (using Yoga),
 configured with style sheet properties like flex-direction, justify-content and align-items.
 Set this layout on a widget with QWidget setLayout:, before adding widgets to it."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.FlexLayout()'.
!

METHODS

addWidget: widget
	"Adding a widget that is already in this layout moves it to the end."
	INLINE 'this.js.addWidget( widget.js )'.
!
insertWidget: widget before: beforeWidget
	INLINE 'this.js.insertChildBefore( widget.js, beforeWidget.js )'.
!
removeWidget: widget
	INLINE 'this.js.removeWidget( widget.js )'.
!
