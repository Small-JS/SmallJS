CLASS TestFileCreateOptions EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := FileCreateOptions new.
	self assert: [ options class = FileCreateOptions ].
	self assert: [ options type isNil ].
	self assert: [ options lastModified isNil ].
	self assert: [ options endings isNil ].

	options type: 'text/plain'.
	self assert: [ options type = 'text/plain' ].
	options lastModified: 1000.
	self assert: [ options lastModified = 1000 ].
	options endings: 'native'.
	self assert: [ options endings = 'native' ].

	options := FileCreateOptions new type: 'image/png'; lastModified: 0; endings: 'transparent'.
	self assert: [ options type = 'image/png' ].
	self assert: [ options lastModified = 0 ].
	self assert: [ options endings = 'transparent' ].
!
