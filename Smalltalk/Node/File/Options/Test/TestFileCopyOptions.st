CLASS TestFileCopyOptions EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| options |
	options := FileCopyOptions new.

	options dereference: true.
	self assert: [ options dereference ].

	options errorOnExist: true.
	self assert: [ options errorOnExist ].

	options force: true.
	self assert: [ options force ].

	options mode: 438.
	self assert: [ options mode = 438 ].

	options preserveTimestamps: true.
	self assert: [ options preserveTimestamps ].

	options recursive: true.
	self assert: [ options recursive ].

	options verbatimSymlinks: true.
	self assert: [ options verbatimSymlinks ].

	options filter: [ :path | true ].
!
