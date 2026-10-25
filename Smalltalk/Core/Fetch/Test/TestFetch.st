CLASS TestFetch EXTENDS Test MODULE Core CLASSVARS '' VARS ''

async test
	"The test API: https://jsonplaceholder.typicode.com/posts/1
	Gives response body: (will have double quotes for the strings):
	{ 'userId' : 1, 'id': 1, 'title': 'sunt aut facere ...', 'body': 'quia et suscipit ...' }"

	| url response text object |
	url := 'https://jsonplaceholder.typicode.com/posts/1'.

	response := await Fetch request: url.
	self assert: [ response ok ].

	text := await Fetch text: url.
	self assert: [ text includes: 'title' ].

	object := await Fetch object: url.
	self assert: [ ( object atProperty: 'id' ) = 1 ].
!
async testCreated
	"Creating a post at the test API returns status 201 (Created), which is also successful."
	| url options object |
	url := 'https://jsonplaceholder.typicode.com/posts'.
	options := RequestInit new
		method: 'POST';
		body: '{ "title": "test" }';
		headers: ( Headers new set: 'content-type' value: 'application/json' ).

	object := await Fetch object: url options: options.
	self assert: [ ( object atProperty: 'title' ) = 'test' ].
!
