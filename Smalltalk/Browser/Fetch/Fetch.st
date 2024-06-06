CLASS Fetch EXTENDS Object MODULE Browser CLASSVARS '' VARS ''
	"Implements JS fetch() API for browsers."

CLASSMETHODS

request: url then: block catch: errorBlock
	self request: url options: RequestOptions new then: block catch: errorBlock
!
request: url options: options then: block catch: errorBlock
	"Calls the block with the fetched Response object."
	Response.  "Force import"
	INLINE '
		fetch( url.js, options.js )
			.then( response => block.$value$( stResponse$class.$fromJs$( response ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) )'.
!
object: url then: block catch: errorBlock
	self object: url options: RequestOptions new then: block catch: errorBlock
!
object: url options: options then: block catch: errorBlock
	"Calls the block with a ST object constructed from the the fetched JSON response."
	self request: url
		options: options
		then: [ :response | self onObject: response then: block catch: errorBlock ]
		catch: errorBlock.
!
onObject: response then: block catch: errorBlock
	response status = 200
		ifTrue: [ response jsonThen: [ :object | block value: object  ] ]
		ifFalse: [ errorBlock value: ( Error new: response statusAndText ) ].
!
text: url then: block catch: errorBlock
	self text: url options: RequestOptions new then: block catch: errorBlock
!
text: url options: options then: block catch: errorBlock
	"Calls the block with the fetched file content as a text string."
	self request: url
		options: options
		then: [ :response | self onFile: response then: block catch: errorBlock ]
		catch: errorBlock.
!
onFile: response then: block catch: errorBlock
	response status = 200
		ifTrue: [ response textThen: [ :string | block value: string  ] ]
		ifFalse: [ errorBlock value: ( Error new: response statusAndText ) ].
!
