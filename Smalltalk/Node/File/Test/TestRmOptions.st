CLASS TestFileRmOptions EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| options |
	options := FileRmOptions new.

	options force: true.
	self assert: [ options force ].

	options recursive: true.
	self assert: [ options recursive ].

	options retryDelay: 100.
	self assert: [ options retryDelay = 100 ].

	options maxRetries: 5.
	self assert: [ options maxRetries = 5 ].
!
