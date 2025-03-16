CLASS TestGoogleai EXTENDS Test MODULE AiTest CLASSVARS '' VARS ''

"Also tests classes: GoogleaiModel GoogleaiContentResult"

disabled
	^ Googleai available not.
!
test
	| googleai params model |

	googleai := Googleai new.
	self assert: [ googleai myApiKey length > 10 ].

	params := GoogleaiModelParams new
		model: googleai models first.

	model := googleai generativeModel: params.
	self assert: [ model apiKey = googleai myApiKey ].
	self assert: [ model model includes: params model ].

	model generateContent: 'Say this is a test'
		then: [ :response | self onGenerateContent: response ].
!
onGenerateContent: response
	| text |
	text := response text.
	self assert: [ text toLowerCase includes: 'this is a test'  ].
!
