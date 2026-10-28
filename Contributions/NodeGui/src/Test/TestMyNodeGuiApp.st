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

	await self testButtons.
!
async testButtons
	"Click the buttons and check the status label."
	| radioButtons |
	self assert: [ myNodeGuiApp statusLabel text = 'Click a button.' ].

	await self clickAndWait: myNodeGuiApp checkBox.
	self assert: [ myNodeGuiApp statusLabel text = 'Check box: partially checked' ].
	await self clickAndWait: myNodeGuiApp checkBox.
	self assert: [ myNodeGuiApp statusLabel text = 'Check box: checked' ].
	await self clickAndWait: myNodeGuiApp checkBox.
	self assert: [ myNodeGuiApp statusLabel text = 'Check box: unchecked' ].

	radioButtons := myNodeGuiApp radioButtons.
	await self clickAndWait: ( radioButtons at: 1 ).
	self assert: [ myNodeGuiApp statusLabel text = 'Radio button: Medium' ].
	await self clickAndWait: ( radioButtons at: 2 ).
	self assert: [ myNodeGuiApp statusLabel text = 'Radio button: Large' ].
	self assert: [ ( radioButtons at: 1 ) isChecked not ].

	await self clickAndWait: myNodeGuiApp toolButton.
	self assert: [ myNodeGuiApp statusLabel text = 'Tool button clicked' ].
	"NodeGui QAction cannot be triggered, so invoke the handler of the menu action directly."
	self assert: [ myNodeGuiApp toolMenuActions length = 2 ].
	myNodeGuiApp onToolMenu: 'Paste'.
	await Timer timeout: 500.
	self assert: [ myNodeGuiApp statusLabel text = 'Tool menu: Paste' ].
!
async clickAndWait: button
	"Click button, then wait to allow for a visual check."
	button click.
	await Timer timeout: 500.
!
