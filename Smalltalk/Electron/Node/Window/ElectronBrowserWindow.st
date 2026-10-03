CLASS ElectronBrowserWindow EXTENDS ElectronBaseWindow MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS class: BrowserWindow.
 Note: Platform specific funcionality is not implemented, keeping it standard."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new electron$.BrowserWindow()'.
!
new: options
	^ self fromJs: INLINE 'new electron$.BrowserWindow( options.js )'.
!
allWindows
	^ Array fromJs: INLINE 'electron$.BrowserWindow.getAllWindows()' elementClass: self.
!
focusedWindow
	"Returns nil if no window is focused."
	^ self fromJs: INLINE 'electron$.BrowserWindow.getFocusedWindow()'.
!
fromId: id
	"Returns nil if no window has this id."
	^ self fromJs: INLINE 'electron$.BrowserWindow.fromId( id.js )'.
!

METHODS

"Loading"

loadFile: fileName then: block error: errorBlock
	self loadFile: fileName options: ElectronLoadFileOptions new then: block error: errorBlock.
!
loadFile: fileName options: options then: block error: errorBlock
	INLINE 'this.js.loadFile( fileName.js, options.js )
			.then( () => block.$value() )
			.catch( ( error ) => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
loadURL: url then: block error: errorBlock
	INLINE 'this.js.loadURL( url.js )
			.then( () => block.$value() )
			.catch( ( error ) => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
reload
	INLINE 'this.js.reload()'.
!

"Appearance"

opacity: opacity
	"Opacity is between 0 and 1.
	 Note: Implemented here because in BaseWindow it is platform specific."
	INLINE 'this.js.setOpacity( opacity.js )'.
!

"Web view focus"

focusOnWebView
	INLINE 'this.js.focusOnWebView()'.
!
blurWebView
	INLINE 'this.js.blurWebView()'.
!

"Web contents"

webContents
	^ ElectronWebContents fromJs: INLINE 'this.js.webContents'.
!

"Developer tools"

openDevTools
	INLINE 'this.js.webContents.openDevTools()'.
!
