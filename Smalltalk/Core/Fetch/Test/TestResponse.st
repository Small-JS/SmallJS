CLASS TestResponse EXTENDS Test MODULE Core CLASSVARS '' VARS ''

test
	Fetch request: 'https://jsonplaceholder.typicode.com/posts/1'
		then: [ :response | self onRequest: response ]
		catch: [ :error | error throw ].
!
onRequest: response
	"Example response body (will have double quotes for the strings):
	{ 'userId' : 1, 'id': 1, 'title': 'sunt aut facere ...', 'body': 'quia et suscipit ...' }"

	| headers bytes |

	self assert: [ response body class = ReadableStream ].
	self assert: [ response bodyUsed not ].

	headers := response headers.
	self assert: [ headers class = Headers ].
	self assert: [ ( headers get: 'content-type' ) includes: 'application' ].

	self assert: [ response ok ].
	self assert: [ response status = 200 ].
	"Browsers give default status empty string iso 'OK'"
	self assert: [ #( 'OK' '' ) includes: response statusText ].
	self assert: [ response statusAndText includes: '200' ].

	self assert: [ response redirected not ].
	"Browsers give deault type 'cors' iso 'basic'"
	self assert: [ #( 'basic' 'cors' ) includes: response type ].
	self assert: [ response url = 'https://jsonplaceholder.typicode.com/posts/1'  ].

	response clone textThen: [ :text | self onResponseText: text ].
	response clone bytesThen: [ :bytes | self onResponseBytes: bytes ].
	response clone arrayBufferThen: [ :arrayBuffer | self onArrayBuffer: arrayBuffer ].
	response clone blobThen: [ :blob | self onBlob: blob ].
	response clone jsonThen: [ :object | self onJson: object ].
	"formDataThen: is not tested, no suitable API present."
!
onResponseText: text
	self assert: [ text includes: 'title' ].
!
onResponseBytes: bytes
	self assert: [ ( bytes at: 0 ) = 123 ].
	self assert: [ ( bytes at: 1 ) = 10 ].
!
onArrayBuffer: arrayBuffer
	self assert: [ arrayBuffer byteLength = 292 ].
!
onBlob: blob
	self assert: [ blob size = 292 ].
!
onJson: object
	self assert: [ ( object atProperty: 'id' ) = 1 ].
!
