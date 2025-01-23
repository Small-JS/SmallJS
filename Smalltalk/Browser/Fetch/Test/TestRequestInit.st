CLASS TestRequestInit EXTENDS Test MODULE Core CLASSVARS '' VARS ''

"The RequestInit class in Node is similar to that of the browsers,
 but not equal and have some different behaviors.
 So there are different tests."

test
	| options request |

	options := RequestInit new.
	self assert: [ options isEmpty ].

	options method: 'POST'.
	self assert: [ options method = 'POST' ].

	options headers: Headers new.
	self assert: [ options headers class = Headers ].

	options body: ( ArrayBuffer new: 8 ).
	self assert: [ options body byteLength = 8 ].

	options mode: 'cors'.
	self assert: [ options mode = 'cors' ].

	options credentials: 'same-origin'.
	self assert: [ options credentials = 'same-origin' ].

	options cache: 'reload'.
	self assert: [ options cache = 'reload' ].

	options redirect: 'follow'.
	self assert: [ options redirect = 'follow' ].

	options referrer: 'no-referrer'.
	self assert: [ options referrer = 'no-referrer' ].

	options referrerPolicy: 'no-referrer'.
	self assert: [ options referrerPolicy = 'no-referrer' ].

	options integrity: 'sha256-BpfBw7ivV8q2jLiT13fxDYAe2tJllusRSZ273h2nFSE='.
	self assert: [ options integrity = 'sha256-BpfBw7ivV8q2jLiT13fxDYAe2tJllusRSZ273h2nFSE=' ].

	options keepalive: false.
	self assert: [ options keepalive not ].

	options signal: AbortController new signal.
	self assert: [ options signal class = AbortSignal ].

	options priority: 'high'.
	self assert: [ options priority = 'high' ].

	"options := RequestInit new."
	request := Request url: 'http://localhost/Missing.json' options: options.
	self assert: [ request url includes: 'Missing.json' ].

	self assert: [ request bodyUsed not ].
	self assert: [ request cache = options cache ].
	self assert: [ request credentials = options credentials ].
	self assert: [ request destination = '' ].
	self assert: [ request headers keys length = options headers keys length ].
	self assert: [ request method = options method ].
	self assert: [ request mode = options mode ].
	self assert: [ request redirect = options redirect ].
	self assert: [ request referrer includes: options referrer ].
	self assert: [ request referrerPolicy = options referrerPolicy ].
	self assert: [ request signal class = AbortSignal ].
!
