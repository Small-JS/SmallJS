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
	"Use the widgets in each row of the widget tester table and check the status column."
	await self testPushButton.
	await self testCheckBox.
	await self testRadioButtons.
	await self testToolButton.
	await self testGroupBox.
	await self testTabWidget.
	await self testStackedWidget.
	await self testAction.
	self testMenuBar.
!
async testPushButton
	"Click the 'Change style' button and check if the style of the styled text has changed."
	self assert: [ myNodeGuiApp styledLabel text = 'Styled text' ].
	self assert: [ myNodeGuiApp colorIndex = 0 ].
	await self clickAndWait: myNodeGuiApp changeStyleButton.
	"NodeGui/QT cannot read widget styles,
	 so just check if colorIndex has changed."
	self assert: [ myNodeGuiApp colorIndex = 1 ].
!
async testCheckBox
	| checkBox status |
	checkBox := myNodeGuiApp checkBox.
	status := myNodeGuiApp checkBoxStatus.
	self assert: [ status text = 'unchecked' ].

	await self clickAndWait: checkBox.
	self assert: [ status text = 'partially checked' ].
	await self clickAndWait: checkBox.
	self assert: [ status text = 'checked' ].
	await self clickAndWait: checkBox.
	self assert: [ status text = 'unchecked' ].
!
async testRadioButtons
	| radioButtons status |
	radioButtons := myNodeGuiApp radioButtons.
	status := myNodeGuiApp radioButtonStatus.
	self assert: [ status text = 'None' ].

	await self clickAndWait: ( radioButtons at: 1 ).
	self assert: [ status text = 'Medium' ].
	await self clickAndWait: ( radioButtons at: 2 ).
	self assert: [ status text = 'Large' ].
	self assert: [ ( radioButtons at: 1 ) isChecked not ].
!
async testToolButton
	| status |
	status := myNodeGuiApp toolButtonStatus.
	self assert: [ status text = 'Not clicked' ].

	await self clickAndWait: myNodeGuiApp toolButton.
	self assert: [ status text = 'Clicked' ].
	"NodeGui QAction cannot be triggered, so invoke the handler of the menu action directly."
	self assert: [ myNodeGuiApp toolMenuActions length = 2 ].
	myNodeGuiApp onToolMenu: 'Paste'.
	await Timer timeout: 500.
	self assert: [ status text = 'Menu: Paste' ].
!
async testGroupBox
	"NodeGui cannot click the check box in the title, so set the checked state, which fires the same event."
	| groupBox status |
	groupBox := myNodeGuiApp groupBox.
	status := myNodeGuiApp groupBoxStatus.
	self assert: [ status text = 'checked' ].

	groupBox setChecked: false.
	await Timer timeout: 500.
	self assert: [ status text = 'unchecked' ].
	groupBox setChecked: true.
	await Timer timeout: 500.
	self assert: [ status text = 'checked' ].
!
async testTabWidget
	"NodeGui cannot click a tab, so set the current index, which fires the same event."
	| tabWidget status |
	tabWidget := myNodeGuiApp tabWidget.
	status := myNodeGuiApp tabWidgetStatus.
	self assert: [ status text = 'Tab: One' ].

	tabWidget setCurrentIndex: 2.
	await Timer timeout: 500.
	self assert: [ status text = 'Tab: Three' ].
	tabWidget setCurrentIndex: 0.
	await Timer timeout: 500.
	self assert: [ status text = 'Tab: One' ].
!
async testStackedWidget
	"Click the 'Next' button through all pages, back to the first page."
	| button status |
	button := myNodeGuiApp nextPageButton.
	status := myNodeGuiApp stackedWidgetStatus.
	self assert: [ status text = 'Page 1' ].

	await self clickAndWait: button.
	self assert: [ status text = 'Page 2' ].
	await self clickAndWait: button.
	self assert: [ status text = 'Page 3' ].
	await self clickAndWait: button.
	self assert: [ status text = 'Page 1' ].
	self assert: [ myNodeGuiApp stackedWidget currentIndex = 0 ].
!
async testAction
	"NodeGui cannot open the menu or trigger its items, so check the actions, which fires the same events."
	| actions status |
	actions := myNodeGuiApp optionActions.
	status := myNodeGuiApp actionStatus.
	self assert: [ status text = 'No options' ].

	( actions at: 0 ) setChecked: true.
	await Timer timeout: 500.
	self assert: [ status text = 'Bold' ].
	( actions at: 2 ) setChecked: true.
	await Timer timeout: 500.
	self assert: [ status text = 'Bold, Underline' ].

	myNodeGuiApp resetOptions.
	await Timer timeout: 500.
	self assert: [ status text = 'No options' ].
!
testMenuBar
	"The menu bar, status bar and shortcut are only used by the user, so check their setup."
	self assert: [ myNodeGuiApp exitAction text = 'Exit' ].
	self assert: [ myNodeGuiApp exitAction shortcut = ( QKeySequence new: 'Ctrl+Q' ) ].
	self assert: [ myNodeGuiApp changeStyleShortcut key = ( QKeySequence new: 'Ctrl+S' ) ].
	self assert: [ myNodeGuiApp statusBar currentMessage = 'Ready' ].
!
async clickAndWait: button
	"Click button, then wait to allow for a visual check."
	button click.
	await Timer timeout: 500.
!
