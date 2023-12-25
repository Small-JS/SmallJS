CLASS TestHtmlOptionElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	|  option |

	option := Document default createElement: 'option'.

	option value: 'Option value'.
	self assert: [ option value = 'Option value' ].

	option selected: true.
	self assert: [ option selected ].

	option defaultSelected: true.
	self assert: [ option defaultSelected ].
!
