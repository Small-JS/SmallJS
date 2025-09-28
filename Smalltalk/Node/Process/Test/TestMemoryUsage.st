CLASS TestMemoruUsage EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	| memoryUsage |
	memoryUsage := Process memoryUsage.
	self assert: [ memoryUsage class = MemoryUsage ].

	self assert: [ memoryUsage rss > 1000 ].
	self assert: [ memoryUsage heapTotal > 1000 ].
	self assert: [ memoryUsage heapUsed > 1000 ].
	self assert: [ memoryUsage external > 1000 ].
	self assert: [ memoryUsage arrayBuffers > 1000 ].
!

