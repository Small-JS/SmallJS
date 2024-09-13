CLASS NodeFetch EXTENDS JsObject MODULE Server CLASSVARS '' VARS ''

"2024.01.11, Node.js v21.5:
 The built-in version of fetch() of Nose.js is not used (yet) because of this issue:
 https://github.com/nodejs/undici/issues/2540
 This class is now based on npm package 'node-fetch' that does not have the issue.
 When the error is fixed, the separate NodeFetch will no longer be necessary
 and fetch functionaliteit merged to Core."

INLINE 'import fetch from "node-fetch";'

CLASSMETHODS

request: request then: block catch: errorBlock
	self request: request options: RequestOptions new then: block catch: errorBlock
!
request: request options: options then: block catch: errorBlock
	"Calls the block with the fetched file content as a string."
	Response.  "Force import"
	INLINE '
		fetch( request.js, options.js )
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
	"Calls the block with the fetched file content as a string."
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
