CLASS TestHtmlOptionElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	|  option |

	option := Document default createElement: 'option'.

	option value: 'Option value'.
	self assert: [ option value = 'Option value' ].

	option text: 'Option text'.
	self assert: [ option text = 'Option text' ].

	option selected: true.
	self assert: [ option selected ].

	option defaultSelected: true.
	self assert: [ option defaultSelected ].
!
