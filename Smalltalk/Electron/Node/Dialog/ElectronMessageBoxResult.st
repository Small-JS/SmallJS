CLASS ElectronMessageBoxResult EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS interface: MessageBoxReturnValue."

METHODS

response
	"Index of the clicked button, or the cancelId if canceled."
	^ Integer fromJs: INLINE 'this.js.response'.
!
checkboxChecked
	^ Boolean fromJs: INLINE 'this.js.checkboxChecked'.
!
