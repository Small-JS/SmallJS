CLASS TestSelection EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

METHODS

test
	"Todo: Not all tests are checked with asserts yet."
	| document selection range selectionInput selectionResultLabel text |


	"Disable these tests in Firefox because it does not process selection changes synchronously."
	Window isFirefox ifTrue: [ ^ nil ].

	document := Document default.
	selection := Selection new.
	self assert: [ selection class = Selection ].

	selectionInput := document getElementById: 'selectionInput' class: HtmlInputElement.
	selectionInput focus setSelectionRange: 7 to: 11.
	selection := document getSelection.
	self assert: [ selection toString = 'text' ].

	selectionResultLabel := Document getElementById: 'selectionResultLabel' class: HtmlLabelElement.
	selectionResultLabel textContent: selection toString.

	self assert: [ selection anchorNode class = HtmlTableCellElement ].
	self assert: [ selection anchorOffset = 1 ].
	self assert: [ selection focusNode class = HtmlTableCellElement ].
	self assert: [ selection focusOffset = 1 ].
	self assert: [ selection isCollapsed ].
	self assert: [ selection rangeCount = 1 ].
	self assert: [ selection type = 'Range' ].

	selection collapse: selectionInput.
	self assert: [ selection focusNode = selectionInput ].
	selection collapseToEnd.
	self assert: [ selection focusNode = selectionInput ].
	selection collapseToStart.
	self assert: [ selection focusNode = selectionInput ].

	selection selectAllChildren: selectionInput parentNode.
	self assert: [ document getSelection containsNode: selectionInput ].

	text := selectionInput value.
	selectionInput value: 'DEL', text.
	selectionInput focus setSelectionRange: 1 to: 3.
	document getSelection deleteFromDocument.
	"Allthough the DEL text can be seen to removed in the browser when debugging,
	 the value of selectionInput still contains the DEL text, so this assert will fail:
	 self assert: [ selectionInput value = text ]."
	selectionInput value: text.  "Put original text back."

	selectionInput focus setSelectionRange: 8 to: 11.
	selection := document getSelection.
	selection extend: selectionInput.

	selectionInput focus setSelectionRange: 8 to: 11.
	selection := document getSelection.
	range := selection getRangeAt: 0.
	self assert: [ range class = Range ].
	selection removeRange: range.
	selection removeAllRanges.

	selection selectAllChildren: document body.
	selection setBase: ( document getElementById: 'selectionInput' class: HtmlInputElement )
		extent: ( document getElementById: 'selectionResultLabel' class: HtmlLabelElement ).
!
testSelectionOutputButton
	| selectionOutputButton |
	selectionOutputButton := Document getElementById: 'selectionOutputButton' class: HtmlButtonElement.
	selectionOutputButton addEventListener: 'click' then: [ :event | self onSelectionOutputButton: event ].
!
onSelectionOutputButton: event
	| selectionResultLabel |
	selectionResultLabel := Document getElementById: 'selectionResultLabel' class: HtmlLabelElement.
	selectionResultLabel textContent: Selection new toString.
!
