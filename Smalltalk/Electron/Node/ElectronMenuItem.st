CLASS ElectronMenuItem EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Note: This is a partial implementation of the Electron JS class."

CLASSMETHODS

new: options
	^ self fromJs: INLINE 'new electron$.MenuItem( options.js )'.
!

