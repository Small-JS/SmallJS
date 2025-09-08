CLASS TestFileOptions EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| options signal |
	options := FileOptions new.

	options encoding: 'utf8'.
	self assert: [ options encoding = 'utf8' ].

	options autoClose: true.
	self assert: [ options autoClose ].

	options emitClose: true.
	self assert: [ options emitClose ].

	options start: 10.
	self assert: [ options start = 10 ].

	options end: 70.
	self assert: [ options end = 70 ].

	options highWaterMark: 1024.
	self assert: [ options highWaterMark = 1024 ].

	signal := AbortSignal abort.
	options signal: signal.
	self assert: [ options signal = signal ].
!
