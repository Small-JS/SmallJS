CLASS ElectronFileFilter EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS interface: FileFilter.
 Extensions are without dots or wildcards, e.g. 'png'. Use '*' for all files."

CLASSMETHODS

new
	^ self newEmpty.
!
name: name extensions: extensions
	^ self new name: name; extensions: extensions; yourself.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!
extensions
	^ Array fromJsStrings: INLINE 'this.js.extensions'.
!
extensions: extensions
	"Array of extension strings."
	INLINE 'this.js.extensions = extensions.$toJs()'.
!
