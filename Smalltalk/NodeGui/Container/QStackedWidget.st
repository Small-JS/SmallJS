CLASS QStackedWidget EXTENDS QFrame MODULE NodeGui CLASSVARS '' VARS ''

"A stack of widgets, where only one widget is visible at a time. Indexes are 0-based.
 Like a widget with a QStackedLayout."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QStackedWidget()'.
!

METHODS

"Widgets"

addWidget: widget
	INLINE 'this.js.addWidget( widget.js )'.
!
removeWidget: widget
	INLINE 'this.js.removeWidget( widget.js )'.
!
count
	^ Integer fromJs: INLINE 'this.js.count()'.
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

"Events"

onCurrentChange: block
	self addEventListener: 'currentChanged' then: [ block value ].
!
