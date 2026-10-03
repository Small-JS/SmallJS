CLASS ElectronSaveDialogResult EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS interface: SaveDialogReturnValue.
 Note: Platform specific funcionality is not implemented, keeping it standard."

METHODS

canceled
	^ Boolean fromJs: INLINE 'this.js.canceled'.
!
filePath
	"Empty if canceled."
	^ String fromJs: INLINE 'this.js.filePath'.
!
