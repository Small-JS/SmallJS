CLASS TestHtmlSlotElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| document slot paragraph |
	document := Document new.
	slot := document createElement: 'slot'.
	self assert: [ slot class = HtmlSlotElement ].

	self assert: [ slot name = '' ].
	slot name: 'slot-name'.
	self assert: [ slot name = 'slot-name' ].

	paragraph := ( document createElement: 'p' ) textContent: 'Slot text'.
	"This wont work, need to create shadow DOM."
	slot assign: paragraph.

	self assert: [ slot assignedElements length = 0 ].
	self assert: [ slot assignedNodes length = 0 ].
!
