CLASS FileGlobOptions EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

cwd
	^ String fromJs: INLINE 'this.js.cwd'.
!
cwd: cwd
	INLINE 'this.js.cwd = cwd.js'.
!
withFileTypes
	^ String fromJs: INLINE 'this.js.withFileTypes'.
!
withFileTypes: withFileTypes
	INLINE 'this.js.withFileTypes = withFileTypes.js'.
!
exclude: block
	INLINE 'this.js.exclude = ( path ) =>
		block.$value$( stString$class.$fromJs$( path ) ).js'.
!
