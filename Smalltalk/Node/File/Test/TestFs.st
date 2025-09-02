CLASS TestFs EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	self assert: [ ( Fs existsSync: 'missing.txt' ) not ].
!

"TODO: Implement more tests."
