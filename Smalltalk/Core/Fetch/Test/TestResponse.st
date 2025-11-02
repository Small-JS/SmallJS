CLASS TestResponse EXTENDS Test MODULE Core CLASSVARS '' VARS ''

async test
	| url response headers text bytes arrayBuffer blob object |

	"The test API: https://jsonplaceholder.typicode.com/posts/1
	Gives response body: (will have double quotes for the strings):
	{ 'userId' : 1, 'id': 1, 'title': 'sunt aut facere ...', 'body': 'quia et suscipit ...' }"
	url := 'https://jsonplaceholder.typicode.com/posts/1'.
	response := await Fetch request: url.
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
	self assert: [ response url = url ].

	text := await response clone text.
	self assert: [ text includes: 'title' ].

	bytes := await response clone bytes.
	self assert: [ ( bytes at: 0 ) = 123 ].
	self assert: [ ( bytes at: 1 ) = 10 ].

	arrayBuffer := await response clone arrayBuffer.
	self assert: [ arrayBuffer byteLength = 292 ].

	blob := await response clone blob.
	self assert: [ blob size = 292 ].

	object := await response clone json.
	self assert: [ ( object atProperty: 'id' ) = 1 ].

	"formDataThen: is not tested here,
	 because the is no suitable API present in API test site typicode.com."
!
