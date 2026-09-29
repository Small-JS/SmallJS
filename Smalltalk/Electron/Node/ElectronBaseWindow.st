CLASS ElectronBaseWindow EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS class: BaseWindow.
 Note: Platform specific funcionality is not implemented, keeping it standard.
 Sizes and positions are returned as Point, bounds as Rect."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new electron$.BaseWindow()'.
!
new: options
	^ self fromJs: INLINE 'new electron$.BaseWindow( options.js )'.
!
allWindows
	^ Array fromJs: INLINE 'electron$.BaseWindow.getAllWindows()' elementClass: self.
!
focusedWindow
	"Returns nil if no window is focused."
	^ self fromJs: INLINE 'electron$.BaseWindow.getFocusedWindow()'.
!
fromId: id
	"Returns nil if no window has this id."
	^ self fromJs: INLINE 'electron$.BaseWindow.fromId( id.js )'.
!

METHODS

"Window events"

onWindowEvent: event then: block
	"Note: The block receives the JS arguments of the event."
	INLINE 'this.js.on( event.js, block.js )'.
!
onceWindowEvent: event then: block
	"Note: The block receives the JS arguments of the event."
	INLINE 'this.js.once( event.js, block.js )'.
!

"Opening & closing"

close
	INLINE 'this.js.close()'.
!
destroy
	INLINE 'this.js.destroy()'.
!
destroyed
	^ Boolean fromJs: INLINE 'this.js.isDestroyed()'.
!

"Focus & visibility"

focus
	INLINE 'this.js.focus()'.
!
blur
	INLINE 'this.js.blur()'.
!
focused
	^ Boolean fromJs: INLINE 'this.js.isFocused()'.
!
show
	INLINE 'this.js.show()'.
!
showInactive
	INLINE 'this.js.showInactive()'.
!
hide
	INLINE 'this.js.hide()'.
!
visible
	^ Boolean fromJs: INLINE 'this.js.isVisible()'.
!
modal
	^ Boolean fromJs: INLINE 'this.js.isModal()'.
!
enabled: enable
	INLINE 'this.js.setEnabled( enable.js )'.
!
enabled
	^ Boolean fromJs: INLINE 'this.js.isEnabled()'.
!
flashFrame: flag
	INLINE 'this.js.flashFrame( flag.js )'.
!

"Window state"

maximize
	INLINE 'this.js.maximize()'.
!
unmaximize
	INLINE 'this.js.unmaximize()'.
!
maximized
	^ Boolean fromJs: INLINE 'this.js.isMaximized()'.
!
minimize
	INLINE 'this.js.minimize()'.
!
restore
	INLINE 'this.js.restore()'.
!
minimized
	^ Boolean fromJs: INLINE 'this.js.isMinimized()'.
!
normal
	^ Boolean fromJs: INLINE 'this.js.isNormal()'.
!
fullScreen
	^ Boolean fromJs: INLINE 'this.js.fullScreen'.
!
fullScreen: flag
	INLINE 'this.js.fullScreen = flag.js'.
!
fullScreenable
	^ Boolean fromJs: INLINE 'this.js.fullScreenable'.
!
fullScreenable: fullScreenable
	INLINE 'this.js.fullScreenable = fullScreenable.js'.
!
kiosk
	^ Boolean fromJs: INLINE 'this.js.kiosk'.
!
kiosk: flag
	INLINE 'this.js.kiosk = flag.js'.
!
alwaysOnTop: flag
	INLINE 'this.js.setAlwaysOnTop( flag.js )'.
!
alwaysOnTop: flag level: level
	"Level is one of: 'normal', 'floating', 'torn-off-menu', 'modal-panel', 'main-menu',
	 'status', 'pop-up-menu', 'screen-saver'."
	INLINE 'this.js.setAlwaysOnTop( flag.js, level.js )'.
!
alwaysOnTop
	^ Boolean fromJs: INLINE 'this.js.isAlwaysOnTop()'.
!
moveTop
	INLINE 'this.js.moveTop()'.
!
moveAbove: mediaSourceId
	INLINE 'this.js.moveAbove( mediaSourceId.js )'.
!
mediaSourceId
	^ String fromJs: INLINE 'this.js.getMediaSourceId()'.
!

"Bounds, size & position"

bounds
	^ Rect fromJs: INLINE 'this.js.getBounds()'.
!
bounds: rect
	self bounds: rect animate: false.
!
bounds: rect animate: animate
	INLINE 'this.js.setBounds( this.$jsRect$( rect ), animate.js )'.
!
contentBounds
	^ Rect fromJs: INLINE 'this.js.getContentBounds()'.
!
contentBounds: rect
	self contentBounds: rect animate: false.
!
contentBounds: rect animate: animate
	INLINE 'this.js.setContentBounds( this.$jsRect$( rect ), animate.js )'.
!
normalBounds
	^ Rect fromJs: INLINE 'this.js.getNormalBounds()'.
!
size
	^ Point fromJsArray: INLINE 'this.js.getSize()'.
!
size: size
	self size: size animate: false.
!
size: size animate: animate
	INLINE 'this.js.setSize( size.$x().js, size.$y().js, animate.js )'.
!
contentSize
	^ Point fromJsArray: INLINE 'this.js.getContentSize()'.
!
contentSize: size
	self contentSize: size animate: false.
!
contentSize: size animate: animate
	INLINE 'this.js.setContentSize( size.$x().js, size.$y().js, animate.js )'.
!
minimumSize
	^ Point fromJsArray: INLINE 'this.js.getMinimumSize()'.
!
minimumSize: size
	INLINE 'this.js.setMinimumSize( size.$x().js, size.$y().js )'.
!
maximumSize
	^ Point fromJsArray: INLINE 'this.js.getMaximumSize()'.
!
maximumSize: size
	INLINE 'this.js.setMaximumSize( size.$x().js, size.$y().js )'.
!
position
	^ Point fromJsArray: INLINE 'this.js.getPosition()'.
!
position: position
	self position: position animate: false.
!
position: position animate: animate
	INLINE 'this.js.setPosition( position.$x().js, position.$y().js, animate.js )'.
!
center
	INLINE 'this.js.center()'.
!
aspectRatio: aspectRatio
	"An aspect ratio of 0 removes the constraint."
	INLINE 'this.js.setAspectRatio( aspectRatio.js )'.
!
resizable
	^ Boolean fromJs: INLINE 'this.js.resizable'.
!
resizable: resizable
	INLINE 'this.js.resizable = resizable.js'.
!

"Appearance"

title
	^ String fromJs: INLINE 'this.js.title'.
!
title: title
	INLINE 'this.js.title = title.js'.
!
accessibleTitle
	^ String fromJs: INLINE 'this.js.accessibleTitle'.
!
accessibleTitle: title
	INLINE 'this.js.accessibleTitle = title.js'.
!
backgroundColor
	"Returns a hex color string, e.g. '#FFFFFF'."
	^ String fromJs: INLINE 'this.js.getBackgroundColor()'.
!
backgroundColor: color
	"Color is a CSS color string, e.g. '#FF0000' or 'red'."
	INLINE 'this.js.setBackgroundColor( color.js )'.
!
opacity
	^ Float fromJs: INLINE 'this.js.getOpacity()'.
!
hasShadow
	^ Boolean fromJs: INLINE 'this.js.hasShadow()'.
!
hasShadow: hasShadow
	INLINE 'this.js.setHasShadow( hasShadow.js )'.
!
shadow
	^ Boolean fromJs: INLINE 'this.js.shadow'.
!
shadow: hasShadow
	INLINE 'this.js.shadow = hasShadow.js'.
!
progressBar: progress
	"Progress is between 0 and 1. A negative value removes the progress bar."
	INLINE 'this.js.setProgressBar( progress.js )'.
!
ignoreMouseEvents: ignore
	INLINE 'this.js.setIgnoreMouseEvents( ignore.js )'.
!

"Parent & child windows"

parentWindow
	"Returns nil if there is no parent window."
	^ self class fromJs: INLINE 'this.js.getParentWindow()'.
!
parentWindow: parent
	"Pass nil to remove the parent window."
	INLINE 'this.js.setParentWindow( parent.js ?? null )'.
!
childWindows
	^ Array fromJs: INLINE 'this.js.getChildWindows()' elementClass: self class.
!

"Information"

id
	^ Integer fromJs: INLINE 'this.js.id'.
!

"Private"

jsRect: rect
	"Converts a Rect to a JS Electron Rectangle."
	^ INLINE '{
		x: rect.$origin().$x().js, y: rect.$origin().$y().js,
		width: rect.$extent().$x().js, height: rect.$extent().$y().js }'.
!
