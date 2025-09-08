CLASS DirOptions EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

encoding
	^ String fromJs: INLINE 'this.js.encoding'.
!
encoding: encoding
	INLINE 'this.js.encoding = encoding.js'.
!
withFileTypes
	^ Boolean fromJs: INLINE 'this.js.withFileTypes'.
!
withFileTypes: withFileTypes
	INLINE 'this.js.withFileTypes = withFileTypes.js'.
!
recursive
	^ Boolean fromJs: INLINE 'this.js.recursive'.
!
recursive: recursive
	INLINE 'this.js.recursive = recursive.js'.
!

