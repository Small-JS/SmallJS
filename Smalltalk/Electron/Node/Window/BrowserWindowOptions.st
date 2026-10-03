CLASS BrowserWindowOptions EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements JS class: BrowserWindowConstructorOptions.
 Note: Platform specific funcionality is not implemented, keeping it standard."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

"Position & size"

x
	^ Integer fromJs: INLINE 'this.js.x'.
!
x: x
	"Note: Must be used together with y."
	INLINE 'this.js.x = x.js'.
!
y
	^ Integer fromJs: INLINE 'this.js.y'.
!
y: y
	"Note: Must be used together with x."
	INLINE 'this.js.y = y.js'.
!
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
useContentSize
	^ Boolean fromJs: INLINE 'this.js.useContentSize'.
!
useContentSize: useContentSize
	"If true, width and height are used as the web page size, excluding the window frame."
	INLINE 'this.js.useContentSize = useContentSize.js'.
!
center
	^ Boolean fromJs: INLINE 'this.js.center'.
!
center: center
	INLINE 'this.js.center = center.js'.
!
minWidth
	^ Integer fromJs: INLINE 'this.js.minWidth'.
!
minWidth: minWidth
	INLINE 'this.js.minWidth = minWidth.js'.
!
minHeight
	^ Integer fromJs: INLINE 'this.js.minHeight'.
!
minHeight: minHeight
	INLINE 'this.js.minHeight = minHeight.js'.
!
maxWidth
	^ Integer fromJs: INLINE 'this.js.maxWidth'.
!
maxWidth: maxWidth
	INLINE 'this.js.maxWidth = maxWidth.js'.
!
maxHeight
	^ Integer fromJs: INLINE 'this.js.maxHeight'.
!
maxHeight: maxHeight
	INLINE 'this.js.maxHeight = maxHeight.js'.
!

"Behavior"

resizable
	^ Boolean fromJs: INLINE 'this.js.resizable'.
!
resizable: resizable
	INLINE 'this.js.resizable = resizable.js'.
!
focusable
	^ Boolean fromJs: INLINE 'this.js.focusable'.
!
focusable: focusable
	INLINE 'this.js.focusable = focusable.js'.
!
alwaysOnTop
	^ Boolean fromJs: INLINE 'this.js.alwaysOnTop'.
!
alwaysOnTop: alwaysOnTop
	INLINE 'this.js.alwaysOnTop = alwaysOnTop.js'.
!
fullscreen
	^ Boolean fromJs: INLINE 'this.js.fullscreen'.
!
fullscreen: fullscreen
	INLINE 'this.js.fullscreen = fullscreen.js'.
!
fullscreenable
	^ Boolean fromJs: INLINE 'this.js.fullscreenable'.
!
fullscreenable: fullscreenable
	INLINE 'this.js.fullscreenable = fullscreenable.js'.
!
kiosk
	^ Boolean fromJs: INLINE 'this.js.kiosk'.
!
kiosk: kiosk
	INLINE 'this.js.kiosk = kiosk.js'.
!
disableAutoHideCursor
	^ Boolean fromJs: INLINE 'this.js.disableAutoHideCursor'.
!
disableAutoHideCursor: disableAutoHideCursor
	INLINE 'this.js.disableAutoHideCursor = disableAutoHideCursor.js'.
!

"Showing"

show
	^ Boolean fromJs: INLINE 'this.js.show'.
!
show: show
	"If false, the window is created hidden."
	INLINE 'this.js.show = show.js'.
!
paintWhenInitiallyHidden
	^ Boolean fromJs: INLINE 'this.js.paintWhenInitiallyHidden'.
!
paintWhenInitiallyHidden: paintWhenInitiallyHidden
	INLINE 'this.js.paintWhenInitiallyHidden = paintWhenInitiallyHidden.js'.
!

"Parent"

parent
	^ ElectronBaseWindow fromJs: INLINE 'this.js.parent'.
!
parent: window
	INLINE 'this.js.parent = window.js'.
!
modal
	^ Boolean fromJs: INLINE 'this.js.modal'.
!
modal: modal
	"Note: Only works when the window has a parent."
	INLINE 'this.js.modal = modal.js'.
!

"Appearance"

title
	^ String fromJs: INLINE 'this.js.title'.
!
title: title
	"Note: Ignored if the loaded HTML has a <title> tag."
	INLINE 'this.js.title = title.js'.
!
icon
	"Note: Only returns the icon if it was set as a file path string."
	^ String fromJs: INLINE '( typeof this.js.icon === "string" ? this.js.icon : null )'.
!
icon: path
	INLINE 'this.js.icon = path.js'.
!
frame
	^ Boolean fromJs: INLINE 'this.js.frame'.
!
frame: frame
	"If false, a frameless window is created."
	INLINE 'this.js.frame = frame.js'.
!
titleBarStyle
	^ String fromJs: INLINE 'this.js.titleBarStyle'.
!
titleBarStyle: titleBarStyle
	"Note: Only 'default' and 'hidden' work on all platforms."
	INLINE 'this.js.titleBarStyle = titleBarStyle.js'.
!
hasShadow
	^ Boolean fromJs: INLINE 'this.js.hasShadow'.
!
hasShadow: hasShadow
	INLINE 'this.js.hasShadow = hasShadow.js'.
!
roundedCorners
	^ Boolean fromJs: INLINE 'this.js.roundedCorners'.
!
roundedCorners: roundedCorners
	"Note: Only for frameless windows."
	INLINE 'this.js.roundedCorners = roundedCorners.js'.
!
transparent
	^ Boolean fromJs: INLINE 'this.js.transparent'.
!
transparent: transparent
	INLINE 'this.js.transparent = transparent.js'.
!
backgroundColor
	^ String fromJs: INLINE 'this.js.backgroundColor'.
!
backgroundColor: color
	"A CSS color string, e.g. '#FFFFFF'."
	INLINE 'this.js.backgroundColor = color.js'.
!

"Identification"

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	"Unique internal identifier of the window, not the visible title."
	INLINE 'this.js.name = name.js'.
!

"Web"

webPreferences
	^ ElectronWebPreferences fromJs: INLINE 'this.js.webPreferences'.
!
webPreferences: webPreferences
	INLINE 'this.js.webPreferences = webPreferences.js'.
!
