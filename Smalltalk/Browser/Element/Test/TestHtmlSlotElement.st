CLASS TestHtmlSlotElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| slot paragraph |
	slot := Document getElementById: 'slot' class: HtmlSlotElement.

	self assert: [ slot name = 'slot-name' ].
	slot name: 'slot-new-name'.
	self assert: [ slot name = 'slot-new-name' ].
	slot name: 'slot-name'.

	paragraph := ( Document default createElement: 'p' ) textContent: 'Replaced slot text'.
	"This wont work, need to create shadow DOM."
	slot assign: paragraph.

	self assert: [ slot assignedElements length = 0 ].
	self assert: [ slot assignedNodes length = 0 ].
!
