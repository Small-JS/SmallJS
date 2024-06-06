CLASS TestStyleSheet EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| styleSheet |

	styleSheet := CssStyleSheet new.
	"Note: The StyleSheet class is never used by itself, only CssStyleSheet."
	self assert: [ styleSheet class = CssStyleSheet ].

	self assert: [ styleSheet disabled not ].
	styleSheet disabled: true.
	self assert: [ styleSheet disabled ].
	styleSheet disabled: false.

	self assert: [ styleSheet href isNil ].
	self assert: [ styleSheet media class = MediaList ].
	self assert: [ styleSheet ownerNode isNil ].
	self assert: [ styleSheet title = '' ].
	self assert: [ styleSheet type = 'text/css' ].
!
