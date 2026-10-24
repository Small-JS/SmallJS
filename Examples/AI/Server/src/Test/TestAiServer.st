CLASS TestAiServer EXTENDS Object MODULE TestAiServer CLASSVARS ''
	VARS 'aiServer'

"AiServer unit and API tests.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	aiServer := AiServer new start.

	"Run sync and async unit tests of all imported Test* classes and log results."
	TestAiFactory.
	TestAiProviders.
	await Test all.
	await self testApi.
!
async testApi
	self log: 'TestAiServer: Starting API tests.'.

	"Tests execution is chained to facilite debugging."
	await self testProviders.
	await self testChat.
	await self stopServer.
!
async testProviders
	| url object providers provider ai models |

	url := 'http://localhost:', aiServer port toString, '/api/providers'.
	object := await Fetch object: url.
	providers := AiProviders fromObject: object.
	self assert: [ providers size > 0 ].

	provider := providers map keys first.
	ai := aiServer aiMap get: provider.
	self assert: [ ai notNil ].

	models := providers modelsFor: provider.
	self assert: [ models = ai class models ].
!
async testChat
	"Send a chat request to every AI in parallel and wait for all responses.
	 A failed assertion in any request fails this test, after all requests have settled."
	| promises statuses failures |
	promises := aiServer aiMap values map: [ :ai |
		Promise fromJs: ( self chatRequest: ai ) ].
	statuses := Array
		fromJs: ( await ( Promise allSettled: promises then: [ :results | ] ) js )
		elementClass: PromiseStatus.
	failures := statuses filter: [ :status | status status = 'rejected' ].
	failures do: [ :status |
		self log: 'TestAiServer: Chat request failed: ', ( Error fromJs: status reason ) message ].
	self assert: [ failures isEmpty ].

	await self testChatErrors.
!
async chatRequest: ai
	| chatRequest chatResponse |

	chatRequest := AiChatRequest new
		provider: ai name;
		model: ai class models first;
		messages: #( 'Say exactly: This is a test' ).
	chatResponse := await self fetchChat: chatRequest toUrlQuery.
	self log: 'TestAiServer: Chat response received from: ', ai name.

	self assert: [ chatResponse success ].
	self assert: [ chatResponse text toLowerCase includes: 'test' ].
!
async testChatErrors
	"Invalid requests are answered with an unsuccessful response, without calling an AI."
	| provider model chatResponse |

	provider := aiServer aiMap keys first.
	model := ( aiServer aiMap get: provider ) class models first.

	chatResponse := await self fetchChat: '?provider=', provider, '&model=', model.
	self assert: [ chatResponse success not ].
	self assert: [ chatResponse text includes: '"messages" missing' ].

	chatResponse := await self fetchChat: '?provider=', provider, '&model=', model, '&messages=%5B'.
	self assert: [ chatResponse success not ].
	self assert: [ chatResponse text includes: 'not valid JSON' ].

	chatResponse := await self fetchChat: '?provider=', provider, '&model=', model, '&messages=5'.
	self assert: [ chatResponse success not ].
	self assert: [ chatResponse text includes: 'not an array' ].

	chatResponse := await self fetchChat: '?provider=nonexistent&model=', model, '&messages=%5B%5D'.
	self assert: [ chatResponse success not ].
	self assert: [ chatResponse text includes: 'provider not available' ].

	chatResponse := await self fetchChat: '?provider=', provider, '&model=nonexistent&messages=%5B%5D'.
	self assert: [ chatResponse success not ].
	self assert: [ chatResponse text includes: 'model not available' ].
!
async fetchChat: urlQuery
	| url object |
	url := 'http://localhost:', aiServer port toString, '/api/chat', urlQuery.
	object := await Fetch object: url.
	^ AiChatResponse fromObject: object.
!
async stopServer
	self log: 'TestAiServer: API tests successful.'.
	self log: 'TestAiServer: Stopping server.'.

	await Timer timeout: 1000.
	aiServer stop.
!
