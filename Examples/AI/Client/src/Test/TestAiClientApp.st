CLASS TestAiClientApp EXTENDS Object MODULE TestAiClientApp CLASSVARS '' VARS 'aiClientApp'

"Tests the GUI of the AI client login page.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	aiClientApp := AiClientApp new.
	await aiClientApp start.

	"Run sync and async tests of all imported Test* classes and log results."
	await TestAiProviders all.
	await self testGui.
	self stop.
!
async testGui
	"Check if login fields are filled correctly and then press login button.
	 Should navigate tot producs page then."

	await Timer timeout: 500.
	self testLoadedFields.
	await self testAskQuestion.

!
testLoadedFields
	self assert: [ aiClientApp modelSelect value length > 0 ].
	self assert: [ aiClientApp providerSelect value length > 0 ].
!
async testAskQuestion
	| conversationTable questionSpan answerSpan |

	aiClientApp questionTextArea value: 'Say exactly: This is a test'.
	aiClientApp questionAskButton click.
	await Timer timeout: 8000.

	conversationTable := aiClientApp conversationTable.
	self assert: [ conversationTable rows length = 2 ].

	questionSpan := conversationTable rows first cells first firstElementChild.
	self assert: [ questionSpan textContent = 'Say exactly: This is a test' ].

	answerSpan := conversationTable rows last cells first lastElementChild.
	self assert: [ answerSpan textContent toLowerCase includes: 'test' ].

	self testClearConversation.
!
async testClearConversation
	aiClientApp conversationClearButton click.
	await Timer timeout: 1000.

	self assert: [ aiClientApp conversationTable rows length = 0 ].
!
stop
	aiClientApp stop.
!
