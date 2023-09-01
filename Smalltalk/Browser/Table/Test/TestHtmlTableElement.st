CLASS TestHtmlTableElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

"This class tests TestHtmlTableElement and all elements contained within it."

METHODS

browserOnly
	^ true.
!
testTable
	| table tHead tBody tFoot |

	table := Document default createElement: 'table'.
	self assert: [ table class = HtmlTableElement ].

	tHead := table createTHead.
	self assert: [ tHead class = HtmlTableSectionElement ].
	self assert: [ table tHead = tHead ].
	table deleteTHead.
	self assert: [ table tHead isNil ].

	tBody := table createTBody.
	self assert: [ tBody class = HtmlTableSectionElement ].
	self assert: [ table tBodies first = tBody ].

	tFoot := table createTFoot.
	self assert: [ tFoot class = HtmlTableSectionElement ].
	self assert: [ table tFoot = tFoot ].
	table deleteTFoot.
	self assert: [ table tFoot isNil ].

!
testCaption
	| table caption |

	table := Document default createElement: 'table'.
	self assert: [ table class = HtmlTableElement ].

	caption := table createCaption.
	self assert: [ caption class = HtmlTableCaptionElement ].
	self assert: [ table caption = caption ].

	caption innerHtml: '<b>My table caption</b>'.
	self assert: [ caption innerHtml = '<b>My table caption</b>' ].

	table deleteCaption.
	self assert: [ table caption isNil ].
!
testSections
	| table row tBody |

	table := Document default createElement: 'table'.
	self assert: [ table class = HtmlTableElement ].

	tBody := table createTBody.
	self assert: [ tBody class = HtmlTableSectionElement ].

	row := table insertRow: -1.
	self assert: [ row class = HtmlTableRowElement ].
	self assert: [ tBody rows length = 1 ].
	table deleteRow: 0.
	self assert: [ tBody rows length = 0 ].

	row := tBody insertRow: -1.
	self assert: [ row class = HtmlTableRowElement ].
	self assert: [ tBody rows length = 1 ].
	tBody deleteRow: 0.
	self assert: [ tBody rows length = 0 ].
!
testRow
	| table row cell |

	table := Document default createElement: 'table'.
	self assert: [ table class = HtmlTableElement ].

	row := table insertRow: -1.
	self assert: [ row class = HtmlTableRowElement ].
	self assert: [ row rowIndex = 0 ].
	self assert: [ row sectionRowIndex = 0 ].

	cell := row insertCell: -1.
	self assert: [ row cells length = 1 ].
	self assert: [ row cells first = cell ].

	row deleteCell: 0.
	self assert: [ row cells length = 0 ].
!
testCell
	| table row headerCell cell |

	table := Document default createElement: 'table'.
	self assert: [ table class = HtmlTableElement ].

	row := table insertRow: -1.
	self assert: [ row class = HtmlTableRowElement ].

	headerCell := Document default createElement: 'th'.
	self assert: [ headerCell class = HtmlTableCellElement ].

	headerCell abbr: 'myAbbr'.
	self assert: [ headerCell abbr = 'myAbbr' ].

	headerCell scope: 'row'.
	self assert: [ headerCell scope = 'row' ].

	headerCell id: 'headerCellId'.
	row appendChild: headerCell.
	self assert: [ headerCell cellIndex = 0 ].

	cell := row insertCell: -1.
	self assert: [ cell class = HtmlTableCellElement ].
	self assert: [ cell cellIndex = 1 ].

	cell headers: 'headerCellId'.
	self assert: [ cell headers = 'headerCellId' ].

	self assert: [ cell rowSpan = 1 ].
	cell rowSpan: 2.
	self assert: [ cell rowSpan = 2 ].

	self assert: [ cell colSpan = 1 ].
	cell colSpan: 2.
	self assert: [ cell colSpan = 2 ].
!
