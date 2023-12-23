CLASS Fetch EXTENDS Object MODULE DOM CLASSVARS '' VARS ''
	"Implements JS fetch() API for browsers.
	 Note: Node has a seprate fetch() implementation in the class: Http."

CLASSMETHODS

"JSON"

file: url then: block catch: errorBlock
	"Calls the block with the fetched file content as a string."
	INLINE '
		fetch( url.js )
			.then( response => response.text() )
			.then( string => block.$value$( stString$class.$fromJs$( string ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!

object: url then: block catch: errorBlock
	"Calls the block with a ST object constructed from the the fetched JSON response."
	INLINE '
		fetch( url.js )
			.then( response => response.json() )
			.then( js => block.$value$( stObject$class.$fromJs$( js ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
