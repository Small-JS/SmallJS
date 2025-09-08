CLASS TestFileMkdirOptions EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| options |
	options := FileMkdirOptions new.

	options recursive: true.
	self assert: [ options recursive ].

	options mode: 438.
	self assert: [ options mode = 438 ].
!
