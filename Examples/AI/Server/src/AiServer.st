CLASS AiServer EXTENDS Object MODULE AiServer CLASSVARS '' VARS 'express server port aiMap'

	"This app provides an AI API for its clients in the /api route.
	 It also provides a static web server for client web content.
	 It uses AI providers that are enabled in the '.env' file."

	"Note: This example app does not have user authentication.
		See the Shop server example for an implementation of that."

METHODS

start
	self log: 'AI example server starting'.
	self connectAis.
	self startServer.
!
connectAis
	| aiName |
	aiMap := Map new.
	Ai aiClasses do: [ :aiClass |
		aiClass available ifTrue: [
			aiName := aiClass name toLowerCase.
			self log: 'Enabling: ', aiName.
			aiMap set: aiName value: aiClass new ]	].

	aiMap size >= 1 ifFalse: [
		self error: 'No AIs available, check file: .env (and .env.example)' ].
!
startServer
	| portString |

	express := Express new.
	express useSession.
	express static: '../Client/web'.
	express get: '/api/providers'
		then: [ :request :response | self onProviders: request response: response ].
	express get: '/api/chat'
		then: [ :request :response | self onChat: request response: response ].

	portString := Process envAt: 'AI_SERVER_PORT'.
	portString ifNil: [
		self error: 'Environment variable "AI_SERVER_PORT" not set.' ].
	port := portString toInteger.
	( port > 0 ) & ( port < 65536 ) ifFalse: [
		self error: 'Invalid port number: ', portString ].

	self log: 'Starting web server on port: ', portString.
	server := express listen: port
		then: [ self onListen ].
!
onListen
	self log: 'Web server started'.

	self testMode ifTrue: [
		TestAiServer new test: self ].
!
testMode
	^ Process argv length >= 3 and: [ ( Process argv at: 2 ) = '-test' ].
!

"Respond with an array of AI provides and their available models,
a JSON instance of class AiProviders.

Example request:
	http://localhost:3000/api/providers
There are no arguments.

For an example result see class AiProviders."

onProviders: request response: response
	| providers |

	providers := Ai providers.
	response send: providers toObject.
	self log: 'AiServer: Sent providers: ', providers toString.
!


"For the text AI chat request answer a text reponse from the selected AI.

Example request:
	http://localhost:3000/api/chat/?ai=openai&text=Say%20this%20is%20a%20test
Example result:
 	{ success: true, text: 'This is a test.' }"

onChat: request response: response
	| chatResponse chatRequest |

	chatResponse := AiChatResponse new success: false; text: ''.

	chatRequest := AiChatRequest fromObject: request queryObject.
	self log: 'AiServer: Received chat request: ', chatRequest toString.

	chatRequest provider isNil
		ifTrue: [ response send: ( chatResponse text: 'Chat request parameter "provider" missing' ) ]
		ifFalse: [
			chatRequest model isNil
				ifTrue: [ response send: ( chatResponse text: 'Chat request parameter "model" missing' ) ]
				ifFalse: [
					chatRequest text isNil
						ifTrue: [ response send: ( chatResponse text: 'Chat request parameter "text" missing' ) ]
						ifFalse: [ self onChat2: chatRequest response: response ] ] ].
!
onChat2: chatRequest response: response
	| provider ai |

	provider := chatRequest provider toLowerCase.
	ai := aiMap get: provider.
	ai isNil
		ifTrue: [ response send: ( AiChatResponse success: false text: 'AI provider not available: ', provider ) ]
		ifFalse: [ ai chat: chatRequest text
			then: [ :text | self onChat3: text response: response ] ].
!
onChat3: text response: response
	| chatResponse |

	chatResponse := AiChatResponse new success: true; text: text.
	response send: chatResponse.

	self log: 'AiServer: Sent chat response: ', chatResponse toString.
!
stop
	server terminate.
!

"Accessing - used in tests"

express
	^ express.
!
server
	^ server.
!
port
	^ port.
!
aiMap
	^ aiMap.
!
