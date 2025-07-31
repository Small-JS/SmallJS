CLASS TestRequest EXTENDS Test MODULE Core CLASSVARS '' VARS ''

testDefaults
	| request |
	self assertError: [ Request new ].
	request := Request url: 'http://unknown.com'.

	self assert: [ request bodyUsed not ].
	self assert: [ request cache = 'default' ].
	self assert: [ request credentials = 'same-origin' ].
	self assert: [ request destination = '' ].
	self assert: [ request headers keys length = 0 ].
	self assert: [ request integrity = '' ].
	self assert: [ request keepalive not ].
	self assert: [ request method = 'GET' ].
	self assert: [ request mode = 'cors' ].
	self assert: [ request redirect = 'follow' ].
	self assert: [ request referrer = 'about:client' ].
	self assert: [ request referrerPolicy = '' ].
	self assert: [ request signal aborted not ].
	self assert: [ request url includes: 'unknown.com' ].
!
testInitialized
	| requestInit request |

	requestInit := RequestInit new
		body: 'request body';
		cache: 'reload';
		credentials: 'omit';
		headers: ( Headers new append: 'x-custom-header' value: 'custom value' );
		integrity: 'sha256-abc123';
		keepalive: true;
		method: 'POST';
		mode: 'same-origin';
		redirect: 'manual';
		referrer: 'http://referrer.com';
		referrerPolicy: 'origin';
		signal: ( AbortController new signal ).

	request := Request url: 'http://unknown.com' options: requestInit.

	self assert: [ request bodyUsed not ].
	self assert: [ request cache = 'reload' ].
	self assert: [ request credentials = 'omit' ].
	self assert: [ request destination = '' ].
	self assert: [ ( request headers get: 'x-custom-header' ) = 'custom value' ].
	self assert: [ request integrity = 'sha256-abc123' ].
	self assert: [ request keepalive ].
	self assert: [ request method = 'POST' ].
	self assert: [ request mode = 'same-origin' ].
	self assert: [ request redirect = 'manual' ].
	"Note: Browsers do not copy the referrer set in requestInit."
	self assert: [ #( 'http://referrer.com/' 'about:client' ) includes: request referrer ].
	self assert: [ request referrerPolicy = 'origin' ].
	self assert: [ request signal aborted not ].
	self assert: [ request url includes: 'unknown.com' ].
!
testMethods
	| url requestInit request |

	url := 'http://unknown.com'.
	requestInit := RequestInit new
		method: 'POST';
		body: 'request body';
		integrity: 'sha256-abc123'.

	request := Request url: url options: requestInit.
	self assert: [ request clone integrity = request integrity ].

	"Note: 2025-07-29:
	 The method Request.clone in Node.js does *not* create re-readable requests (error: unusable),
	 so a new request is made for every buffer reading."

	request := Request url: url options: requestInit.
	request arrayBufferThen: [ :arrayBuffer | self onArrayBuffer: arrayBuffer ].

	request := Request url: url options: requestInit.
	request blobThen: [ :blob | self onBlob: blob ].

	request := Request url: url options: requestInit.
	request bytesThen: [ :bytes | self onBytes: bytes ].

	request := Request url: url options: requestInit.
	request textThen: [ :text | self onText: text ].

	requestInit body: '{ "a": 1 }'.
	request := Request url: url options: requestInit.
	request jsonThen: [ :object | self onJson: object ].

	requestInit body: ( FormData new append: 'b' value: 2 ).
	request := Request url: url options: requestInit.
	request formDataThen: [ :formData | self onFormData: formData ].
!
onArrayBuffer: arrayBuffer
	self assert: [ arrayBuffer byteLength = 12 ].
!
onBlob: blob
	self assert: [ blob size = 12 ].
!
onBytes: bytes
	self assert: [ bytes byteLength = 12 ].
!
onText: text
	self assert: [ text = 'request body' ].
!
onJson: object
	self assert: [ ( object atProperty: 'a' ) = 1 ].
!
onFormData: formData
	self assert: [ ( formData get: 'b' ) = 2 ].
!
