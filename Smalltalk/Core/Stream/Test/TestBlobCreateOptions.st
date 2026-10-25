CLASS TestBlobCreateOptions EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := BlobCreateOptions new.
	self assert: [ options class = BlobCreateOptions ].
	self assert: [ options type isNil ].
	self assert: [ options endings isNil ].

	options type: 'text/plain'.
	self assert: [ options type = 'text/plain' ].
	options endings: 'native'.
	self assert: [ options endings = 'native' ].
!
