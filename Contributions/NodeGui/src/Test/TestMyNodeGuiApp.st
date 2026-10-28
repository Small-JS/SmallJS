CLASS TestMyNodeGuiApp EXTENDS Object MODULE TestMyNodeGuiApp CLASSVARS ''
	VARS 'myNodeGuiApp'

"Test MyNodeGuiApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	myNodeGuiApp := MyNodeGuiApp new start.
	await Timer timeout: 1000.
	await TestQApplication all.
	await self testGui.
	"TestMyNodeGuiBase exits the app as the last test."
	await TestMyNodeGuiBase new test: myNodeGuiApp.
!
async testGui
	"Click the 'Change Style' button
	 and check if the style of the greeting label has changed."

	myNodeGuiApp changeStyleButton click.
	await Timer timeout: 1000.
	"NodeGui/QT cannot read widget styles,
	 so just check if colorIndex has changed."
	self assert: [ myNodeGuiApp colorIndex = 1 ].
!
