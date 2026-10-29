CLASS QStackedLayout EXTENDS QLayout MODULE NodeGui CLASSVARS '' VARS ''

"A stack of widgets, where only one widget is visible at a time. Indexes are 0-based.
 Set this layout on a widget before adding widgets to it.
 Else the current widget has no parent and is shown as a separate window."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QStackedLayout()'.
!

"Stacking mode enums"

stackOne
	"Only the current widget is visible."
	^ 0.
!
stackAll
	"All widgets are visible, the current widget is raised."
	^ 1.
!

METHODS

"Widgets"

addWidget: widget
	INLINE 'this.js.addWidget( widget.js )'.
!
insertWidget: widget at: index
	INLINE 'this.js.insertWidget( index.js, widget.js )'.
!
removeWidget: widget
	INLINE 'this.js.removeWidget( widget.js )'.
!
count
	^ Integer fromJs: INLINE 'this.js.count()'.
!
widget: index
	"Answer the widget at index, or nil if there is none."
	^ QWidget fromJs: INLINE 'this.js.widget( index.js )'.
!
indexOf: widget
	"Answer the index of widget, or -1 if it is not in this layout."
	^ Integer fromJs: INLINE 'this.js.indexOf( widget.js )'.
!

"Current widget"

setCurrentIndex: index
	INLINE 'this.js.setCurrentIndex( index.js )'.
!
currentIndex
	"Answer -1 if there are no widgets."
	^ Integer fromJs: INLINE 'this.js.currentIndex()'.
!
setCurrentWidget: widget
	INLINE 'this.js.setCurrentWidget( widget.js )'.
!
currentWidget
	"Answer nil if there are no widgets."
	^ QWidget fromJs: INLINE 'this.js.currentWidget()'.
!
setStackingMode: stackingMode
	INLINE 'this.js.setStackingMode( stackingMode.js )'.
!
stackingMode
	^ Integer fromJs: INLINE 'this.js.stackingMode()'.
!

"Events"

onCurrentChange: block
	self addEventListener: 'currentChanged' then: [ block value ].
!
