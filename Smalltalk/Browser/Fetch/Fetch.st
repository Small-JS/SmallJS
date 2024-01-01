CLASS Fetch EXTENDS Object MODULE DOM CLASSVARS '' VARS ''
	"Implements JS fetch() API for browsers.
	 Note: Node has a seprate fetch() implementation in the class: Http."

CLASSMETHODS

file: url then: block catch: errorBlock
	"Calls the block with the fetched file content as a string."
	self request: ( Request url: url )
		then: [ :response | self onFile: response then: block catch: errorBlock ]
		catch: errorBlock.
!
onFile: response then: block catch: errorBlock
	response status = 200
		ifTrue: [ response textThen: [ :string | block value: string  ] ]
		ifFalse: [ errorBlock value: ( Error new: response statusAndText ) ].
!
object: url then: block catch: errorBlock
	"Calls the block with a ST object constructed from the the fetched JSON response."
	self request: ( Request url: url )
		then: [ :response | self onObject: response then: block catch: errorBlock ]
		catch: errorBlock.
!
onObject: response then: block catch: errorBlock
	response status = 200
		ifTrue: [ response jsonThen: [ :object | block value: object  ] ]
		ifFalse: [ errorBlock value: ( Error new: response statusAndText ) ].
!
request: request then: block catch: errorBlock
	"Calls the block with the fetched file content as a string."
	INLINE '
		fetch( request.js )
			.then( response => block.$value$( stResponse$class.$fromJs$( response ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
