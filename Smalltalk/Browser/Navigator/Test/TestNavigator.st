CLASS TestNavigator EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| navigator |

	navigator := Window default navigator.

	self assert: [ navigator clipboard class = Clipboard ].
	self assert: [ navigator cookieEnabled class = Boolean ].
	self assert: [ navigator geolocation class = Geolocation ].
	self assert: [ navigator hardwareConcurrency >= 1 ].
	self assert: [ navigator language  includes: '-' ].
	self assert: [ navigator languages length >= 1 ].
	self assert: [ navigator maxTouchPoints >= 0 ].
	self assert: [ navigator onLine class = Boolean ].
	self assert: [ navigator pdfViewerEnabled class = Boolean ].
	self assert: [ navigator platform class = String ].
	self assert: [ navigator permissions class = Permissions ].
	self assert: [ navigator storage class = StorageManager ].
	self assert: [ navigator userAgent includes: 'Mozilla' ].

	"2024-05-18: This currently results in error 405: Method not allowed"
	"self assert: [ navigator sendBeacon: '/' data: 'ping' ]."
!


" TODO:
vibrate: pattern
	^ Boolean fromJs: INLINE 'this.js.vibrate( pattern.$toJs() )'.
!
"