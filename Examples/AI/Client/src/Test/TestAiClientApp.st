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
	self assert: [ aiClientApp modelSelect selectedText length > 0 ].
	self assert: [ aiClientApp providerSelect selectedText length > 0 ].

	self testAsk.
!
testAsk
	aiClientApp questionTextArea value: 'Say this is a test'.
	aiClientApp askButton click.
	Timer timeout: 5000
		then: [ self testAnswer ].
!
testAnswer
	self assert: [ aiClientApp answerTextArea value toLowerCase includes: 'this is a test' ].
	self stop.
!
stop
	aiClientApp stop.
!
