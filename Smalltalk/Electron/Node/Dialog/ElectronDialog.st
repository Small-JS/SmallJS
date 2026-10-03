CLASS ElectronDialog EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS object: dialog.
 Note: Platform specific funcionality is not implemented, keeping it standard.
 Note: Dialogs, except the error box, can only be shown after the app is ready.
 The *Sync methods block the main process until the dialog is closed.
 The window argument is an ElectronBaseWindow (or subclass) that the dialog is modal to."

CLASSMETHODS

new
	^ self fromJs: INLINE 'electron$.dialog'.
!

METHODS

"Open dialog"

showOpenDialogSync: options
	"Returns an Array of selected paths, or nil if canceled."
	^ Array fromJsStrings: INLINE 'this.js.showOpenDialogSync( options.js )'.
!
showOpenDialogSync: options window: window
	"Returns an Array of selected paths, or nil if canceled."
	^ Array fromJsStrings: INLINE 'this.js.showOpenDialogSync( window.js, options.js )'.
!
async showOpenDialog: options
	^ ElectronOpenDialogResult fromJs: INLINE 'await this.js.showOpenDialog( options.js )'.
!
async showOpenDialog: options window: window
	^ ElectronOpenDialogResult fromJs: INLINE 'await this.js.showOpenDialog( window.js, options.js )'.
!

"Save dialog"

showSaveDialogSync: options
	"Returns the selected path, or an empty string if canceled."
	^ String fromJs: INLINE 'this.js.showSaveDialogSync( options.js )'.
!
showSaveDialogSync: options window: window
	"Returns the selected path, or an empty string if canceled."
	^ String fromJs: INLINE 'this.js.showSaveDialogSync( window.js, options.js )'.
!
async showSaveDialog: options
	^ ElectronSaveDialogResult fromJs: INLINE 'await this.js.showSaveDialog( options.js )'.
!
async showSaveDialog: options window: window
	^ ElectronSaveDialogResult fromJs: INLINE 'await this.js.showSaveDialog( window.js, options.js )'.
!

"Message box"

showMessageBoxSync: options
	"Returns the index of the clicked button.
	 Note: The signal option is not supported by the sync version."
	^ Integer fromJs: INLINE 'this.js.showMessageBoxSync( options.js )'.
!
showMessageBoxSync: options window: window
	"Returns the index of the clicked button.
	 Note: The signal option is not supported by the sync version."
	^ Integer fromJs: INLINE 'this.js.showMessageBoxSync( window.js, options.js )'.
!
async showMessageBox: options
	^ ElectronMessageBoxResult fromJs: INLINE 'await this.js.showMessageBox( options.js )'.
!
async showMessageBox: options window: window
	^ ElectronMessageBoxResult fromJs: INLINE 'await this.js.showMessageBox( window.js, options.js )'.
!

"Error box"

showErrorBox: title content: content
	"Shows a modal error box. Can also be called before the app is ready.
	 Note: On Linux, before the app is ready, the message is printed to stderr instead."
	INLINE 'this.js.showErrorBox( title.js, content.js )'.
!
