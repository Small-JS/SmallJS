CLASS TestQLabel EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| label |

	label := QLabel new.
	self assert: [ label jsClassName = 'QLabel' ].

	label setText: 'My Label'.
	self assert: [ label text = 'My Label' ].
!
