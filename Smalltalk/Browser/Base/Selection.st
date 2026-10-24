CLASS Selection EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class Selection."

CLASSMETHODS

new
	"2024-06-16: FireFox fails to get selected text through the global document.getSelection() call.
	 This is the official bug report: https://bugzilla.mozilla.org/show_bug.cgi?id=85686
	 The workaround is to extract the selection through selectionStart and selectionEnd
	 of a specific input field."

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
	self collapse: node offset: 0.
!
collapse: node offset: offset
	INLINE 'this.js.collapse( node.js, offset.js )'.
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
	self extend: node offset: 0.
!
extend: node offset: offset
	INLINE 'this.js.extend( node.js, offset.js )'.
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
	self setBase: anchorNode offset: 0 extent: focusNode offset: 0.
!
setBase: anchorNode offset: anchorOffset extent: focusNode offset: focusOffset
	INLINE 'this.js.setBaseAndExtent( anchorNode.js, anchorOffset.js, focusNode.js, focusOffset.js )'.
!
toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
