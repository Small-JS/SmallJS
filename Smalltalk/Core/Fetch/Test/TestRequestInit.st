CLASS TestRequestInit EXTENDS Test MODULE Core CLASSVARS '' VARS ''

test
	| requestInit |

	requestInit := RequestInit new.
	self assert: [ requestInit isEmpty ].
	self assert: [ requestInit body isNil ].

	requestInit method: 'POST'.
	self assert: [ requestInit method = 'POST' ].

	requestInit headers: Headers new.
	self assert: [ requestInit headers class = Headers ].

	requestInit body: ( ArrayBuffer new: 8 ).
	self assert: [ requestInit body byteLength = 8 ].

	requestInit body: '{ "a": 1 }'.
	self assert: [ requestInit body = '{ "a": 1 }' ].

	requestInit body: ( Blob fromArray: #( 'abc' ) ).
	self assert: [ requestInit body class = Blob ].
	self assert: [ requestInit body size = 3 ].

	requestInit body: FormData new.
	self assertError: [ requestInit body ].

	requestInit mode: 'cors'.
	self assert: [ requestInit mode = 'cors' ].

	requestInit credentials: 'same-origin'.
	self assert: [ requestInit credentials = 'same-origin' ].

	requestInit cache: 'reload'.
	self assert: [ requestInit cache = 'reload' ].

	requestInit redirect: 'follow'.
	self assert: [ requestInit redirect = 'follow' ].

	requestInit referrer: ''.
	self assert: [ requestInit referrer = '' ].

	requestInit referrerPolicy: 'no-referrer'.
	self assert: [ requestInit referrerPolicy = 'no-referrer' ].

	requestInit integrity: 'sha256-BpfBw7ivV8q2jLiT13fxDYAe2tJllusRSZ273h2nFSE='.
	self assert: [ requestInit integrity = 'sha256-BpfBw7ivV8q2jLiT13fxDYAe2tJllusRSZ273h2nFSE=' ].

	requestInit keepalive: false.
	self assert: [ requestInit keepalive not ].

	requestInit signal: AbortController new signal.
	self assert: [ requestInit signal class = AbortSignal ].

	requestInit priority: 'high'.
	self assert: [ requestInit priority = 'high' ].
!
