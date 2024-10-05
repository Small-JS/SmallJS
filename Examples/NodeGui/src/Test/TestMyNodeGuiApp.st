CLASS TestMyNodeGuiApp EXTENDS Object MODULE TestMyNodeGuiApp CLASSVARS ''
	VARS 'myNodeguiApp'

"Test MyNodeguiApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aMyNodeguiApp
	myNodeguiApp := aMyNodeguiApp.

	"Import NodeGui unit tests."
	TestQApplication.

	Test allThen: [
	 	self testGui ].
!
testGui
	"Click the 'Change Style' button
	 and check if the style of the greeting label has changed."

	myNodeguiApp changeStyleButton click.
	Timer timeout: 1000 then: [
		"NodeGui/QT cannot read widget styles,
		 so just check if colorIndex has changed."
		self assert: [ myNodeguiApp colorIndex = 1 ].
		Timer timeout: 1000 then: [
			myNodeguiApp quit ] ].
!
