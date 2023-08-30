CLASS HtmlSlotElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

METHODS

"Properties."

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!

"Methods."

assign: node
	INLINE 'this.js.assign( node.js )'.
!
assignedElements
	^ self assignedElements: false.
!
assignedElements: flatten
	^ Array fromJs: INLINE 'this.js.assignedElements( { flatten: flatten.js } )' elementConverter:
		[ :jsElement | Element fromJsSubElement: jsElement ].
!
assignedNodes
	^ self assignedNodes: false.
!
assignedNodes: flatten
	^ Array fromJs: INLINE 'this.js.assignedNodes( { flatten: flatten.js } )' elementConverter:
		[ :jsNode | Element fromJsSubNode: jsNode ].
!
