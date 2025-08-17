CLASS NwManifest EXTENDS JsObject MODULE Nwjs CLASSVARS '' VARS ''

"Manifest does not have a class or interface in NW.js.
 It is simple the contents of NW package.json presented as a JS object."

name
	^ String fromJs: INLINE 'this.js.name'.
!
main
	^ String fromJs: INLINE 'this.js.main'.
!
