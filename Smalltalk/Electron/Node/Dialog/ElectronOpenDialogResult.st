CLASS ElectronOpenDialogResult EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS interface: OpenDialogReturnValue.
 Note: Platform specific funcionality is not implemented, keeping it standard."

METHODS

canceled
	^ Boolean fromJs: INLINE 'this.js.canceled'.
!
filePaths
	"Empty if canceled."
	^ Array fromJsStrings: INLINE 'this.js.filePaths'.
!
