CLASS TestDialogsComponent EXTENDS Test MODULE TestMyBrowserApp CLASSVARS '' VARS ''

"Only the HTML dialog element is tested.
 The other dialogs can only be tested manually, because they need user interaction."

METHODS

"Helpers."

closing: dialog
	"Return a JS promise that resolves after the close event, that is sent asynchronously."
	^ ( Promise new: [ :resolve :reject |
		dialog onClose: [ :event | resolve value: event ] ] ) js.
!

"Tests."

test
	| component |
	component := MyBrowserApp default findComponent: DialogsComponent.
	self assert: [ component dialogButton textContent = 'Dialog' ].
	self assert: [ component dialog class = HtmlDialogElement ].
	self assert: [ component dialog open not ].
	self assert: [ component dialogOkButton value = 'OK' ].
	self assert: [ component dialogCancelButton value = 'Cancel' ].
!
async testGui
	| component dialog closing |
	component := MyBrowserApp default findComponent: DialogsComponent.
	dialog := component dialog.

	component dialogButton click.
	self assert: [ dialog open ].
	self assert: [ dialog matches: ':modal' ].
	closing := self closing: dialog.
	component dialogOkButton click.
	self assert: [ dialog open not ].
	await closing.
	self assert: [ dialog returnValue = 'OK' ].
	self assert: [ component dialogResultParagraph textContent = 'OK' ].

	component dialogButton click.
	self assert: [ dialog open ].
	self assert: [ dialog returnValue = '' ].
	closing := self closing: dialog.
	component dialogCancelButton click.
	await closing.
	self assert: [ component dialogResultParagraph textContent = 'Cancel' ].
!
