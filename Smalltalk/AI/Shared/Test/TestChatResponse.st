CLASS TestAiChatResponse EXTENDS Test MODULE TestAi CLASSVARS '' VARS ''

test
	| response object |

	response := AiChatResponse new
		success: true;
		text: 'Your answer'.
	self assert: [ response success ].
	self assert: [ response text = 'Your answer' ].
	self assert: [ response toString = 'AiChatResponse( success: true, text: "Your answer" )' ].

	object := Object new
		atProperty: 'success' put: false;
		atProperty: 'text' put: 'Failed to answer'.
	response := AiChatResponse fromObject: object.
	self assert: [ response success not ].
	self assert: [ response text = 'Failed to answer' ].
!
