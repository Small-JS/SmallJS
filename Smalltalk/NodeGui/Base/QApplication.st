CLASS QApplication EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

"The instances will always refer to the same JS QApplication object.
 App wide settings, that are static in JS, are class methods."

"Import all NodeGui JS classes for all classes of the NodeGui module.
 The JS classes are accessed with the prefix 'nodegui$.', e.g. 'new nodegui$.QLabel()'.
 The $ prevents name clashes with ST variables."
INLINE 'import * as nodegui$ from "@nodegui/nodegui";'

"JS QApplication.instance() creates a new JS wrapper on each call,
 so keep the first one, to make event listeners and equality work."
INLINE 'let qApplicationInstance$ = null;'

CLASSMETHODS

new
	^ self instance.
!
instance
	^ self fromJs: INLINE 'qApplicationInstance$ ??= nodegui$.QApplication.instance()'.
!

"App wide settings"

setApplicationDisplayName: name
	INLINE 'nodegui$.QApplication.setApplicationDisplayName( name.js )'.
!
applicationDisplayName
	^ String fromJs: INLINE 'nodegui$.QApplication.applicationDisplayName()'.
!
setDesktopFileName: name
	"Set the name of the .desktop file of the app, used on Linux."
	INLINE 'nodegui$.QApplication.setDesktopFileName( name.js )'.
!
desktopFileName
	^ String fromJs: INLINE 'nodegui$.QApplication.desktopFileName()'.
!
setDesktopSettingsAware: on
	"Set if the app should use the desktop settings, like fonts and colors.
	 Must be set before creating widgets."
	INLINE 'nodegui$.QApplication.setDesktopSettingsAware( on.js )'.
!
desktopSettingsAware
	^ Boolean fromJs: INLINE 'nodegui$.QApplication.desktopSettingsAware()'.
!
setWindowIcon: icon
	"Set the default icon of all windows."
	INLINE 'nodegui$.QApplication.setWindowIcon( icon.js )'.
!
windowIcon
	"JS QApplication.windowIcon() answers a native object, so wrap it in a JS QIcon."
	^ QIcon fromJs: INLINE 'new nodegui$.QIcon( nodegui$.QApplication.windowIcon() )'.
!
platformName
	"Answer the name of the Qt platform plugin, e.g. 'windows', 'cocoa', 'xcb' or 'wayland'."
	^ String fromJs: INLINE 'nodegui$.QApplication.platformName()'.
!

METHODS

"Control flow"

quit
	INLINE 'this.js.quit()'.
!
exit: exitCode
	"Quit the Qt event loop with exitCode."
	INLINE 'this.js.exit( exitCode.js )'.
!
processEvents
	"Process pending events, e.g. to update the GUI during a long computation."
	INLINE 'this.js.processEvents()'.
!
setQuitOnLastWindowClosed: quit
	INLINE 'this.js.setQuitOnLastWindowClosed( quit.js )'.
!
quitOnLastWindowClosed
	^ Boolean fromJs: INLINE 'this.js.quitOnLastWindowClosed()'.
!

"Appearance"

setStyleSheet: styleSheet
	"Set the style sheet of all widgets of the app."
	INLINE 'this.js.setStyleSheet( styleSheet.js )'.
!
devicePixelRatio
	"Answer the ratio of physical pixels to device independent pixels of the primary screen."
	^ Float fromJs: INLINE 'this.js.devicePixelRatio()'.
!

"Testing"

testMode
	^ Process argv includes: '-test'.
!
