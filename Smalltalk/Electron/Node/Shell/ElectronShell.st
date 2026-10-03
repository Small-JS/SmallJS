CLASS ElectronShell EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS object: shell.
 Note: Platform specific funcionality is not implemented, keeping it standard.
 So the Windows shortcut link methods and the platform specific openExternal options are not implemented."

CLASSMETHODS

new
	^ self fromJs: INLINE 'electron$.shell'.
!

METHODS

"Opening"

async openExternal: url
	"Opens the external protocol URL in the desktop's default manner,
	 e.g. https: in the default browser, mailto: in the default mail agent.
	 Throws an error if the URL could not be opened."
	INLINE 'await this.js.openExternal( url.js )'.
!
async openPath: path
	"Opens the file in the desktop's default manner.
	 Returns an error message if opening failed, otherwise an empty string."
	^ String fromJs: INLINE 'await this.js.openPath( path.js )'.
!
showItemInFolder: fullPath
	"Shows the file in a file manager, and selects it if possible."
	INLINE 'this.js.showItemInFolder( fullPath.js )'.
!

"Deleting"

async trashItem: path
	"Moves the file or directory to the OS trash, e.g. the Recycle Bin on Windows.
	 Throws an error if the item could not be deleted.
	 Note: The path must use the platform path separator, use Path resolve: to ensure that."
	INLINE 'await this.js.trashItem( path.js )'.
!

"Sound"

beep
	INLINE 'this.js.beep()'.
!
