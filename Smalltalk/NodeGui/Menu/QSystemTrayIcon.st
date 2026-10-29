CLASS QSystemTrayIcon EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

"An icon in the system tray of the platform, with a context menu and tool tip.
 It is not visible until show is called."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QSystemTrayIcon()'.
!

"Activation reason enums, passed to the onActivate: block"

unknown
	^ 0.
!
context
	"The context menu was requested."
	^ 1.
!
doubleClick
	^ 2.
!
trigger
	"The icon was clicked."
	^ 3.
!
middleClick
	^ 4.
!

METHODS

"Showing"

show
	INLINE 'this.js.show()'.
!
hide
	INLINE 'this.js.hide()'.
!
isVisible
	^ Boolean fromJs: INLINE 'this.js.isVisible()'.
!

"Content"

setIcon: icon
	INLINE 'this.js.setIcon( icon.js )'.
!
setToolTip: toolTip
	INLINE 'this.js.setToolTip( toolTip.js )'.
!
toolTip
	^ String fromJs: INLINE 'this.js.property( "toolTip" ).toString()'.
!
setContextMenu: menu
	"Menu is shown when the user right-clicks the icon. The tray icon does not own menu."
	INLINE 'this.js.setContextMenu( menu.js )'.
!

"Messages"

showMessage: title text: text
	"Show a balloon message near the icon, for 10 seconds."
	INLINE 'this.js.showMessage( title.js, text.js )'.
!
showMessage: title text: text icon: icon timeout: timeout
	"Timeout is in milliseconds. The platform may ignore it."
	INLINE 'this.js.showMessage( title.js, text.js, icon.js, timeout.js )'.
!

"Events"

onActivate: block
	"Block is called with the activation reason, see the activation reason enums."
	INLINE 'this.js.addEventListener( "activated", reason => block.$value$( stInteger$class.$fromJs$( reason ) ) )'.
!
onMessageClick: block
	self addEventListener: 'messageClicked' then: [ block value ].
!
