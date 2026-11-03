CLASS Uri EXTENDS Object MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS global functions: encodeURI, decodeURI,
	 encodeURIComponent and decodeURIComponent.
	 It works in browsers and in Node.js. For parsing URLs, see class: Url."

CLASSMETHODS

"Encoding"

encode: string
	"Escape string for use as a complete URL.
	 Keeps characters that structure a URL, like: / ? : @ & = + $ #
	 Throws a JS URIError if string contains a lone surrogate."
	^ String fromJs: INLINE 'encodeURI( string.js )'.
!
decode: string
	"Reverse encode:. Keeps escapes of the characters kept by encode:, like: %2F
	 Throws a JS URIError if string contains a malformed escape, like: '%E0%A4%A'."
	^ String fromJs: INLINE 'decodeURI( string.js )'.
!
encodeComponent: string
	"Escape string for use as a part of a URL, like a query parameter value.
	 Escapes all characters except: A-Z a-z 0-9 - _ . ! ~ * ' ( )
	 Throws a JS URIError if string contains a lone surrogate."
	^ String fromJs: INLINE 'encodeURIComponent( string.js )'.
!
decodeComponent: string
	"Reverse encodeComponent:.
	 Throws a JS URIError if string contains a malformed escape, like: '%E0%A4%A'."
	^ String fromJs: INLINE 'decodeURIComponent( string.js )'.
!
