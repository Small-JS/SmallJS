CLASS TestMyNwWindow EXTENDS Object MODULE TestMyNwApp CLASSVARS '' VARS 'app window'

test: aApp
	| domWindow |

	app := aApp.
	window := NwWindow get.
	self assert: [ window class = NwWindow ].

	domWindow := Window default.
	self assert: [ ( NwWindow get: domWindow ) window = domWindow ].

	self assert: [ window title = 'My NW.js App' ].
	self assert: [ window menu class = NwMenu ].
	self assert: [ window zoomLevel = 0 ].

	window moveToCenter.
	window resizable: true.
	"Minium and maximum sizes are one enforced after window move or resize,
	 so they are not tested here."
	window minimumSize: 100 @ 200.
	window maximumSize: 800 @ 600.

	"Windows sizing operation are executed async,
	so small delay is done before checking each result,
	which also allows for a visual check :-)."

	"Size"

	"Resizing sets the *inner* window size,
	 while window size gives the *outer* window size."
	window resizeTo: ( 400 @ 200 ).
	Timer timeout: 500 then: [ self onResizeTo ].
!
onResizeTo
	| currentSize |
	self assert: [ window size > ( 400 @ 200 ) ].
	self assert: [ window size < ( 500 @ 300 ) ].

	currentSize := window size.
	window resizeBy: ( 20 @ 10 ).
	Timer timeout: 500 then: [ self onResizeBy: currentSize ].
!
onResizeBy: previousSize
	| currentSize |
	self assert: [ window size = ( previousSize + ( 20 @ 10 ) ) ].

	currentSize := window size.
	window maximize.
	Timer timeout: 500 then: [ self onMaximize: currentSize ].
!
onMaximize: previousSize
	"Maximizing does not change the NW.js window size,
	 but DOM window size is changed."
	self assert: [ window window innerSize > previousSize ].

	window minimize.
	Timer timeout: 500 then: [ self onMinimize: previousSize ].
!
onMinimize: previousSize
	"Maximizing does not change the NW.js window size,
	 but DOM window size is changed."
	self assert: [ window window outerHeight < 100 ].

	window restore.
	Timer timeout: 500 then: [ self onRestore: previousSize ].
!
onRestore: previousSize
	| currentOffset |
	self assert: [ window size = previousSize ].

	window moveTo: ( 200 @ 100 ).
	Timer timeout: 500 then: [ self onMoveTo ].
!
onMoveTo
	self assert: [ window offset = ( 200 @ 100 ) ].

	window moveBy: ( 20 @ 10 ).
	Timer timeout: 500 then: [ self onMoveBy ].
!
onMoveBy
	self assert: [ window offset = ( 220 @ 110 ) ].

	window moveToCenter.
	Timer timeout: 500 then: [ self onMoveToCenter ].

!
onMoveToCenter
	self assert: [ window offset > ( 220 @ 110 ) ].

	window fullscreen: true.
	Timer timeout: 500 then: [ self onFullscreen ].
!
onFullscreen
	self assert: [ window fullscreen ].

	window fullscreen: false.
	Timer timeout: 500 then: [ self onLeaveFullscreen ].
!
onLeaveFullscreen
	self assert: [ window fullscreen not ].

	self assert: [ window focus ].
	window focus: false.
	Timer timeout: 500 then: [ self onBlur ].
!
onBlur
	self assert: [ window focus not ].

	window focus: true.
	Timer timeout: 500 then: [ self onFocus ].
!
onFocus
	self assert: [ window focus ].

	window show: false.
	Timer timeout: 500 then: [ self onHide ].
!
onHide
	self assert: [ window show not ].

	window show: true.
	window focus: true.
	Timer timeout: 500 then: [ self onShow ].
!
onShow
	"Unfortunately, window.show does not restore the document visibility state,
	 even though tge document is shown."
	"self assert: [ window show not ]."

	self assert: [ window alwaysOnTop not ].
	window alwaysOnTop: true.
	Timer timeout: 500 then: [ self onAlwaysOnTop ].
!
onAlwaysOnTop
	self assert: [ window alwaysOnTop ].
	window alwaysOnTop: false.
	Timer timeout: 500 then: [ self onLeaveAlwaysOnTop ].
!
onLeaveAlwaysOnTop
	self assert: [ window alwaysOnTop not ].

	self assert: [ window kioskMode not ].
	window kioskMode: true.
	Timer timeout: 500 then: [ self onKioskMode ].
!
onKioskMode
	self assert: [ window kioskMode ].
	window kioskMode: false.
	Timer timeout: 500 then: [ self onLeaveKioskMode ].
!
onLeaveKioskMode
	self assert: [ window kioskMode not ].

	window requestAttention: true.
	Timer timeout: 3000 then: [ self close ].
!

"Manual tests"

close
	"Only called in manual test, because it exits the app."
	window close.
	"window closeForce."
!
reload
	"Only called in manual test, because it restarts the app."
	window reload.
	"window reloadIgnoringCache."
!
devTools
	"Only called in manual test, because the dev tools window cannot be closed (NW.js bug)."
	window devTools: true.
!

"TODO: Test: open: url options: options"
"TODO: test: eval: script frame: frame"
