CLASS TestWorkerOptions EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| options |
	options := WorkerOptions new.
	self assert: [ options class = WorkerOptions ].
	self assert: [ options name isNil ].
	self assert: [ options type isNil ].
	self assert: [ options credentials isNil ].

	options name: 'myWorker'.
	self assert: [ options name = 'myWorker' ].
	options type: 'module'.
	self assert: [ options type = 'module' ].
	options credentials: 'same-origin'.
	self assert: [ options credentials = 'same-origin' ].

	options := WorkerOptions new name: 'myWorker'; type: 'classic'; credentials: 'omit'; yourself.
	self assert: [ options name = 'myWorker' ].
	self assert: [ options type = 'classic' ].
	self assert: [ options credentials = 'omit' ].
!
