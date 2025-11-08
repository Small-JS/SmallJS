CLASS NwWindow EXTENDS JsObject MODULE Nwjs CLASSVARS '' VARS ''

CLASSMETHODS

get
	^ NwWindow fromJs: INLINE 'gui.Window.get()'.
!
get: domWindow
	^ NwWindow fromJs: INLINE 'gui.Window.get( domWindow.js )'.
!
open: url options: options
	^ NwWindow fromJs: INLINE 'gui.Window.open( url.js, options.js )'.
!

METHODS

window
	^ Window fromJs: INLINE 'this.js.window'.
!
"Properties"

offset
	^ Point jsX: INLINE 'this.js.x' jsY: INLINE 'this.js.y'.
!
size
	^ Point jsX: INLINE 'this.js.width' jsY: INLINE 'this.js.height'.
!
title
	^ String fromJs: INLINE 'this.js.title'.
!
menu
	^ NwMenu fromJs: INLINE 'this.js.menu'.
!
menu: menuBar
	INLINE 'this.js.menu = menuBar.js'.
!

"Zooming"

zoomLevel
	^ Float fromJs: INLINE 'this.js.zoomLevel'.
!

"Moving"

moveTo: point
	INLINE 'this.js.moveTo( point.x.js, point.y.js )'.
!
moveBy: point
	INLINE 'this.js.moveBy( point.x.js, point.y.js )'.
!
moveToCenter
	INLINE 'this.js.setPosition( "center" )'.
!

"Sizing"

resizeTo: point
	INLINE 'this.js.resizeTo( point.x.js, point.y.js )'.
!
resizeBy: point
	INLINE 'this.js.resizeBy( point.x.js, point.y.js )'.
!
maximize
	INLINE 'this.js.maximize()'.
!
restore
	INLINE 'this.js.restore()'.
!
minimize
	INLINE 'this.js.minimize()'.
!
maximumSize: point
	INLINE 'this.js.setMaximumSize( point.x.js, point.y.js )'.
!
minimumSize: point
	INLINE 'this.js.setMinimumSize( point.x.js, point.y.js )'.
!
resizable: resizable
	INLINE 'this.js.setResizable( resizable.js )'.
!

"Fullscreen"

fullscreen
	^ Boolean fromJs: INLINE 'this.js.isFullscreen'.
!
fullscreen: fullscreen
	fullscreen
		ifTrue: [ INLINE 'this.js.enterFullscreen()' ]
		ifFalse: [ INLINE 'this.js.leaveFullscreen()' ]
!

"Focus"

focus
	^ Document default hasFocus.
!
focus: focus
	focus
		ifTrue: [ INLINE 'this.js.focus()' ]
		ifFalse: [ INLINE 'this.js.blur()' ]
!

"Showing"

show
	^ Document default hidden not.
!
show: show
	show
		ifTrue: [ INLINE 'this.js.show()' ]
		ifFalse: [ INLINE 'this.js.hide()' ]
!

"AlwaysOnTop"

alwaysOnTop
	^ Boolean fromJs: INLINE 'this.js.isAlwaysOnTop'.
!
alwaysOnTop: alwaysOnTop
	INLINE 'this.js.setAlwaysOnTop( alwaysOnTop.js )'.
!

"Opening / closing"

close
	INLINE 'this.js.close()'.
!
closeForce
	INLINE 'this.js.close( true )'.
!
reload
	INLINE 'this.js.reload()'.
!
reloadIgnoringCache
	INLINE 'this.js.reloadIgnoringCache()'.
!

"Kiosk mode"

kioskMode
	^ Boolean fromJs: INLINE 'this.js.isKioskMode'.
!
kioskMode: kioskMode
	kioskMode
		ifTrue: [ INLINE 'this.js.enterKioskMode()' ]
		ifFalse: [ INLINE 'this.js.leaveKioskMode()' ]
!

"Attention"

requestAttention: requestAttention
	"requestAttention can be boolean or integer flash count."
	INLINE 'this.js.requestAttention( requestAttention.js )'.
!

"Dev tools"

devTools: devTools
	"2025-08-11 Closing dev tools does not work."
	devTools
		ifTrue: [ INLINE 'this.js.showDevTools()' ]
		ifFalse: [ INLINE 'this.js.closeDevTools()' ]
!
eval: script frame: frame
	INLINE 'this.js.eval( frame.js, script.js )'.
!

