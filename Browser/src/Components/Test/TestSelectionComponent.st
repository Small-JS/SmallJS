CLASS TestSelectionComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| document selectionComponent selectionInput selection text range |
	document := Document default.
	selectionComponent := MyBrowserApp default findComponent: SelectionComponent.
	selectionInput := selectionComponent input.

	"Disable further tests in Firefox because it does not process selection changes synchronously."
	Window isFirefox ifTrue: [ ^ nil ].

	selectionInput value: 'Select text here, or elsewhere'.
	selectionInput focus setSelectionRange: 7 to: 11.
	selection := document getSelection.
	self assert: [ selection class = Selection ].
	self assert: [ selection toString = 'text' ].
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

	selectionInput value: 'Select text here, or elsewhere'.
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
	selection
		setBase: ( document getElementById: 'selectionInput' class: HtmlInputElement )
		extent: ( document getElementById: 'selectionOutputParagraph' class: HtmlParagraphElement ).
!
async testGui
	| selectionComponent |
	selectionComponent := MyBrowserApp default findComponent: SelectionComponent.

	selectionComponent input value: 'Select text here'.
	selectionComponent input focus setSelectionRange: 7 to: 11.
	selectionComponent outputButton click.
	await Timer timeout: 500.
	self assert: [ selectionComponent outputParagraph textContent = 'text' ].
!
