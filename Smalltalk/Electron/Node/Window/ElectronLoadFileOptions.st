CLASS ElectronLoadFileOptions EXTENDS JsObject MODULE ElectronMain CLASSVARS '' VARS ''

"Implements Electron JS interface: LoadFileOptions.
 The properties are passed to Node url.format() to build the file URL.
 Note: If search is set, the query parameters are ignored."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

queryAt: key
	"Returns nil if the query parameter is not set."
	^ String fromJs: INLINE 'this.js.query?.[ key.js ]'.
!
queryKey: key value: value
	"Adds a query parameter. Can be called multiple times for multiple parameters."
	INLINE '( this.js.query ??= {} )[ key.js ] = value.js'.
!
search
	^ String fromJs: INLINE 'this.js.search'.
!
search: search
	"The complete query string, e.g. '?a=1&b=2'."
	INLINE 'this.js.search = search.js'.
!
hash
	^ String fromJs: INLINE 'this.js.hash'.
!
hash: hash
	"The fragment, e.g. '#section'."
	INLINE 'this.js.hash = hash.js'.
!
