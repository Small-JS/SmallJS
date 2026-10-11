CLASS TestFileWatchOptions EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

test
	| options controller |
	options := FileWatchOptions new.

	options persistent: false.
	self assert: [ options persistent not ].

	options recursive: true.
	self assert: [ options recursive ].

	options encoding: 'utf8'.
	self assert: [ options encoding = 'utf8' ].

	controller := AbortController new.
	options signal: controller signal.
	self assert: [ options signal class = AbortSignal ].
	self assert: [ options signal aborted not ].

	options maxQueue: 100.
	self assert: [ options maxQueue = 100 ].

	options overflow: 'throw'.
	self assert: [ options overflow = 'throw' ].
!
