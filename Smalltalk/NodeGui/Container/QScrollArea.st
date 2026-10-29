CLASS QScrollArea EXTENDS QFrame MODULE NodeGui CLASSVARS '' VARS ''

"Shows a single widget in a viewport, with scroll bars when the widget is larger than the viewport.
 In Qt the superclass is QAbstractScrollArea, which is not wrapped (yet)."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QScrollArea()'.
!

METHODS

"Widget"

setWidget: widget
	"The widget becomes a child of the scroll area and is deleted with it."
	INLINE 'this.js.setWidget( widget.js )'.
!
widget
	"Answer nil if there is no widget."
	^ QWidget fromJs: INLINE 'this.js.widget()'.
!
takeWidget
	"Remove the widget, so it is not deleted with the scroll area.
	 Answer it, or nil if there is none."
	^ QWidget fromJs: INLINE 'this.js.takeWidget()'.
!
setWidgetResizable: resizable
	"If resizable, the widget is resized to fill the viewport where possible."
	INLINE 'this.js.setWidgetResizable( resizable.js )'.
!
widgetResizable
	^ Boolean fromJs: INLINE 'this.js.widgetResizable()'.
!
setAlignment: alignment
	"Alignment of the widget, use the QLayout alignment enums."
	INLINE 'this.js.setAlignment( alignment.js )'.
!
alignment
	^ Integer fromJs: INLINE 'this.js.alignment()'.
!

"Scrolling"

ensureVisible: x y: y
	"Scroll so the point x, y of the widget is visible."
	INLINE 'this.js.ensureVisible( x.js, y.js )'.
!
ensureWidgetVisible: childWidget
	"Scroll so childWidget, a child of the widget, is visible."
	INLINE 'this.js.ensureWidgetVisible( childWidget.js )'.
!
