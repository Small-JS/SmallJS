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
	await self testLabel.
	await self testFrame.
	await self testLineEdit.
	await self testProgressBar.
	await self testLcdNumber.
	await self testCalendar.
	await self testColor.
	await self testFont.
	await self testWindow.
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
	self assert: [ myNodeGuiApp window statusBar = myNodeGuiApp statusBar ].
!
async testLabel
	"NodeGui cannot click the link, so check the setup. The heart is animated."
	| frame |
	self assert: [ myNodeGuiApp richLabel textFormat = QLabel richText ].
	self assert: [ myNodeGuiApp labelStatus text = 'No link clicked' ].
	self assert: [ myNodeGuiApp heart state = QMovie running ].
	frame := myNodeGuiApp heart currentFrameNumber.
	await Timer timeout: 500.
	self assert: [ myNodeGuiApp heart currentFrameNumber ~= frame ].
!
async testFrame
	"Click the 'Shape' button through all shapes, back to the first."
	| frame status |
	frame := myNodeGuiApp frame.
	status := myNodeGuiApp frameStatus.
	self assert: [ status text = 'Shape: Box' ].
	self assert: [ frame frameShape = QFrame box ].
	self assert: [ frame frameShadow = QFrame sunken ].

	await self clickAndWait: myNodeGuiApp shapeButton.
	self assert: [ status text = 'Shape: Panel' ].
	self assert: [ frame frameShape = QFrame panel ].
	await self clickAndWait: myNodeGuiApp shapeButton.
	self assert: [ frame frameShape = QFrame styledPanel ].
	await self clickAndWait: myNodeGuiApp shapeButton.
	self assert: [ status text = 'Shape: Box' ].
!
async testLineEdit
	"NodeGui cannot type keys, so insert text, which fires the same event."
	| lineEdit status |
	lineEdit := myNodeGuiApp lineEdit.
	status := myNodeGuiApp lineEditStatus.
	self assert: [ status text = 'Empty' ].
	self assert: [ lineEdit placeholderText = 'Type here' ].

	lineEdit insert: 'Hello'.
	await Timer timeout: 500.
	self assert: [ status text = 'Text: Hello' ].
	lineEdit clear.
	await Timer timeout: 500.
	self assert: [ status text = 'Empty' ].
!
async testProgressBar
	"Click the 'Step' button until the progress wraps around to 0."
	| progressBar status |
	progressBar := myNodeGuiApp progressBar.
	status := myNodeGuiApp progressBarStatus.
	self assert: [ status text = 'Value: 0' ].

	await self clickAndWait: myNodeGuiApp stepButton.
	self assert: [ status text = 'Value: 25' ].
	self assert: [ progressBar text = '25%' ].
	await self clickAndWait: myNodeGuiApp stepButton.
	await self clickAndWait: myNodeGuiApp stepButton.
	await self clickAndWait: myNodeGuiApp stepButton.
	self assert: [ progressBar value = 100 ].
	await self clickAndWait: myNodeGuiApp stepButton.
	self assert: [ status text = 'Value: 0' ].
!
async testLcdNumber
	| status |
	status := myNodeGuiApp lcdNumberStatus.
	self assert: [ status text = 'Count: 0' ].
	await self clickAndWait: myNodeGuiApp countButton.
	await self clickAndWait: myNodeGuiApp countButton.
	self assert: [ status text = 'Count: 2' ].
	self assert: [ myNodeGuiApp lcdNumber intValue = 2 ].
!
async testCalendar
	"Click the 'Select date' button to pop up the calendar below it.
	 NodeGui cannot click a date, so select it, which fires the same event, and close the popup."
	| calendar button status today |
	calendar := myNodeGuiApp calendar.
	button := myNodeGuiApp dateButton.
	status := myNodeGuiApp calendarStatus.
	today := QDate today.
	self assert: [ status text = ( 'Date: ', today toString ) ].
	self assert: [ calendar isVisible not ].

	await self clickAndWait: button.
	self assert: [ calendar isVisible ].
	self assert: [ calendar isWindow ].
	self assert: [ calendar pos = ( button mapToGlobal: ( QPoint x: 0 y: button height ) ) ].

	calendar setSelectedDate: ( today addDays: 1 ).
	await Timer timeout: 500.
	self assert: [ status text = ( 'Date: ', ( today addDays: 1 ) toString ) ].
	calendar setSelectedDate: today.
	await Timer timeout: 500.
	self assert: [ status text = ( 'Date: ', today toString ) ].

	calendar hide.
	await Timer timeout: 500.
	self assert: [ calendar isVisible not ].
!
async testColor
	"Click the 'Color' button and check the color of the swatch."
	| status |
	status := myNodeGuiApp colorStatus.
	self assert: [ status text = ( 'Color: ', ( QColor hue: 0 saturation: 200 value: 230 ) name ) ].
	self assert: [ myNodeGuiApp swatch sizeHint = ( QSize width: 40 height: 16 ) ].

	await self clickAndWait: myNodeGuiApp colorButton.
	self assert: [ status text = ( 'Color: ', ( QColor hue: 60 saturation: 200 value: 230 ) name ) ].
	self assert: [ myNodeGuiApp swatchColor = ( QColor hue: 60 saturation: 200 value: 230 ) ].
!
async testFont
	"Click the 'Font' button through all fonts, back to the first."
	| status |
	status := myNodeGuiApp fontStatus.
	self assert: [ status text = 'Arial 10' ].
	await self clickAndWait: myNodeGuiApp fontButton.
	self assert: [ status text = 'Courier New 11 bold' ].
	self assert: [ myNodeGuiApp fontSample font bold ].
	await self clickAndWait: myNodeGuiApp fontButton.
	self assert: [ status text = 'Times New Roman 12 italic' ].
	await self clickAndWait: myNodeGuiApp fontButton.
	self assert: [ status text = 'Arial 10' ].
!
async testWindow
	"Resizing and moving the visible window fires events. Restore the geometry afterwards."
	| window geometry moveCount |
	window := myNodeGuiApp window.
	self assert: [ window isVisible ].
	self assert: [ window isWindow ].
	geometry := window geometry.
	moveCount := 0.
	window onMove: [ moveCount := moveCount + 1 ].

	window resize: ( QSize width: geometry width + 20 height: geometry height ).
	await Timer timeout: 500.
	self assert: [ myNodeGuiApp statusBar currentMessage =
		( 'Window size: ', ( geometry width + 20 ) toString, ' x ', geometry height toString ) ].

	window move: ( QPoint x: window x + 10 y: window y ).
	await Timer timeout: 500.
	self assert: [ moveCount > 0 ].
	window setGeometry: geometry.
	await Timer timeout: 500.

	"A widget in the window is visible, until it is hidden."
	self assert: [ myNodeGuiApp lcdNumber isVisible ].
	myNodeGuiApp lcdNumber hide.
	self assert: [ myNodeGuiApp lcdNumber isVisible not ].
	myNodeGuiApp lcdNumber show.
	self assert: [ myNodeGuiApp lcdNumber isVisible ].
	self assert: [ ( myNodeGuiApp lcdNumber window ) = window ].
!
async clickAndWait: button
	"Click button, then wait to allow for a visual check."
	button click.
	await Timer timeout: 500.
!
