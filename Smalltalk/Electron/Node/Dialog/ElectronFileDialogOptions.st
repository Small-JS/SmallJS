CLASS ElectronFileDialogOptions EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS interfaces: OpenDialogOptions and SaveDialogOptions.
 Note: Platform specific funcionality is not implemented, keeping it standard."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

title
	^ String fromJs: INLINE 'this.js.title'.
!
title: title
	INLINE 'this.js.title = title.js'.
!
defaultPath
	^ String fromJs: INLINE 'this.js.defaultPath'.
!
defaultPath: defaultPath
	"Directory or file path that is shown initially."
	INLINE 'this.js.defaultPath = defaultPath.js'.
!
buttonLabel
	^ String fromJs: INLINE 'this.js.buttonLabel'.
!
buttonLabel: buttonLabel
	"Custom label for the confirmation button."
	INLINE 'this.js.buttonLabel = buttonLabel.js'.
!
filters
	^ Array fromJs: INLINE 'this.js.filters' elementClass: ElectronFileFilter.
!
filters: filters
	"Array of ElectronFileFilter."
	INLINE 'this.js.filters = filters.$toJs()'.
!
addFilter: filter
	"Adds an ElectronFileFilter. Can be called multiple times for multiple filters."
	INLINE '( this.js.filters ??= [] ).push( filter.js )'.
!
properties
	^ Array fromJsStrings: INLINE 'this.js.properties'.
!
properties: properties
	"Array of strings.
	 Open dialog: 'openFile', 'openDirectory', 'multiSelections', 'showHiddenFiles', 'createDirectory',
	 'promptToCreate', 'dontAddToRecent'.
	 Save dialog: 'showHiddenFiles', 'createDirectory', 'showOverwriteConfirmation', 'dontAddToRecent'."
	INLINE 'this.js.properties = properties.$toJs()'.
!
