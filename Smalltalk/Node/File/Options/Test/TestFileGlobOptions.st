CLASS TestFileGlobOptions EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| options |
	options := FileGlobOptions new.

	options cwd: './web'.
	self assert: [ options cwd = './web' ].

	options withFileTypes: true.
	self assert: [ options withFileTypes ].

	options exclude: [ :fileName | false ].
!
