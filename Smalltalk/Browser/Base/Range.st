CLASS Range EXTENDS AbstractRange MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS class Range."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Range()'.
!

METHODS

"Properties."

commonAncestorContainer
	^ Node fromJsSubNode: INLINE 'this.js.commonAncestorContainer'.
!

"Methods."

collapse
	INLINE 'this.js.collapse()'.
!
collapseToStart
	INLINE 'this.js.collapse( true )'.
!
compareBoundaryPoints: how with: range
	"Values for comparison mode 'how' are:
	 0: START_TO_START, 1: START_TO_END, 2: END_TO_END, 3: END_TO_START."

	^ Integer fromJs: INLINE 'this.js.compareBoundaryPoints( how.js, range.js )'.
!
comparePoint: node offset: offset
	^ Integer fromJs: INLINE 'this.js.comparePoint( node.js, offset.js )'.
!
cloneContents
	^ DocumentFragment fromJs: INLINE 'this.js.cloneContents()'.
!
cloneRange
	^ Range fromJs: INLINE 'this.js.cloneRange()'.
!
createContextualFragment: tagString
	^ DocumentFragment fromJs: INLINE 'this.js.createContextualFragment( tagString.js )'.
!
deleteContents
	INLINE 'this.js.deleteContents()'.
!
extractContents
	^ DocumentFragment fromJs: INLINE 'this.js.extractContents()'.
!
getBoundingClientRect
	^ Rectangle fromJs: INLINE 'this.js.getBoundingClientRect()'.
!
getClientRects
	^ Array fromJs: INLINE 'this.js.getClientRects()' elementClass: Rectangle.
!
isPointInRange: node offset: offset
	^ Boolean fromJs: INLINE 'this.js.isPointInRange( node.js, offset.js )'.
!
insertNode: node
	INLINE 'this.js.insertNode( node.js )'.
!
intersectsNode: node
	^ Boolean fromJs: INLINE 'this.js.intersectsNode( node.js )'.
!
selectNode: node
	INLINE 'this.js.selectNode( node.js )'.
!
selectNodeContents: node
	INLINE 'this.js.selectNodeContents( node.js )'.
!
setEnd: node offset: offset
	INLINE 'this.js.setEnd( node.js, offset.js )'.
!
setEndAfter: node
	INLINE 'this.js.setEndAfter( node.js )'.
!
setEndBefore: node
	INLINE 'this.js.setEndBefore( node.js )'.
!
setStart: node offset: offset
	INLINE 'this.js.setStart( node.js, offset.js )'.
!
setStartAfter: node
	INLINE 'this.js.setStartAfter( node.js )'.
!
setStartBefore: node
	INLINE 'this.js.setStartBefore( node.js )'.
!
surroundContents: parentNode
	INLINE 'this.js.surroundContents( parentNode.js )'.
!
toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
