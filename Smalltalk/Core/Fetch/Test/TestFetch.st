CLASS TestFetch EXTENDS Test MODULE Core CLASSVARS '' VARS ''

"Fetch request"

testRequest
	Fetch request: 'https://jsonplaceholder.typicode.com/posts/1'
		then: [ :response | self onRequest: response ]
		catch: [ :error | self onError: error ].
!
onRequest: response
	"Example response body (will have double quotes for the strings):
	{ 'userId' : 1, 'id': 1, 'title': 'sunt aut facere ...', 'body': 'quia et suscipit ...' }"

	self assert: [ response ok ].
!

"Fetch text"

testText
	Fetch text: 'https://jsonplaceholder.typicode.com/posts/1'
		then: [ :response | self onText: response ]
		catch: [ :error | self onError: error ].
!
onText: text
	"Example response body (will have double quotes for the strings):
	{ 'userId' : 1, 'id': 1, 'title': 'sunt aut facere ...', 'body': 'quia et suscipit ...' }"

	self assert: [ text includes: 'title' ].
!

"Fetch object"

testObject
	Fetch object: 'https://jsonplaceholder.typicode.com/posts/1'
		then: [ :response | self onObject: response ]
		catch: [ :error | self onError: error ].
!
onObject: object
	"Example response body (will have double quotes for the strings):
	{ 'userId' : 1, 'id': 1, 'title': 'sunt aut facere ...', 'body': 'quia et suscipit ...' }"

	self assert: [ ( object atProperty: 'id' ) = 1 ].
!
onError: error
	error throw.
!
