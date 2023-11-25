CLASS Http EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''

INLINE 'import http from "http";'

"21-NOV-2023: The built-in fetch() of Node.js (currently v21.2.0)
 will not sometimes work and cause errors.
 From Node.js these fetch* methods that are based on the npm package 'node-fetch'"
INLINE 'import fetch from "node-fetch";'

CLASSMETHODS

get: url
	INLINE 'http.get( url.js )'.
!
fetchObject: url then: block onError: errorBlock
	"Retuns a ST object from the the fetched JSON response."
	INLINE '
		fetch( url.js )
			.then( response => response.json() )
			.then( js => block.$value$( stObject$class.$fromJs$( js ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
