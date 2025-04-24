CLASS TestSelectComponent EXTENDS Test MODULE TestBrowserApp CLASSVARS '' VARS ''

test
	| selectComponent select |
	selectComponent := MyBrowserApp default findComponent: SelectComponent.
	select := selectComponent select.

	self assert: [ select id = 'select' ].
	self assert: [ select options length = 2 ].
	self assert: [ select options first value = 'option1' ].
	self assert: [ select options last text = 'Option 2' ].
!
testGui
	| selectComponent  |
	selectComponent := MyBrowserApp default findComponent: SelectComponent.

	selectComponent select selectedIndex: 1.
	selectComponent select dispatchEvent: ( Event type: 'change' ).
	Timer timeout: 500 then: [
			self assert: [ selectComponent outputParagraph textContent = 'option2' ]  ].
!

