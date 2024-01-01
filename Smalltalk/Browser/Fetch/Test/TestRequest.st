CLASS TestRequest EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''
	"Also tests Response, Headers."

testRequest
	| request |

	request := Request url: 'Test/MyObject.json'.

	self assert: [ request class = Request ].
	self assert: [ request bodyUsed not ].
	self assert: [ request cache = 'default' ].
	self assert: [ request credentials = 'same-origin' ].
	self assert: [ request destination = '' ].
	self assert: [ request integrity = '' ].
	self assert: [ request method = 'GET' ].
	self assert: [ request mode = 'cors' ].
	self assert: [ request redirect = 'follow' ].
	self assert: [ request referrer = 'about:client' ].
	self assert: [ request referrerPolicy = '' ].
	self assert: [ request url includes: 'MyObject.json' ].

	Fetch request: request
		then: [ :response | self onResponse: response ]
		catch: [ :error | self error: error message ].
!
onResponse: response
	self assert: [ response bodyUsed not ].
	self assert: [ response ok ].
	self assert: [ response redirected not ].
	self assert: [ response status = 200 ].
	self assert: [ response statusText = 'OK' ].
	self assert: [ response type = 'basic' ].
	self assert: [ response url includes: 'MyObject.json' ].

	self onResponseHeaders: response headers.
!
onResponseHeaders: headers
	| entries keys values |

	self assert: [ ( headers get: 'accept-ranges' ) = 'bytes' ].

	entries := headers entries.
	keys := headers keys.
	values := headers values.

	self assert: [ entries length = keys length ].
	self assert: [ entries first length = 2 ].
	self assert: [ entries first first = keys first ].
	self assert: [ entries first last = values first ].
!
testHeaders
	| headers |

	headers := Headers new.

	headers append: 'Content-Type' value: 'text/html'.
	self assert: [ headers has: 'Content-Type' ].

	headers delete: 'Content-Type'.
	self assert: [ ( headers has: 'Content-Type' ) not ].
!
