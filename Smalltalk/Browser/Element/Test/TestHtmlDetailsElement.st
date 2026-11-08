CLASS TestHtmlDetailsElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

"Helpers."

newDetails: name
	"Details are only grouped by name in a document. Remove them after the test."
	| details |
	details := Document default createElement: 'details'.
	details innerHtml: '<summary>Summary</summary>Details'.
	details name: name.
	Document default body appendChild: details.
	^ details.
!

"Tests."

test
	| details |
	details := Document default createElement: 'details'.
	self assert: [ details class = HtmlDetailsElement ].
	self assert: [ details tagName = 'DETAILS' ].

	self assert: [ details open not ].
	details open: true.
	self assert: [ details open ].
	self assert: [ details hasAttribute: 'open' ].
	details open: false.
	self assert: [ details open not ].

	self assert: [ details name = '' ].
	details name: 'myGroup'.
	self assert: [ details name = 'myGroup' ].
	self assert: [ ( details getAttribute: 'name' ) = 'myGroup' ].
!
testGroup
	"Opening a details element closes the others with the same name."
	| first second other |
	first := self newDetails: 'testGroup'.
	second := self newDetails: 'testGroup'.
	other := self newDetails: 'otherGroup'.
	first open: true.
	other open: true.
	second open: true.
	self assert: [ first open not ].
	self assert: [ second open ].
	self assert: [ other open ].
	first remove.
	second remove.
	other remove.
!
async testToggle
	| details toggling event |
	details := Document default createElement: 'details'.
	toggling := Promise new: [ :resolve :reject |
		details onToggle: [ :anEvent | resolve value: anEvent ] ].
	details open: true.
	event := await toggling js.
	self assert: [ event type = 'toggle' ].
	self assert: [ details open ].
!
