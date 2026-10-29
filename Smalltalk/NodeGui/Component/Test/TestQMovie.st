CLASS TestQMovie EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| movie |
	movie := QMovie new.
	self assert: [ movie jsClassName = 'QMovie' ].
	self assert: [ movie fileName = '' ].
	self assert: [ movie state = QMovie notRunning ].
	self assert: [ movie frameCount = -1 ].
	self assert: [ movie currentFrameNumber = -1 ].

	movie := QMovie new: 'assets/heart.gif'.
	self assert: [ movie fileName = 'assets/heart.gif' ].
	self assert: [ movie format = 'gif' ].
	self assert: [ movie frameCount > 1 ].

	movie setSpeed: 200.
	self assert: [ movie speed = 200 ].
	movie setScaledSize: ( QSize width: 16 height: 16 ).
!
testPlaying
	| movie startCount stateCount |
	movie := QMovie new: 'assets/heart.gif'.
	startCount := 0.
	stateCount := 0.
	movie onStart: [ startCount := startCount + 1 ].
	movie onStateChange: [ stateCount := stateCount + 1 ].
	movie onError: [ self assert: [ false ] ].

	movie start.
	self assert: [ movie state = QMovie running ].
	self assert: [ startCount = 1 ].
	movie setPaused: true.
	self assert: [ movie state = QMovie paused ].
	movie stop.
	self assert: [ movie state = QMovie notRunning ].
	self assert: [ stateCount = 3 ].
!
testFrames
	| movie count |
	movie := QMovie new: 'assets/heart.gif'.
	count := 0.
	movie onFrameChange: [ count := count + 1 ].

	self assert: [ movie jumpToFrame: 0 ].
	self assert: [ movie currentFrameNumber = 0 ].
	self assert: [ movie jumpToNextFrame ].
	self assert: [ movie currentFrameNumber = 1 ].
	self assert: [ count > 0 ].
	"Without caching, only the next frame can be jumped to."
	self assert: [ ( movie jumpToFrame: 3 ) not ].
!
testCaching
	| movie |
	movie := QMovie new.
	movie setCacheMode: QMovie cacheAll.
	movie setFileName: 'assets/heart.gif'.
	self assert: [ movie jumpToFrame: 3 ].
	self assert: [ movie currentFrameNumber = 3 ].
	self assert: [ ( movie jumpToFrame: 1000 ) not ].
!
