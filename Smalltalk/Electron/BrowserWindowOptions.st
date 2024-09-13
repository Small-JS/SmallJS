CLASS BrowserWindowOptions EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements JS class: BrowserWindowConstructorOptions."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

width
	^ Integer fromJs: INLINE 'this.js.width'.
!
width: width
	INLINE 'this.js.width = width.js'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
height: height
	INLINE 'this.js.height = height.js'.
!
webPreferences
	^ WebPreferences fromJs: INLINE 'this.js.webPreferences'.
!
webPreferences: webPreferences
	INLINE 'this.js.webPreferences = webPreferences.js'.
!
