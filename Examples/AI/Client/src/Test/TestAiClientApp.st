CLASS TestAiClientApp EXTENDS Object MODULE TestAiClientApp CLASSVARS '' VARS 'aiClientApp'

"Tests the GUI of the AI client login page.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aAiClientApp
	aiClientApp := aAiClientApp.

	"Reference unit test class to include the module."
	TestAiProviders.
	"Run sync and async tests of all imported Test* classes and log results."
	Test allThen: [
		self testGui ].
!
testGui
	"Check if login fields are filled correctly and then press login button.
	 Should navigate tot producs page then."

	Timer timeout: 500
		then: [ self testLoadedFields ].
!
testLoadedFields
	self assert: [ aiClientApp modelSelect value length > 0 ].
	self assert: [ aiClientApp providerSelect value length > 0 ].

	self testAskQuestion.
!
testAskQuestion
	aiClientApp questionTextArea value: 'Say exactly: This is a test'.
	aiClientApp questionAskButton click.
	Timer timeout: 8000
		then: [ self onTestAskQuestion ].
!
onTestAskQuestion
	| conversationTable questionSpan answerSpan |

	conversationTable := aiClientApp conversationTable.
	self assert: [ conversationTable rows length = 2 ].

	questionSpan := conversationTable rows first cells first firstElementChild.
	self assert: [ questionSpan textContent = 'Say exactly: This is a test' ].

	answerSpan := conversationTable rows last cells first lastElementChild.
	self assert: [ answerSpan textContent toLowerCase includes: 'test' ].

	self testClearConversation.
!
testClearConversation
	aiClientApp conversationClearButton click.
	Timer timeout: 1000
		then: [ self onTestClearConversation ].
!
onTestClearConversation
	self assert: [ aiClientApp conversationTable rows length = 0 ].

	self stop.
!
stop
	aiClientApp stop.
!
