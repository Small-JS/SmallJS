CLASS ElectronMenuItem EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Note: This is a partial implementation of the Electron JS class."

INLINE 'import { MenuItem } from "electron";'

CLASSMETHODS

new: options
	^ self fromJs: INLINE 'new MenuItem( options.js )'.
!

