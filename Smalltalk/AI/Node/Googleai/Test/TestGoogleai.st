CLASS TestGoogleai EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

"Also tests classes: GoogleaiModel GoogleaiContentResult"

disabled
	^ Googleai available not.
!
async test
	| googleai params model response text |

	googleai := Googleai new.
	self assert: [ googleai apiKey length > 10 ].

	params := GoogleaiModelParams new
		model: Googleai models first.

	model := googleai generativeModel: params.
	self assert: [ model apiKey = googleai apiKey ].
	self assert: [ model model includes: params model ].

	response := await model generateContent: #( 'Say exactly: This is a test' ).
	text := response text.
	self assert: [ text toLowerCase includes: 'test' ].
!
