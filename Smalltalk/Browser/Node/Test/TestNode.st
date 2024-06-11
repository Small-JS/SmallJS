CLASS TestNode EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Tests abstract Node class through instances of div and paragraph."

test
	| document div p1 p2 p3 text |
	document := Document new.

	div := document createElement: 'div'.
	self assert: [ div class = HtmlDivElement ].
	self assert: [ div isConnected not ].
	document body appendChild: div.
	self assert: [ div isConnected ].

	p1 := document createElement: 'p'.
	self assert: [ p1 class = HtmlParagraphElement ].
	div appendChild: p1.

	p2 := document createElement: 'p'.
	self assert: [ p1 class = HtmlParagraphElement ].
	div appendChild: p2.

	"Properties"

	self assert: [ div baseUri = 'about:blank' ].
	self assert: [ div firstChild = p1 ].
	self assert: [ div lastChild = p2 ].
	self assert: [ p1 nextSibling = p2 ].
	self assert: [ p2 previousSibling = p1 ].

	self assert: [ p1 nodeName = 'P' ].
	self assert: [ p1 nodeType = 1 ].
	self assert: [ p1 nodeValue isNil ].

	self assert: [ p1 ownerDocument = document ].
	self assert: [ p1 parentElement = div ].
	self assert: [ p1 parentNode = div ].

	self assert: [ p1 textContent = '' ].
	p1 textContent: 'P1 text'.
	self assert: [ p1 textContent = 'P1 text' ].

	"Methods"

	p3 := p1 cloneNode: true.
	self assert: [ p3 textContent = 'P1 text' ].
	p3 textContent: 'P3 text'.

	self assert: [ ( p1 compareDocumentPosition: p2 ) = 4  ]. "4 = Following"
	self assert: [ div contains: p1 ].
	self assert: [ p1 getRootNode = document ].
	self assert: [ div hasChildNodes ].

	div insert: p2 before: p1.
	self assert: [ div firstChild = p2 ].
	div insert: p1 before: p2.
	self assert: [ div firstChild = p1 ].

	self assert: [ p1 isEqualNode: p1 ].
	self assert: [ ( p1 isEqualNode: p2 ) not ].
	self assert: [ p1 isSameNode: p1  ].
	self assert: [ ( p1 isSameNode: p2 ) not ].

	text := document createTextNode: ' added'.
	p1 appendChild: text.
	p1 normalize.
	self assert: [ p1 textContent = 'P1 text added' ].

	div replaceChild: p2 with: p3.
	self assert: [ div lastChild = p3 ].

	div removeChild: p3.
	self assert: [ div lastChild = p1 ].
!
