CLASS NwMenu EXTENDS JsObject MODULE Nwjs CLASSVARS '' VARS ''

CLASSMETHODS

new
	"Context menu is default type"
	^ self fromJs: INLINE 'new gui.Menu()'
!
newMenuBar
	"Context manu is default type"
	^ self fromJs: INLINE 'new gui.Menu( { type: "menubar" } )'.
!
setMacosMenuBar: menuBar
	"Extend application menu for Mac OS"
	INLINE '
		if( process.platform == "darwin" ) {
			if( menuBar.createMacBuiltin )
				menuBar.createMacBuiltin( window.document.title );
			gui.Window.get().menu = menu;
		}'
!

METHODS

type
	^ String fromJs: INLINE 'this.js.type'.
!
items
	^ Array fromJs: INLINE 'this.js.items' elementClass: NwMenuItem.
!
append: item
	INLINE 'this.js.append( item.js )'.
!
remove: item
	INLINE 'this.js.remove( item.js )'.
!
removeAt: index
	INLINE 'this.js.removeAt( index.js )'.
!
insert: item at: index
	INLINE 'this.js.insert( item.js, index.js )'.
!
popup: point
	INLINE 'this.js.popup( point.x.js, point.y.js )'.
!
createMacBuiltin: appName
	INLINE '
		if( this.js.createMacBuiltin )
			this.js.createMacBuiltin( appName.js )'.
!
createMacBuiltin: appName hideEdit: hideEdit hideWindow: hideWindow
	INLINE '
		if( this.js.createMacBuiltin )
			this.js.createMacBuiltin( appName.js,
			{ hideEdit: hideEdit.js, hindWindow: hideWindow.js } )'.
!
