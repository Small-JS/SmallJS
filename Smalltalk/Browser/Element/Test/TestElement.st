CLASS TestElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Test Element class though div and paragraph subclass instances."

testProperties
	| document div p1 p2 |
	document := Document new.

	div := document createElement: 'div'.
	self assert: [ div class = HtmlDivElement ].
	document body appendChild: div.
	self assert: [ div isConnected ].

	p1 := document createElement: 'p'.
	self assert: [ p1 class = HtmlParagraphElement ].
	div appendChild: p1.

	p2 := document createElement: 'p'.
	self assert: [ p2 class = HtmlParagraphElement ].
	div appendChild: p2.

	self assert: [ div id = '' ].
	div id: 'div'.
	self assert: [ div id = 'div' ].

	self assert: [ ( div attributes getNamedItem: 'id' ) value = 'div' ].

	self assert: [ div childElementCount = 2 ].
	self assert: [ div children first = p1 ].

	self assert: [ div className = '' ].
	div className: 'divClass'.
	self assert: [ div className = 'divClass' ].

	self assert: [ div classList length = 1 ].
	self assert: [ div classList contains: 'divClass' ].

	self assert: [ div clientTop = 0 ].
	self assert: [ div clientLeft = 0 ].
	self assert: [ div clientHeight = 0 ].
	self assert: [ div clientWidth = 0 ].

	self assert: [ div firstElementChild = p1 ].
	self assert: [ div lastElementChild = p2 ].
	self assert: [ div innerHtml = '<p></p><p></p>' ].
	self assert: [ div localName = 'div' ].
	self assert: [ div namespaceUri startsWith: 'http' ].
	self assert: [ div outerHtml startsWith: '<div ' ].
	self assert: [ div part length = 0 ].
	self assert: [ div prefix isNil ].

	self assert: [ p1 nextElementSibling = p2 ].
	self assert: [ p2 previousElementSibling = p1 ].

	self assert: [ div scrollTop = 0 ].
	self assert: [ div scrollLeft = 0 ].
	self assert: [ div scrollHeight = 0 ].
	self assert: [ div scrollWidth = 0 ].

	self assert: [ div assignedSlot isNil ].
	self assert: [ div shadowRoot isNil ].
	self assert: [ div slot = '' ].
	self assert: [ div tagName = 'DIV' ].
!
testMethods
	"Method attachShadow: is tested in TestShadowRoot."
	"Todo: Test dispatchEvent: in class Event class"
	"Todo: Test these in class PointerEvents:
		hasPointerCapture, releasePointerCapture, setPointerCapture, requestPointerLock "
	"Todo: Test requestFullscreen:... in interactive mode."

	| document div p1 p2 rect0 |
	document := Document new.

	div := ( document createElement: 'div' ) id: 'div'.
	self assert: [ div class = HtmlDivElement ].
	document body appendChild: div.
	self assert: [ div isConnected ].

	p1 := ( document createElement: 'p' ) id: 'p1'.
	self assert: [ p1 class = HtmlParagraphElement ].
	div appendChild: p1.

	p2 := ( document createElement: 'p' ) id: 'p2'.
	self assert: [ p1 class = HtmlParagraphElement ].
	div appendChild: p2.

	p2 after: p1.
	self assert: [ p2 nextElementSibling = p1 ].

	p2 before: p1.
	self assert: [ p2 previousElementSibling = p1 ].

	p2 insertAdjacentElement: p1 position: 'afterend'.
	self assert: [ div lastElementChild = p1 ].
	p2 insertAdjacentElement: p1 position: 'beforebegin'.
	self assert: [ div firstElementChild = p1 ].

	p2 insertAdjacentHtml: '<p id="p3"></p>' position: 'afterend'.
	self assert: [ div lastElementChild id = 'p3' ].
	div lastElementChild remove.

	p2 insertAdjacentText: 'Inserted Text node' position: 'afterend'.
	self assert: [ p2 nextSibling textContent = 'Inserted Text node' ].
	p2 nextSibling remove.

	self assert: [ ( p1 closest: 'div' ) id = 'div' ].
	self assert: [ ( p1 getAttribute: 'id' ) = 'p1' ].
	self assert: [ p1 getAttributeNames first = 'id' ].
	self assert: [ ( p1 getAttributeNode: 'id' ) value = 'p1' ].
	self assert: [ p1 hasAttribute: 'id' ].
	self assert: [ p1 hasAttributes ].
	self assert: [ p1 matches: '#p1' ].

	rect0 := Rectangle origin: ( 0 @ 0 ) extent: ( 0 @ 0 ).
	self assert: [ p1 getBoundingClientRect = rect0 ].
	self assert: [ div getClientRects isEmpty ].

	p1 className: 'pClass'.
	self assert: [ ( document getElementsByClassName: 'pClass' ) first = p1 ].
	self assert: [ ( document getElementsByTagName: 'p' ) first = p1 ].
!
testMethods2
	| document div p1 p2 p3 p4 attr element paragraph text elements  |
	document := Document new.

	div := ( document createElement: 'div' ) id: 'div'.
	self assert: [ div class = HtmlDivElement ].
	document body appendChild: div.
	self assert: [ div isConnected ].

	p1 := ( document createElement: 'p' ) id: 'p1'.
	self assert: [ p1 class = HtmlParagraphElement ].
	div appendChild: p1.

	p2 := ( document createElement: 'p' ) id: 'p2'.
	self assert: [ p1 class = HtmlParagraphElement ].
	div appendChild: p2.

	div prepend: p2.
	self assert: [ div children first = p2 ].
	div prepend: p1.
	self assert: [ div children first = p1 ].

	self assert: [ ( div querySelector: '#p1' ) id = 'p1' ].
	self assert: [ ( div querySelectorAll: '#p1' ) first id = 'p1' ].

	"Note: Attribute names must be lower case."
	div setAttribute: 'my-attr' value: 'my-value'.
	self assert: [ ( div getAttribute: 'my-attr' ) = 'my-value' ].
	div removeAttribute: 'my-attr'.
	self assert: [ ( div getAttribute: 'my-attr' ) = nil ].

	attr := ( document createAttribute: 'my-attr2' ) value: 'my-value2'.
	div setAttributeNode: attr.
	self assert: [ ( div getAttribute: 'my-attr2' ) = 'my-value2' ].
	div removeAttributeNode: attr.
	self assert: [ ( div getAttribute: 'my-attr2' ) = nil ].

	p3 := ( document createElement: 'p' ) id: 'p3'.
	div replaceChildren: p3.
	self assert: [ div children length = 1 ].

	p4 := ( document createElement: 'p' ) id: 'p4'.
	p3 replaceWith: p4.
	self assert: [ div children first id = 'p4' ].
!
testCreation
	| document element |
	document := Document new.

	#( 'body' 'br' 'button' 'div' 'embed' 'field' 'form' 'head' 'html' 'image' 'input'
	   'label' 'link' 'meta' 'p' 'script' 'slot' 'span' 'textarea' 'title' 'unknown' )
	   	do: [ :tagName |
			element := document createElement: tagName.
			self assert: [ element tagName = tagName toUpperCase ] ].
!
