CLASS TestNavigator EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

browserOnly
	^ true.
!
test
	| navigator |

	navigator := Window default navigator.

	self assert: [ navigator clipboard class = Clipboard ].
	self assert: [ navigator cookieEnabled class = Boolean ].
	self assert: [ navigator geolocation class = Geolocation ].
	self assert: [ navigator hardwareConcurrency >= 1 ].
	self assert: [ navigator language  includes: '-' ].
	self assert: [ navigator languages length >= 1 ].
	self assert: [ navigator locks class = LockManager ].
	self assert: [ navigator maxTouchPoints >= 0 ].
	self assert: [ navigator mediaCapabilities class = MediaCapabilities ].
	self assert: [ navigator mediaDevices class = MediaDevices ].
	self assert: [ navigator mediaSession class = MediaSession ].
	self assert: [ navigator onLine class = Boolean ].
	self assert: [ navigator pdfViewerEnabled class = Boolean ].
	self assert: [ navigator permissions class = Permissions ].
	self assert: [ navigator serviceWorker class = ServiceWorkerContainer ].
	self assert: [ navigator storage class = StorageManager ].
	self assert: [ navigator userAgent includes: 'Mozilla' ].
	self assert: [ navigator sendBeacon: 'localhost' data: 'ping' ].
!


" TODO:
vibrate: pattern
	^ Boolean fromJs: INLINE 'this.js.vibrate( pattern.$toJs() )'.
!
"