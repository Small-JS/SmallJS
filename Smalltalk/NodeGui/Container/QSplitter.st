CLASS QSplitter EXTENDS QFrame MODULE NodeGui CLASSVARS '' VARS ''

"Arranges its widgets in panes, that the user can resize by dragging the handles between them.
 Indexes are 0-based."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QSplitter()'.
!

"Orientation enums"

horizontal
	^ 1.
!
vertical
	^ 2.
!

METHODS

"Widgets"

addWidget: widget
	INLINE 'this.js.addWidget( widget.js )'.
!
insertWidget: widget at: index
	INLINE 'this.js.insertWidget( index.js, widget.js )'.
!
count
	^ Integer fromJs: INLINE 'this.js.count()'.
!
indexOf: widget
	"Answer the index of widget, or -1 if it is not in this splitter."
	^ Integer fromJs: INLINE 'this.js.indexOf( widget.js )'.
!

"Orientation"

setOrientation: orientation
	INLINE 'this.js.setOrientation( orientation.js )'.
!
orientation
	^ Integer fromJs: INLINE 'this.js.orientation()'.
!

"Collapsing"

setCollapsible: index to: collapsible
	"If collapsible, the user can resize the pane at index to size 0."
	INLINE 'this.js.setCollapsible( index.js, collapsible.js )'.
!
isCollapsible: index
	^ Boolean fromJs: INLINE 'this.js.isCollapsible( index.js )'.
!
childrenCollapsible
	^ Boolean fromJs: INLINE 'this.js.childrenCollapsible()'.
!

"Events"

onSplitterMove: block
	"Block is called when the user moves a handle."
	self addEventListener: 'splitterMoved' then: [ block value ].
!
