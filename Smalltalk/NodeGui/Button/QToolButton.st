CLASS QToolButton EXTENDS QAbstractButton MODULE NodeGui CLASSVARS '' VARS ''

"A button for quick access to commands, usually in a tool bar, often showing only an icon.
 Signals: those of QAbstractButton and 'triggered'."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QToolButton()'.
!

"Arrow type enums"

noArrow
	^ 0.
!
upArrow
	^ 1.
!
downArrow
	^ 2.
!
leftArrow
	^ 3.
!
rightArrow
	^ 4.
!

"Popup mode enums"

delayedPopup
	"The menu is shown when the button is held down for a while."
	^ 0.
!
menuButtonPopup
	"The menu is shown when clicking a separate arrow next to the button."
	^ 1.
!
instantPopup
	"The menu is shown when the button is pressed. The button does not click."
	^ 2.
!

"Tool button style enums"

iconOnly
	^ 0.
!
textOnly
	^ 1.
!
textBesideIcon
	^ 2.
!
textUnderIcon
	^ 3.
!
followStyle
	"Use the style of the platform."
	^ 4.
!

METHODS

"Appearance"

setArrowType: arrowType
	"Show an arrow instead of the icon. ArrowType is an arrow type enum."
	INLINE 'this.js.setArrowType( arrowType.js )'.
!
arrowType
	^ Integer fromJs: INLINE 'this.js.arrowType()'.
!
setAutoRaise: enable
	"An auto raise button only shows its border when the mouse is over it."
	INLINE 'this.js.setAutoRaise( enable.js )'.
!
autoRaise
	^ Boolean fromJs: INLINE 'this.js.autoRaise()'.
!
setToolButtonStyle: style
	"Set if the icon and text are shown. Style is a tool button style enum."
	INLINE 'this.js.setToolButtonStyle( style.js )'.
!
toolButtonStyle
	^ Integer fromJs: INLINE 'this.js.toolButtonStyle()'.
!

"Menu"

setMenu: menu
	INLINE 'this.js.setMenu( menu.js )'.
!
menu
	self error: 'QToolButton.menu() not implemented in NodeGui yet (28-OCT-2026).'
	"^ QMenu fromJs: INLINE 'this.js.menu()'."
!
setPopupMode: mode
	"Set how the menu is shown. Mode is a popup mode enum."
	INLINE 'this.js.setPopupMode( mode.js )'.
!
popupMode
	^ Integer fromJs: INLINE 'this.js.popupMode()'.
!
showMenu
	"Show the menu of the button. Waits until the user closes the menu."
	INLINE 'this.js.showMenu()'.
!

"Default action"

setDefaultAction: action
	"The button takes its text, icon and shortcut from action, and triggers it when clicked."
	INLINE 'this.js.setDefaultAction( action.js )'.
!
defaultAction
	"Answer nil if there is no default action."
	^ QAction fromJs: INLINE 'this.js.defaultAction()'.
!
