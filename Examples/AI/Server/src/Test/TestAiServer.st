CLASS TestAiServer EXTENDS Object MODULE TestAiServer CLASSVARS '' VARS 'aiServer chatReponseCount'

"AiServer unit and API tests.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aAiServer
	aiServer := aAiServer.

	"Reference unit test class to include module"
	TestAiProviders.
	"Run sync and async unit tests of all imported Test* classes and log results."
	Test allThen: [
		self testApi ].
!
testApi
	self log: 'TestAiServer: Starting API tests.'.

	"Tests execution is chained to facilite debugging."
	self testProviders.
!
testProviders
	| url |

	url := 'http://localhost:', aiServer port toString, '/api/providers'.
	Fetch
		request: url
		then: [ :response | self onProviders: response ]
		catch: [ :error | error throw ] .
!
onProviders: response
	self assert: [ response status = 200 ].
	response jsonThen: [ :object | self onProviders2: object ].
!
onProviders2: object
	| providers provider ai models |

	providers := AiProviders fromObject: object.
	self assert: [ providers size > 0 ].

	provider := providers map keys first.
	ai := aiServer aiMap get: provider.
	self assert: [ ai notNil ].

	models := providers modelsFor: provider.
	self assert: [ models = ai class models ].

	self testChat.
!
testChat
	chatReponseCount := 0.
	aiServer aiMap values do: [ :ai |
		self chatRequest: ai ].

	Timer timeout: 10000 then: [
		self checkChatCount ].
!
chatRequest: ai
	| chatRequest url |

	chatRequest := AiChatRequest new
		provider: ai name;
		model: ai class models first;
		messages: #( 'Say exactly: This is a test' ).
	url := 'http://localhost:', aiServer port toString, '/api/chat', chatRequest toUrlQuery.

	Fetch
		request: url
		then: [ :response | self onChatResponse: response id: ai nextId ]
		catch: [ :error | error throw ].

!
onChatResponse: response id: id
	self assert: [ response status = 200 ].
	response jsonThen: [ :object | self onChatResponse2: object id: id ].
!
onChatResponse2: object id: id
	| response |

	self log: 'TestAiServer: Resonse received with id: ', id.
	self assert: [ id endsWith: '-1' ].

	response := AiChatResponse fromObject: object.
	self assert: [ response success ].
	self assert: [ response text toLowerCase includes: 'test' ].

	chatReponseCount := chatReponseCount + 1.
!
checkChatCount
	| aiCount |
	aiCount := aiServer aiMap size.
	chatReponseCount = aiCount ifFalse: [
		self log: 'TestAiServer: Warning: Incorrect chat response count: ', chatReponseCount toString, ' expected: ', aiCount toString ].

	self stopServer.
!
stopServer
	self log: 'TestAiServer: API tests successful.'.
	self log: 'TestAiServer: Stopping server.'.

	Timer timeout: 1000 then: [
		aiServer stop ].
!
