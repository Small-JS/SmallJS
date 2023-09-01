CLASS TestNode EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
test
	| document node node2 text |

	document := Document default.
	node := document getElementById: 'node'.
	self assert: [ node textContent = 'Node' ].

	self assert: [ node isConnected ].
	self assert: [ node nextSibling class = Text ].
	self assert: [ node nextSibling previousSibling = node ].
	self assert: [ node nodeName = 'P' ].
	self assert: [ node nodeType = 1 ].

	text := node firstChild.
	self assert: [ text nodeValue = 'Node' ].
	text nodeValue: 'Changed node'.
	self assert: [ text nodeValue = 'Changed node' ].
	text nodeValue: 'Node'.

	self assert: [ node ownerDocument = document ].
	self assert: [ text parentElement = node ].
	self assert: [ text parentNode = node ].

	node2 := ( document createElement: 'p' ) textContent: 'Node 2'.
	node parentNode appendChild: node2.
	self assert: [ node parentNode childElementCount = 2 ].
	self assert: [ ( node compareDocumentPosition: node2 ) = 4 ].

	node parentNode insert: node2 before: node.
	self assert: [ node2 nextSibling = node ].
	self assert: [ ( node compareDocumentPosition: node2 ) = 2 ].

	self assert: [ node contains: text ].
	self assert: [ node getRootNode = document ].
	self assert: [ node getRootNodeComposed = document ].

	self assert: [ node hasChildNodes ].
	self assert: [ text hasChildNodes not ].

	self assert: [ ( node cloneNode: true ) isEqualNode: node ].
	self assert: [ ( node isEqualNode: node2 ) not ].
	self assert: [ node isSameNode: node ].

	node2 appendChild: ( document createTextNode: ' appendix' ).
	self assert: [ node2 textContent = 'Node 2 appendix' ].
	self assert: [ node2 childNodes length = 2 ].
	node2 normalize.
	self assert: [ node2 childNodes length = 1 ].

	node2 replaceChild: node2 firstChild with: ( document createTextNode: 'Replaced node 2' ).
	self assert: [ node2 textContent = 'Replaced node 2' ].

	node2 removeChild: node2 firstChild.
	self assert: [ node2 childNodes length = 0 ].

	node2 remove.
!
