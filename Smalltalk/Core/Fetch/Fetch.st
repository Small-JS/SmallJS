CLASS Fetch EXTENDS Object MODULE Core CLASSVARS '' VARS ''

"Implements JS fetch() API plus some conversions."

CLASSMETHODS

"Fetch Response"

async request: url
	^ Response fromJs: INLINE 'await fetch( url.js )'.
!
async request: url options: options
	^ Response fromJs: INLINE 'await fetch( url.js, options.js )'.
!

"Fetch text string"

async text: url
	^ await self text: url options: nil.
!
async text: url options: options
	"Returns the fetched file content as a text string."
	| response |
	response := await self request: url options: options.
	response status = 200
		ifFalse: [ Error throw: response statusAndText ].

	^ await response text.
!

"Fetch Object"

async object: url
	^ await self object: url options: nil
!
async object: url options: options
	"Returns a ST object constructed from the the fetched JSON response."
	| response |
	response := await self request: url options: options.
	response status = 200
		ifFalse: [ Error throw: response statusAndText ].

	^ await response json.
!
