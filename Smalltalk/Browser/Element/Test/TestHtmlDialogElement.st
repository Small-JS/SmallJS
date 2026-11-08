CLASS TestHtmlDialogElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

"Helpers."

newDialog
	"Modal dialogs must be connected to a document. Remove the dialog after the test."
	| dialog |
	dialog := Document default createElement: 'dialog'.
	dialog textContent: 'Test dialog'.
	Document default body appendChild: dialog.
	^ dialog.
!
closing: dialog
	"Return a JS promise that resolves with the close event, that is sent asynchronously."
	^ ( Promise new: [ :resolve :reject |
		dialog onClose: [ :event | resolve value: event ] ] ) js.
!

"Tests."

test
	| dialog |
	dialog := Document default createElement: 'dialog'.
	self assert: [ dialog class = HtmlDialogElement ].
	self assert: [ dialog tagName = 'DIALOG' ].

	self assert: [ dialog open not ].
	dialog open: true.
	self assert: [ dialog open ].
	self assert: [ dialog hasAttribute: 'open' ].
	dialog open: false.

	self assert: [ dialog returnValue = '' ].
	dialog returnValue: 'My value'.
	self assert: [ dialog returnValue = 'My value' ].
!
testShow
	| dialog |
	dialog := self newDialog.
	dialog show.
	self assert: [ dialog open ].
	self assert: [ ( dialog matches: ':modal' ) not ].
	dialog close.
	self assert: [ dialog open not ].
	dialog remove.
!
async testShowModal
	| dialog closing event |
	dialog := self newDialog.
	dialog showModal.
	self assert: [ dialog open ].
	self assert: [ dialog matches: ':modal' ].

	closing := self closing: dialog.
	dialog close: 'Closed'.
	self assert: [ dialog open not ].
	self assert: [ dialog returnValue = 'Closed' ].
	event := await closing.
	self assert: [ event type = 'close' ].
	dialog remove.
!
async testRequestClose
	| dialog canceled closing |
	dialog := self newDialog.
	canceled := 0.

	"The cancel event can prevent closing."
	dialog onCancel: [ :event |
		canceled := canceled + 1.
		canceled = 1 ifTrue: [ event preventDefault ] ].
	dialog showModal.
	dialog requestClose: 'Requested'.
	self assert: [ canceled = 1 ].
	self assert: [ dialog open ].

	closing := self closing: dialog.
	dialog requestClose: 'Requested'.
	self assert: [ canceled = 2 ].
	self assert: [ dialog open not ].
	self assert: [ dialog returnValue = 'Requested' ].
	await closing.

	"Without a return value, the previous one is kept."
	dialog show.
	dialog requestClose.
	self assert: [ dialog open not ].
	self assert: [ dialog returnValue = 'Requested' ].
	dialog remove.
!
