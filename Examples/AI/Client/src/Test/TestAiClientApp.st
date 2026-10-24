CLASS TestAiClientApp EXTENDS Object MODULE TestAiClientApp CLASSVARS '' VARS 'aiClientApp'

"Tests the GUI of the AI client chat page.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	aiClientApp := AiClientApp new.
	await aiClientApp start.

	"Run sync and async tests of all imported Test* classes and log results."
	await TestAiProviders all.
	await self testGui.
	await self stop.
!
async testGui
	"Check if the provider and model fields are filled, then ask questions and clear the conversation."

	await Timer timeout: 500.
	self testLoadedFields.
	self testEmptyQuestion.
	await self testAskQuestion.
	await self testClearConversation.
!
testLoadedFields
	self assert: [ aiClientApp modelSelect value length > 0 ].
	self assert: [ aiClientApp providerSelect value length > 0 ].
	self assert: [ aiClientApp questionAskButton disabled not ].
!
testEmptyQuestion
	"An empty question is not sent and shows an error."
	aiClientApp questionTextArea value: '  '.
	aiClientApp questionAskButton click.

	self assert: [ aiClientApp errorSpan textContent length > 0 ].
	self assert: [ aiClientApp conversationMessages isEmpty ].
	self assert: [ aiClientApp conversationTable rows length = 0 ].
!
async testAskQuestion
	| conversationTable questionSpan answerSpan |

	aiClientApp questionTextArea value: 'Say exactly: This is a test'.
	aiClientApp questionAskButton click.
	self assert: [ aiClientApp questionAskButton disabled ].
	await self waitForAnswer.

	self assert: [ aiClientApp errorSpan textContent = '' ].
	conversationTable := aiClientApp conversationTable.
	self assert: [ conversationTable rows length = 2 ].

	questionSpan := conversationTable rows first cells first firstElementChild.
	self assert: [ questionSpan textContent = 'Say exactly: This is a test' ].

	answerSpan := conversationTable rows last cells first lastElementChild.
	self assert: [ answerSpan textContent toLowerCase includes: 'test' ].

	"The question and answer are kept, to resend them with the next question."
	self assert: [ aiClientApp conversationMessages length = 2 ].
	self assert: [ aiClientApp conversationMessages first = 'Say exactly: This is a test' ].
	self assert: [ aiClientApp conversationMessages last = answerSpan textContent ].
!
async waitForAnswer
	"Wait until the Ask button is enabled again, with a maximum of 30 seconds."
	await self waitForAnswer: 300.
	self assert: [ aiClientApp questionAskButton disabled not ].
!
async waitForAnswer: count
	( aiClientApp questionAskButton disabled and: [ count > 0 ] ) ifFalse: [ ^ nil ].
	await Timer timeout: 2000.
	await self waitForAnswer: count - 1.
!
async testClearConversation
	aiClientApp conversationClearButton click.
	await Timer timeout: 1000.

	self assert: [ aiClientApp conversationTable rows length = 0 ].
	self assert: [ aiClientApp conversationMessages isEmpty ].
!
async stop
	"Pause before closing the browser, to allow a visual check."
	await Timer timeout: 1000.
	aiClientApp stop.
!
