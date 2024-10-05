CLASS TestQPushButton EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"Also tests QAbstractButton"

test
	| button |
	button := QPushButton new.

	button setText: 'My Button'.
	self assert: [ button text = 'My Button' ].

	button onClick: [ self buttonClicked ].
	button click.
!
buttonClicked
	self assert: [ true ].
!
