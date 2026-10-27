CLASS TestExpress EXTENDS Test MODULE TestServer CLASSVARS '' VARS 'express server sessionCookie'

"Also tests class Server."

METHODS

test
	express := Express new.
	"CORS first, so its headers are also on error responses of later middleware,
	 and preflight requests do not create sessions."
	express useCors.
	express useSession.
	express useJson.
	express useUrlencoded.

	"Middleware"
	express use:
		[ :request :response :next | self onMiddleware: request response: response next: next ].
	express use: '/admin'
		then: [ :request :response :next | self onAdminMiddleware: request response: response next: next ].

	express get: '/login'
		then: [ :request :response | self onLoginRequest: request response: response ].
	express get: '/products'
		then: [ :request :response | self onProductsRequest: request response: response ].
	express post: '/order'
		then: [ :request :response | self onOrderRequest: request response: response ].
	express post: '/body'
		then: [ :request :response | self onBodyRequest: request response: response ].
	express post: '/form'
		then: [ :request :response | self onFormRequest: request response: response ].

	"Route methods and parameters"
	express put: '/products/:id'
		then: [ :request :response | self onProductRequest: request response: response ].
	express patch: '/products/:id'
		then: [ :request :response | self onProductRequest: request response: response ].
	express delete: '/products/:id'
		then: [ :request :response | self onProductRequest: request response: response ].
	express all: '/any'
		then: [ :request :response | response send: request method ].

	"Responses"
	express get: '/created'
		then: [ :request :response | self onCreatedRequest: request response: response ].
	express get: '/old'
		then: [ :request :response | response redirect: '/products' ].
	express get: '/moved'
		then: [ :request :response | response redirect: '/products' status: 301 ].

	"Errors, add handlers after all routes."
	express get: '/error'
		then: [ :request :response | Error throw: 'Sync error' ].
	express get: '/asyncError'
		then: [ :request :response | self onAsyncErrorRequest: request response: response ].
	express get: '/nextError'
		then: [ :request :response | response send: 'Not reached' ].
	express onNotFound: [ :request :response | self onNotFound: request response: response ].
	express onError: [ :error :request :response | self onError: error request: request response: response ].

	server := express listen: 3000
		then: [ :error | self onExpressListen: error ].
!
async onExpressListen: error
	error isNil ifFalse: [ error throw ].

	await self requestLogin.
	await self requestProducts.
	await self requestOrder.
	await self requestBody.
	await self requestForm.
	await self requestRoutes.
	await self requestMiddleware.
	await self requestResponses.
	await self requestErrors.
	await self requestCors.
	server terminate.
!

"=============================== Login"

async requestLogin
	| url response text |

	url := 'http://localhost:3000/login?name=John&password=secret'.
	response := await Fetch request: url.

	text := await response text.
	self assert: [ text = 'Login succeeded' ].

	sessionCookie := response cookie.
	self assert: [ sessionCookie includes: 'connect.sid' ].
!
onLoginRequest: request response: response
	| name password |

	name := request query atProperty: 'name'.
	self assert: [ name = 'John' ].

	password := request query atProperty: 'password'.
	self assert: [ password = 'secret' ].

	self assert: [ request method = 'GET' ].
	self assert: [ request url = '/login?name=John&password=secret' ].
	self assert: [ ( request headers get: 'host' ) = 'localhost:3000' ].
	self assert: [ request headers has: 'user-agent' ].

	self assert: [ ( request sessionId isKindOf: String ) and: [ request sessionId length > 0 ] ].
	request session set: 'loggedIn' to: true.
	response send: 'Login succeeded'.
!

"=============================== Products"

async requestProducts
	| headers options url text |

	headers := Headers new
		set: 'cookie' value: sessionCookie.
	options := RequestInit new
		headers: headers.

	url := 'http://localhost:3000/products'.
	text := await Fetch text: url options: options.
	self assert: [ text = 'Apple, Orange, Pear' ].
!
onProductsRequest: request response: response
	| loggedIn |
	loggedIn := ( request session get: 'loggedIn' ) = true.
	loggedIn
		ifFalse: [ response send: 'Not logged in' ]
		ifTrue: [ response send: 'Apple, Orange, Pear' ].
!

"=============================== Order"

async requestOrder
	| order headers options url object response |

	order := Object new
		atProperty: 'products' put: #( 'Apple' 'Pear' ).
	headers := Headers new
		set: 'content-type' value: 'application/json'.
	options := RequestInit new
		method: 'POST';
		headers: headers;
		body: order toJson.

	url := 'http://localhost:3000/order'.
	object := await Fetch object: url options: options.
	self assert: [ ( object atProperty: 'count' ) = 2 ].

	"Invalid JSON is answered with status 400."
	options body: '{ invalid'.
	response := await Fetch request: url options: options.
	self assert: [ response status = 400 ].
	self assert: [ ( response headers get: 'access-control-allow-origin' ) = '*' ].
!
onOrderRequest: request response: response
	| products result |
	self assert: [ request method = 'POST' ].
	products := request body atProperty: 'products'.
	self assert: [ products = #( 'Apple' 'Pear' ) ].

	result := Object new
		atProperty: 'count' put: products length.
	response send: result.
!

"=============================== Body"

async requestBody
	| text formData |
	"Plain text bodies are not parsed by useJson, so they can be read here."
	text := await self postBody: 'Hello' type: 'text'.
	self assert: [ text = 'Hello' ].
	text := await self postBody: '{ "count": 2 }' type: 'json'.
	self assert: [ text = '2' ].
	text := await self postBody: 'Hello' type: 'arrayBuffer'.
	self assert: [ text = '5' ].
	text := await self postBody: 'Hello' type: 'blob'.
	self assert: [ text = '5' ].

	formData := FormData new.
	formData append: 'name' value: 'John'.
	text := await self postBody: formData type: 'formData'.
	self assert: [ text = 'John' ].
!
async postBody: body type: type
	| options |
	options := RequestInit new
		method: 'POST';
		body: body.
	^ await Fetch text: 'http://localhost:3000/body?type=', type options: options.
!
onBodyRequest: request response: response
	| type |
	type := request query atProperty: 'type'.
	type = 'text' ifTrue: [
		request textThen: [ :text | response send: text ] ].
	type = 'json' ifTrue: [
		request jsonThen: [ :object | response send: ( object atProperty: 'count' ) toString ] ].
	type = 'arrayBuffer' ifTrue: [
		request arrayBufferThen: [ :buffer | response send: buffer byteLength toString ] ].
	type = 'blob' ifTrue: [
		request blobThen: [ :blob | response send: blob size toString ] ].
	type = 'formData' ifTrue: [
		request formDataThen: [ :formData | response send: ( formData get: 'name' ) ] ].
!

"=============================== Form"

async requestForm
	| headers options text |
	headers := Headers new
		set: 'content-type' value: 'application/x-www-form-urlencoded'.
	options := RequestInit new
		method: 'POST';
		headers: headers;
		body: 'name=John&city=New+York'.
	text := await Fetch text: 'http://localhost:3000/form' options: options.
	self assert: [ text = 'John, New York' ].
!
onFormRequest: request response: response
	| body |
	body := request body.
	response send: ( body atProperty: 'name' ), ', ', ( body atProperty: 'city' ).
!

"=============================== Routes"

async requestRoutes
	| options text |
	await self requestProduct: 'PUT'.
	await self requestProduct: 'PATCH'.
	await self requestProduct: 'DELETE'.

	text := await Fetch text: 'http://localhost:3000/any'.
	self assert: [ text = 'GET' ].
	options := RequestInit new
		method: 'POST'.
	text := await Fetch text: 'http://localhost:3000/any' options: options.
	self assert: [ text = 'POST' ].
!
async requestProduct: method
	| options object |
	options := RequestInit new
		method: method.
	object := await Fetch object: 'http://localhost:3000/products/42?x=1' options: options.
	self assert: [ ( object atProperty: 'method' ) = method ].
	self assert: [ ( object atProperty: 'id' ) = '42' ].
	self assert: [ ( object atProperty: 'path' ) = '/products/42' ].
!
onProductRequest: request response: response
	response json: ( Object new
		atProperty: 'method' put: request method;
		atProperty: 'id' put: ( request params atProperty: 'id' );
		atProperty: 'path' put: request path;
		yourself ).
!

"=============================== Middleware"

async requestMiddleware
	| response object |
	response := await Fetch request: 'http://localhost:3000/products'.
	self assert: [ ( response headers get: 'x-middleware' ) = 'yes' ].

	response := await Fetch request: 'http://localhost:3000/admin/users'.
	self assert: [ response status = 401 ].
	self assert: [ ( response headers get: 'x-middleware' ) = 'yes' ].
	object := await response json.
	self assert: [ ( object atProperty: 'message' ) = 'Unauthorized' ].
!
onMiddleware: request response: response next: next
	response setHeader: 'X-Middleware' value: 'yes'.
	request path = '/nextError'
		ifTrue: [ next value: ( Error new: 'Next error' ) ]
		ifFalse: [ next value ].
!
onAdminMiddleware: request response: response next: next
	"The path is relative to the mount path '/admin'."
	self assert: [ request path = '/users' ].
	response
		status: 401;
		json: ( Object new atProperty: 'message' put: 'Unauthorized' ).
!

"=============================== Responses"

async requestResponses
	| response text options |
	response := await Fetch request: 'http://localhost:3000/created'.
	self assert: [ response status = 201 ].
	self assert: [ ( response headers get: 'x-test' ) = 'yes' ].
	"json: also encodes a String as JSON."
	text := await response text.
	self assert: [ text = '"created"' ].

	options := RequestInit new
		redirect: 'manual'.
	response := await Fetch request: 'http://localhost:3000/old' options: options.
	self assert: [ response status = 302 ].
	self assert: [ ( response headers get: 'location' ) = '/products' ].
	response := await Fetch request: 'http://localhost:3000/moved' options: options.
	self assert: [ response status = 301 ].

	"Redirects are followed by default."
	response := await Fetch request: 'http://localhost:3000/old'.
	self assert: [ response redirected ].
	self assert: [ response url = 'http://localhost:3000/products' ].
!
onCreatedRequest: request response: response
	self assert: [ response status = 200 ].
	response
		status: 201;
		setHeader: 'X-Test' value: 'yes'.
	self assert: [ response status = 201 ].
	self assert: [ ( response getHeader: 'X-Test' ) = 'yes' ].
	self assert: [ response headersSent not ].
	response json: 'created'.
	self assert: [ response headersSent ].
!

"=============================== Errors"

async requestErrors
	await self requestError: '/error' status: 500 message: 'Sync error'.
	await self requestError: '/asyncError' status: 500 message: 'Async error'.
	await self requestError: '/nextError' status: 500 message: 'Next error'.
	await self requestError: '/missing' status: 404 message: 'Not found: /missing'.
!
async requestError: path status: status message: message
	| response object |
	response := await Fetch request: 'http://localhost:3000', path.
	self assert: [ response status = status ].
	object := await response json.
	self assert: [ ( object atProperty: 'message' ) = message ].
!
async onAsyncErrorRequest: request response: response
	await Promise resolve: nil.
	Error throw: 'Async error'.
!
onNotFound: request response: response
	response
		status: 404;
		json: ( Object new atProperty: 'message' put: 'Not found: ', request path ).
!
onError: error request: request response: response
	self assert: [ error isKindOf: Error ].
	response
		status: 500;
		json: ( Object new atProperty: 'message' put: error message ).
!

"=============================== CORS"

async requestCors
	| url response options |

	url := 'http://localhost:3000/products'.
	response := await Fetch request: url.
	self assert: [ ( response headers get: 'access-control-allow-origin' ) = '*' ].

	"Preflight request."
	options := RequestInit new
		method: 'OPTIONS';
		headers: ( Headers new set: 'access-control-request-headers' value: 'content-type' ).
	response := await Fetch request: url options: options.
	self assert: [ response status = 204 ].
	self assert: [ ( response headers get: 'access-control-allow-origin' ) = '*' ].
	self assert: [ ( response headers get: 'access-control-allow-headers' ) = 'content-type' ].
	self assert: [ ( response headers get: 'access-control-allow-methods' ) includes: 'POST' ].
!
