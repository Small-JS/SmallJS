CLASS ElectronLoadFileOptions EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

queryKey: key value: value
	INLINE 'this.js.query = { key: value }'.
!
search: search
	INLINE 'this.js.search = search.js'.
!
hash: hash
	INLINE 'this.js.hash = search.js'.
!

