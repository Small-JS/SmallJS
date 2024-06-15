CLASS TestRange EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"This class also tests AbstractRange."

METHODS

test
	| document div p1 p2 p3 p4 range range2 documentFragment div2 |

	document := Document new.

	div := document createElement: 'div'.
	self assert: [ div class = HtmlDivElement ].
	document body appendChild: div.

	p1 := ( document createElement: 'p' ) id: 'p1'.
	self assert: [ p1 class = HtmlParagraphElement ].
	div appendChild: p1.

	p2 := ( document createElement: 'p' ) id: 'p2'.
	self assert: [ p2 class = HtmlParagraphElement ].
	div appendChild: p2.

	p3 := ( document createElement: 'p' ) id: 'p3'.
	self assert: [ p3 class = HtmlParagraphElement ].
	div appendChild: p3.

	range := document createRange.

	self assert: [ range commonAncestorContainer = document ].
	self assert: [ range collapsed = true ].
	self assert: [ range endContainer = document ].
	self assert: [ range endOffset = 0 ].
	self assert: [ range startContainer = document ].
	self assert: [ range startOffset = 0 ].

	range setStart: p1 offset: 0.
	self assert: [ range startContainer id = 'p1' ].
	range setEnd: p3 offset: 0.
	self assert: [ range endContainer id = 'p3' ].

	self assert: [ range commonAncestorContainer class = HtmlDivElement ].
	self assert: [ range collapsed = false ].
	range collapse.
	self assert: [ range collapsed = true ].
	range collapseToStart.
	self assert: [ range collapsed = true ].

	range setStart: p1 offset: 0.
	range setEnd: p3 offset: 0.
	self assert: [ ( range comparePoint: p2 offset: 0 ) = 0 ].
	range2 := Range new selectNode: p2.
	self assert: [ ( range compareBoundaryPoints: 0 with: range2 ) = -1 ].

	documentFragment := range cloneContents.
	self assert: [ documentFragment children length = 3 ].

	range2 := range cloneRange.
	self assert: [ range2 class = Range ].
	self assert: [ range2 endContainer class = HtmlParagraphElement ].

	documentFragment := range createContextualFragment: '<div>I am a div node</div>'.
	self assert: [ documentFragment firstElementChild class = HtmlDivElement ].

	"Test deleteContents"
	p4 := ( document createElement: 'p' ) id: 'p4'.
	div appendChild: p4.
	self assert: [ div childElementCount = 4 ].
	range2 := Range new selectNode: div lastElementChild.
	range2 deleteContents.
	self assert: [ div childElementCount = 3 ].

	"Test extractContents"
	p4 := ( document createElement: 'p' ) id: 'p4'.
	div appendChild: p4.
	self assert: [ div childElementCount = 4 ].
	range2 := Range new selectNode: div lastElementChild.
	documentFragment := range2 extractContents.
	self assert: [ documentFragment firstElementChild id = 'p4' ].
	self assert: [ div childElementCount = 3 ].

	"Test client rectangles"
	range := Range new selectNode: p1.
	self assert: [ range getBoundingClientRect extent = ( 0 @ 0 ) ].
	self assert: [ range getClientRects isEmpty ].
	self assert: [ range isPointInRange: p1 offset: 0 ].

	"Test insertNode"
	range := Range new selectNode: p1.
	p4 := ( document createElement: 'p' ) id: 'p4'.
	range insertNode: p4.
	self assert: [ div childElementCount = 4 ].
	p4 remove.
	self assert: [ div childElementCount = 3 ].

	self assert: [ range intersectsNode: p1 ].

	"Test surroundContents"
	p4 := ( document createElement: 'p' ) id: 'p4'.
	div appendChild: p4.
	self assert: [ div childElementCount = 4 ].
	div2 := document createElement: 'div'.
	self assert: [ div class = HtmlDivElement ].
	div appendChild: div2.
	self assert: [ div childElementCount = 5 ].
	range := Range new selectNode: p4.
	range surroundContents: div2.
	self assert: [ div childElementCount = 4 ].
	self assert: [ div2 children first id = 'p4' ].
	div lastElementChild remove.
!
