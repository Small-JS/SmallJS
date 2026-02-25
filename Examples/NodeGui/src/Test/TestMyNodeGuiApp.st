CLASS TestMyNodeGuiApp EXTENDS Object MODULE TestMyNodeGuiApp CLASSVARS ''
	VARS 'myNodeguiApp'

"Test MyNodeguiApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	myNodeguiApp := MyNodeGuiApp new start.
	await Timer timeout: 1000.
	await TestQApplication all.
 	await self testGui.
!
async testGui
	"Click the 'Change Style' button
	 and check if the style of the greeting label has changed."

	myNodeguiApp changeStyleButton click.
	await Timer timeout: 1000.
	"NodeGui/QT cannot read widget styles,
	 so just check if colorIndex has changed."
	self assert: [ myNodeguiApp colorIndex = 1 ].

	await Timer timeout: 1000.
	myNodeguiApp quit.
!
