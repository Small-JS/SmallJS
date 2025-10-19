CLASS BrowserWindow EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

CLASSMETHODS

new: options
	^ self fromJs: INLINE 'new BrowserWindow( options.js )'.
!

METHODS

loadFile: fileName then: block error: errorBlock
	self loadFile: fileName options: ElectronLoadFileOptions new then: block error: errorBlock.
!
loadFile: fileName options: options then: block error: errorBlock
	INLINE 'this.js.loadFile( fileName.js, options.js )
			.then( () => block.$value() )
			.catch( ( error ) => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
openDevTools
	"2024-09-01:
	 This request currently produces this error on the rendering console: 'Request Autofill.enable failed.'
	 This is an Electron issue that is reported here: https://github.com/electron/electron/issues/41614"
	INLINE 'this.js.webContents.openDevTools()'.
!
setTitle: title
	INLINE 'this.js.setTitle( title.js )'.
!
