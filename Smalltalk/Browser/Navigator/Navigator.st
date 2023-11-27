CLASS Navigator EXTENDS JsObject MODULE DOM CLASSVARS '' VARS ''
	"This class encasulates the JS class: Navigator.
	 An instance can be accesses through: Windows default navigator."

"Properties"

clipboard
	^ Clipboard fromJs: INLINE 'this.js.clipboard'.
!
cookieEnabled
	^ Boolean fromJs: INLINE 'this.js.cookieEnabled'.
!
credentials
	^ CredentialsContainer fromJs: INLINE 'this.js.credentials'.
!
geolocation
	^ Geolocation fromJs: INLINE 'this.js.geolocation'.
!
hardwareConcurrency
	^ Integer fromJs: INLINE 'this.js.hardwareConcurrency'.
!
language
	^ String fromJs: INLINE 'this.js.language'.
!
languages
	^ Array fromJs: INLINE 'this.js.languages' elementClass: String.
!
locks
	^ LockManager fromJs: INLINE 'this.js.locks'.
!
maxTouchPoints
	^ Integer fromJs: INLINE 'this.js.maxTouchPoints'.
!
mediaCapabilities
	^ MediaCapabilities fromJs: INLINE 'this.js.mediaCapabilities'.
!
mediaDevices
	^ MediaDevices fromJs: INLINE 'this.js.mediaDevices'.
!
mediaSession
	^ MediaSession fromJs: INLINE 'this.js.mediaSession'.
!
onLine
	^ Boolean fromJs: INLINE 'this.js.onLine'.
!
pdfViewerEnabled
	^ Boolean fromJs: INLINE 'this.js.pdfViewerEnabled'.
!
permissions
	^ Permissions fromJs: INLINE 'this.js.permissions'.
!
platform
	^ String fromJs: INLINE 'this.js.platform'.
!
serviceWorker
	^ ServiceWorkerContainer fromJs: INLINE 'this.js.serviceWorker'.
!
storage
	^ StorageManager fromJs: INLINE 'this.js.storage'.
!
userAgent
	^ String fromJs: INLINE 'this.js.userAgent'.
!
webdriver
	^ Boolean fromJs: INLINE 'this.js.webdriver'.
!

"Methods"

sendBeacon: url data: data
	^ Boolean fromJs: INLINE 'this.js.sendBeacon( url.js, data.js )'.
!
vibrate: pattern
	^ Boolean fromJs: INLINE 'this.js.vibrate( pattern.$toJs() )'.
!
