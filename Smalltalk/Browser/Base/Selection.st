CLASS Selection EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class Range."

CLASSMETHODS

new
	^ Document default getSelection.
!

METHODS

"Properties"

anchorNode
	^ Node fromJsSubNode: INLINE 'this.js.anchorNode'.
!
anchorOffset
	^ Integer fromJs: INLINE 'this.js.anchorOffset'.
!
focusNode
	^ Node fromJsSubNode: INLINE 'this.js.focusNode'.
!
focusOffset
	^ Integer fromJs: INLINE 'this.js.focusOffset'.
!
isCollapsed
	^ Boolean fromJs: INLINE 'this.js.isCollapsed'.
!
rangeCount
	^ Integer fromJs: INLINE 'this.js.rangeCount'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!

"Methods"


addRange: range
	INLINE 'this.js.addRange( range.js )'.
!
collapse: node
	INLINE 'this.js.collapse( node.js )'.
!
collapseToEnd
	INLINE 'this.js.collapseToEnd()'.
!
collapseToStart
	INLINE 'this.js.collapseToStart()'.
!
containsNode: node
	^ Boolean fromJs: INLINE 'this.js.containsNode( node.js )'.
!
deleteFromDocument
	INLINE 'this.js.deleteFromDocument()'.
!
extend: node
	INLINE 'this.js.extend( node.js )'.
!
getRangeAt: index
	^ Range fromJs: INLINE 'this.js.getRangeAt( index.js )'.
!
removeAllRanges
	INLINE 'this.js.removeAllRanges()'.
!
removeRange: range
	INLINE 'this.js.removeRange( range.js )'.
!
selectAllChildren: node
	INLINE 'this.js.selectAllChildren( node.js )'.
!
setBase: anchorNode extent: focusNode
	INLINE 'this.js.setBaseAndExtent( anchorNode.js, 0, focusNode.js, 0 )'.
!
toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
