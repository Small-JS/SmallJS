CLASS ElectronMessageBoxOptions EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS interfaces: MessageBoxOptions and MessageBoxSyncOptions.
 Note: Platform specific funcionality is not implemented, keeping it standard."

CLASSMETHODS

new
	^ self newEmpty.
!
message: message
	^ self new message: message; yourself.
!

METHODS

message
	^ String fromJs: INLINE 'this.js.message'.
!
message: message
	"Required. The content of the message box."
	INLINE 'this.js.message = message.js'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	"One of: 'none', 'info', 'error', 'question', 'warning'."
	INLINE 'this.js.type = type.js'.
!
buttons
	^ Array fromJsStrings: INLINE 'this.js.buttons'.
!
buttons: buttons
	"Array of button labels. If empty, one 'OK' button is shown."
	INLINE 'this.js.buttons = buttons.$toJs()'.
!
defaultId
	^ Integer fromJs: INLINE 'this.js.defaultId'.
!
defaultId: defaultId
	"Index of the button that is selected by default."
	INLINE 'this.js.defaultId = defaultId.js'.
!
cancelId
	^ Integer fromJs: INLINE 'this.js.cancelId'.
!
cancelId: cancelId
	"Index of the button that is returned when the dialog is canceled, e.g. with the Esc key."
	INLINE 'this.js.cancelId = cancelId.js'.
!
signal
	^ AbortSignal fromJs: INLINE 'this.js.signal'.
!
signal: signal
	"AbortSignal that closes the message box, as if it was canceled by the user.
	 Note: Only supported by ElectronDialog>>showMessageBox:, not by the sync version."
	INLINE 'this.js.signal = signal.js'.
!
title
	^ String fromJs: INLINE 'this.js.title'.
!
title: title
	INLINE 'this.js.title = title.js'.
!
detail
	^ String fromJs: INLINE 'this.js.detail'.
!
detail: detail
	"Extra information that is shown below the message."
	INLINE 'this.js.detail = detail.js'.
!
checkboxLabel
	^ String fromJs: INLINE 'this.js.checkboxLabel'.
!
checkboxLabel: checkboxLabel
	"If set, a checkbox with this label is shown."
	INLINE 'this.js.checkboxLabel = checkboxLabel.js'.
!
checkboxChecked
	^ Boolean fromJs: INLINE 'this.js.checkboxChecked'.
!
checkboxChecked: checkboxChecked
	"Initial checked state of the checkbox."
	INLINE 'this.js.checkboxChecked = checkboxChecked.js'.
!
icon
	"Note: Only returns the icon if it was set as a file path string."
	^ String fromJs: INLINE '( typeof this.js.icon === "string" ? this.js.icon : null )'.
!
icon: path
	INLINE 'this.js.icon = path.js'.
!
normalizeAccessKeys
	^ Boolean fromJs: INLINE 'this.js.normalizeAccessKeys'.
!
normalizeAccessKeys: normalizeAccessKeys
	"If true, '&' in button labels marks keyboard access keys on all platforms."
	INLINE 'this.js.normalizeAccessKeys = normalizeAccessKeys.js'.
!
