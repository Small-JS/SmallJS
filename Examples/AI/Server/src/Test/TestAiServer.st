CLASS TestAiServer EXTENDS Object MODULE TestAiServer CLASSVARS '' VARS 'aiServer chatReponseCount'

"AiServer unit and API tests.
 This class is not a subclass of Test so is not called automatically with Test all."

async test: aAiServer
	aiServer := aAiServer.

	"Reference unit test class to include module"
	TestAiProviders.
	"Run sync and async unit tests of all imported Test* classes and log results."
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
	| aiCount |
	chatReponseCount := 0.
	aiServer aiMap values do: [ :ai |
		self chatRequest: ai ].

	await Timer timeout: 10000.
	aiCount := aiServer aiMap size.
	chatReponseCount = aiCount ifFalse: [
		self log: 'TestAiServer: Warning: Incorrect chat response count: ', chatReponseCount toString, ' expected: ', aiCount toString ].
!
async chatRequest: ai
	| id chatRequest url object chatResponse |

	id := ai nextId.
	chatRequest := AiChatRequest new
		provider: ai name;
		model: ai class models first;
		messages: #( 'Say exactly: This is a test' ).
	url := 'http://localhost:', aiServer port toString, '/api/chat', chatRequest toUrlQuery.
	object := await Fetch object: url.
	self log: 'TestAiServer: Resonse received with id: ', id.
	self assert: [ id endsWith: '-1' ].

	chatResponse := AiChatResponse fromObject: object.
	self assert: [ chatResponse success ].
	self assert: [ chatResponse text toLowerCase includes: 'test' ].

	chatReponseCount := chatReponseCount + 1.
!
async stopServer
	self log: 'TestAiServer: API tests successful.'.
	self log: 'TestAiServer: Stopping server.'.

	await Timer timeout: 1000.
	aiServer stop.
!
