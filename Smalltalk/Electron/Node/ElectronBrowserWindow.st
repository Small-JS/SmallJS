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

"Developer tools"

openDevTools
	"2024-09-01:
	 This request currently produces this error on the rendering console: 'Request Autofill.enable failed.'
	 This is an Electron issue that is reported here: https://github.com/electron/electron/issues/41614"
	INLINE 'this.js.webContents.openDevTools()'.
!
