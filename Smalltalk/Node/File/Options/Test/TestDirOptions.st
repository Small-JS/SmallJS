CLASS TestDirOptions EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| options |
	options := DirOptions new.

	options encoding: 'utf8'.
	self assert: [ options encoding = 'utf8' ].

	options withFileTypes: true.
	self assert: [ options withFileTypes ].

	options recursive: true.
	self assert: [ options recursive ].

!
