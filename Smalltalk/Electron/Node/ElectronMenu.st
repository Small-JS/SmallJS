CLASS ElectronMenu EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Note: Platform specific funcionality is not implemented, keeing it standard."

INLINE 'import { Menu } from "electron";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Menu()'.
!
setApplicationMenu: menu
	INLINE 'Menu.setApplicationMenu( menu.js )'.
!

METHODS

"Modifying"

append: menuItemOptions
	"Note: The first argument is an *options* object, not a MenuItem object."
	INLINE 'this.js.append( new MenuItem( menuItemOptions.js ) )'.
!
insert: menuItemOptions position: position
	"Note: The first argument is an *options* object, not a MenuItem object."
	INLINE 'this.js.insert( new MenuItem( menuItemOptions.js ), position.js )'.
!

"Popup"

popup
	INLINE 'this.js.popup()'.
!
closePopup
	INLINE 'this.js.closePopup()'.
!

"Accessing"

getMenuItemById: id
	ElectronMenuItem fromJs: INLINE 'this.js.getMenuItemById( id.js )'.
!
