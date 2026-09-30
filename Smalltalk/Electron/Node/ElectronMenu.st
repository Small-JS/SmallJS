CLASS ElectronMenu EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Note: Platform specific funcionality is not implemented, keeping it standard."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new electron$.Menu()'.
!
applicationMenu: menu
	INLINE 'electron$.Menu.setApplicationMenu( menu.js )'.
!

METHODS

"Modifying"

append: menuItemOptions
	"Note: The first argument is an *options* object, not a MenuItem object."
	INLINE 'this.js.append( new electron$.MenuItem( menuItemOptions.js ) )'.
!
insert: menuItemOptions position: position
	"Note: The first argument is an *options* object, not a MenuItem object."
	INLINE 'this.js.insert( position.js, new electron$.MenuItem( menuItemOptions.js ) )'.
!

"Popup"

popup
	INLINE 'this.js.popup()'.
!
closePopup
	INLINE 'this.js.closePopup()'.
!

"Accessing"

menuItemById: id
	"Returns nil if no item with the id exists."
	^ ElectronMenuItem fromJs: INLINE 'this.js.getMenuItemById( id.js )'.
!
