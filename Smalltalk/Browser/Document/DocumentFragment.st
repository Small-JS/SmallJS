CLASS DocumentFragment EXTENDS Node MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS abstract class: DocumentFragment.
	 Note: Most member functions expect HTML element objects to be put in this class."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new DocumentFragment()'.
!

METHODS

"Properties"

childElementCount
	^ Integer fromJs: INLINE 'this.js.childElementCount'.
!
children
	^ Element fromJsSubElements: INLINE 'this.js.children'.
!
firstElementChild
	^ Element fromJsSubElement: INLINE 'this.js.firstElementChild'.
!
lastElementChild
	^ Element fromJsSubElement: INLINE 'this.js.lastElementChild'.
!

"Methods."

append: node
	INLINE 'this.js.append( node.js )'.
!
prepend: node
	INLINE 'this.js.prepend( node.js )'.
!
querySelector: selector
	^ Element fromJsSubElement: INLINE 'this.js.querySelector( selector.js )'.
!
querySelectorAll: selector
	^ Element fromJsSubElements: INLINE 'this.js.querySelectorAll( selector.js )'.
!
replaceChildren: nodes
	INLINE 'this.js.replaceChildren()'.
	nodes do: [ :node | self append: node ].
!
