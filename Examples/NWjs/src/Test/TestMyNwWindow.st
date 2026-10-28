CLASS TestMyNwWindow EXTENDS Object MODULE TestMyNwApp CLASSVARS ''
	VARS 'app window'

async test: aApp
	app := aApp.

	self testWindow.
	self testEval.
	await self testFileOpen.
	await self testOpen.
	await self testSize.
	await self testMinimizeMaximize.
	await self testMove.
	await self testFullscreen.
	await self testFocus.
	await self testShow.
	await self testAlwaysOnTop.
	await self testKioskMode.
	await self testAttention.
	self close.
!
testWindow
	| domWindow |

	window := NwWindow get.
	self assert: [ window class = NwWindow ].
	self assert: [ window title = 'My NW.js App' ].
	self assert: [ window menu class = NwMenu ].
	self assert: [ window zoomLevel = 0 ].

	domWindow := Window default.
	self assert: [ ( NwWindow get: domWindow ) window = domWindow ].
!
testEval
	"A nil frame evaluates the script in the main frame of the window."
	window eval: 'window.testEvalResult = 6 * 7;' frame: nil.
	self assert: [ ( window window atJsProperty: 'testEvalResult' ) = 42 ].
!
async testOpen
	| options childWindow |

	options := JsObject newEmpty.
	options atJsProperty: 'width' put: 300.
	options atJsProperty: 'height' put: 200.
	childWindow := await NwWindow open: 'child.html' options: options.
	self assert: [ childWindow class = NwWindow ].

	"Wait for the child page to load."
	await Timer timeout: 1000.
	self assert: [ childWindow title = 'My NW.js Child Window' ].
	self assert: [ childWindow size >= ( 300 @ 200 ) ].
	self assert: [ childWindow size < ( 400 @ 300 ) ].

	"Focus and show must be read from the child window's own document."
	self assert: [ childWindow show ].
	Window isWindows ifTrue: [
		self assert: [ childWindow focus ].
		self assert: [ window focus not ] ].

	childWindow close.
	window focus: true.
	await Timer timeout: 500.
!
async testFileOpen
	app fileOpenButton click.
	await Timer timeout: 1000.
	self assert: [ app fileTextArea value includes: 'Lizard' ].
!
async testSize
	| oldSize |

	window moveToCenter.
	window resizable: true.
	"Minimum and maximum sizes are only enforced after window move or resize,
	 so they are not tested here."
	window minimumSize: 100 @ 200.
	window maximumSize: 800 @ 600.
	await Timer timeout: 500.

	"Window sizing operations are executed async,
	so small delay is done before checking each result,
	which also allows for a visual check."


	"Resizing sets the *inner* window size,
	 while window size gives the *outer* window size."
	window resizeTo: ( 400 @ 200 ).
	await Timer timeout: 500.
	self assert: [ window size >= ( 400 @ 200 ) ].
	self assert: [ window size < ( 500 @ 300 ) ].

	oldSize := window size.
	window resizeBy: ( 20 @ 10 ).
	await Timer timeout: 500.

	"2025-10-03: ResizeBy does not work anymore?
		And can even *reduce* the window size by 1 because of rounding?"
	"self assert: [ window size >= ( oldSize + ( 20 @ 10 ) ) ]."
	self assert: [ window size + ( 5 @ 5 ) >= oldSize ].

	"Remove the size limits again (0 means no limit),
	 so they do not constrain the next tests, like maximizing."
	window minimumSize: 0 @ 0.
	window maximumSize: 0 @ 0.
!
async testMinimizeMaximize
	| oldSize |

	"Skip minimizing and maximizing tests on Linux because of this issue:
	 https://github.com/nwjs/nw.js/issues/8291"
	"Skip minimizing and maximizing tests on Macos because of issues."
	Window isLinux | Window isMacos ifTrue: [ ^ self ].

	oldSize := window size.
	window maximize.
	await Timer timeout: 500.
	"Maximizing does not change the NW.js window size,
	 but the DOM window size *is* changed."
	self assert: [ window window innerSize > oldSize ].

	window minimize.
	"MacOS needs longer timeout because of animations."
	await Timer timeout: 1000.
	self assert: [ Document default hidden ].

	window restore.
	window focus: true.
	await Timer timeout: 1000.
	self assert: [ Document default hidden not ].

	window resizeTo: oldSize.
	await Timer timeout: 500.
!
async testMove
	window moveTo: ( 200 @ 100 ).
	await Timer timeout: 500.
	self assert: [ window offset = ( 200 @ 100 ) ].

	window moveBy: ( 20 @ 10 ).
	await Timer timeout: 500.
	self assert: [ window offset >= ( 218 @ 108 ) ].

	window moveToCenter.
	await Timer timeout: 500.
	self assert: [ window offset > ( 220 @ 110 ) ].
!
async testFullscreen
	window fullscreen: true.
	await Timer timeout: 1000.
	self assert: [ window fullscreen ].

	window fullscreen: false.
	await Timer timeout: 1000.
	self assert: [ window fullscreen not ].
!
async testFocus
	"Does not work right on MacOS and Linux."
	Window isWindows ifFalse: [ ^ nil ].

	window focus: false.
	await Timer timeout: 500.
	self assert: [ window focus not ].

	window focus: true.
	await Timer timeout: 500.
	self assert: [ window focus ].
!
async testShow
	window show: false.
	await Timer timeout: 500.
	self assert: [ window show not ].

	window show: true.
	window focus: true.
	await Timer timeout: 500.
	"Unfortunately, window.show does not restore the document visibility state,
	even though the document is shown."
	"self assert: [ window show ]."
!
async testAlwaysOnTop
	window alwaysOnTop: true.
	await Timer timeout: 500.
	self assert: [ window alwaysOnTop ].

	window alwaysOnTop: false.
	await Timer timeout: 500.
	self assert: [ window alwaysOnTop not ].
!
async testKioskMode
	"Skip kiosk mode on MacOS because the app won't quit anymore after using it."
	Window isMacos ifTrue: [ ^ self ].

	window kioskMode: true.
	await Timer timeout: 500.
	self assert: [ window kioskMode ].

	window kioskMode: false.
	await Timer timeout: 500.
	self assert: [ window kioskMode not ].
!
async testAttention
	window requestAttention: true.
	await Timer timeout: 3000.
!
close
	window close.
	"window closeForce."
	"app quit."
!

"Manual tests"

reload
	"Only called in manual test, because it restarts the app."
	window reload.
	"window reloadIgnoringCache."
!
devTools
	"Only called in manual test, because the dev tools window cannot be closed (NW.js bug)."
	window devTools: true.
!
