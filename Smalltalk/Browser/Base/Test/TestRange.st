CLASS TestRange EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

"This class also tests AbstractRange."

METHODS

test
	| document range range2 node1 node2 node3 node4 parent documentFragment element element2 div |

	document := Document default.
	range := document createRange.

	node1 := document getElementById: 'rangeSelect1' class: HtmlParagraphElement.
	self assert: [ node1 textContent = 'Select 1'  ].
	node2 := document getElementById: 'rangeSelect2' class: HtmlParagraphElement.
	self assert: [ node2 textContent = 'Select 2'  ].
	node3 := document getElementById: 'rangeSelect3' class: HtmlParagraphElement.
	self assert: [ node3 textContent = 'Select 3'  ].

	self assert: [ range commonAncestorContainer class = Document ].
	self assert: [ range collapsed = true ].
	self assert: [ range endContainer class = Document ].
	self assert: [ range endOffset = 0 ].
	self assert: [ range startContainer class = Document ].
	self assert: [ range startOffset = 0 ].

	range setStart: node1 offset: 0.
	self assert: [ range startContainer textContent = 'Select 1' ].
	range setEnd: node3 offset: 0.
	self assert: [ range endContainer textContent = 'Select 3' ].

	self assert: [ range commonAncestorContainer class = HtmlTableCellElement ].
	self assert: [ range collapsed = false ].
	range collapse.
	self assert: [ range collapsed = true ].
	range collapseToStart.
	self assert: [ range collapsed = true ].

	range setStart: node1 offset: 0.
	range setEnd: node3 offset: 0.
	self assert: [ ( range comparePoint: node2 offset: 0 ) = 0 ].
	range2 := Range new selectNode: node2.
	self assert: [ ( range compareBoundaryPoints: 0 with: range2 ) = -1 ].

	documentFragment := range cloneContents.
	self assert: [ documentFragment children length = 3 ].

	range2 := range cloneRange.
	self assert: [ range2 class = Range ].
	self assert: [ range2 endContainer class = HtmlParagraphElement ].

	documentFragment := range createContextualFragment: '<div>I am a div node</div>'.
	self assert: [ documentFragment firstElementChild class = HtmlDivElement ].

	parent := node1 parentNode.

	node4 := ( document createElement: 'p' ) textContent: 'To be deleted through Range'.
	parent appendChild: node4.
	self assert: [ parent childElementCount = 4 ].
	range2 := Range new selectNode: parent lastElementChild.
	range2 deleteContents.
	self assert: [ parent childElementCount = 3 ].

	node4 := ( document createElement: 'p' ) textContent: 'To be extracted through Range'.
	parent appendChild: node4.
	self assert: [ parent childElementCount = 4 ].
	range2 := Range new selectNode: parent lastElementChild.
	documentFragment := range2 extractContents.
	self assert: [ documentFragment firstElementChild textContent = 'To be extracted through Range' ].
	self assert: [ parent childElementCount = 3 ].

	range := Range new selectNode: node1.
	self assert: [ range getBoundingClientRect extent >= ( 1 @ 1 ) ].
	self assert: [ range getClientRects first class = Rectangle ].
	self assert: [ range isPointInRange: node1 offset: 0 ].

	range := Range new selectNode: node1.
	node4 := ( document createElement: 'p' ) textContent: 'To be inserted in Range'.
	range insertNode: node4.
	self assert: [ parent childElementCount = 4 ].
	node4 remove.
	self assert: [ parent childElementCount = 3 ].

	self assert: [ range intersectsNode: node1 ].
	self assert: [ range startContainer = parent ].
	self assert: [ range endContainer = parent ].

	node4 := ( document createElement: 'p' ) textContent: 'To be extracted through surroundContents'.
	parent appendChild: node4.
	self assert: [ parent childElementCount = 4 ].
	div := document createElement: 'div'.
	self assert: [ div class = HtmlDivElement ].
	parent appendChild: div.
	self assert: [ parent childElementCount = 5 ].
	range := Range new selectNode: node4.
	range surroundContents: div.
	self assert: [ parent childElementCount = 4 ].
	self assert: [ parent lastElementChild textContent = 'To be extracted through surroundContents' ].
	parent lastElementChild remove.
!
