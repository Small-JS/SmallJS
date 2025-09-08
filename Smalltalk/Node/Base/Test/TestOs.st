CLASS TestOs EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	self assert: [ Os tmpdir length > 0 ].
!
