CLASS TestGoogleai EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

"Also tests classes: GoogleaiModel GoogleaiContentResult"

disabled
	^ Googleai available not.
!
test
	| googleai params model |

	googleai := Googleai new.
	self assert: [ googleai apiKey length > 10 ].

	params := GoogleaiModelParams new
		model: Googleai models first.

	model := googleai generativeModel: params.
	self assert: [ model apiKey = googleai apiKey ].
	self assert: [ model model includes: params model ].

	model generateContent: 'Say this is a test'
		then: [ :response | self onGenerateContent: response ].
!
onGenerateContent: response
	| text |
	text := response text.
	self assert: [ text toLowerCase includes: 'test' ].
!
