CLASS MyNodeGuiApp EXTENDS QApplication MODULE MyNodeGuiApp CLASSVARS ''
	VARS 'window greetLabel colors colorIndex
		changeStyleButton styledLabel checkBox checkBoxStatus
		radioButtons buttonGroup radioButtonStatus toolButton toolMenuActions toolButtonStatus
		groupBox groupBoxStatus tabWidget tabNames tabWidgetStatus
		stackedWidget nextPageButton stackedWidgetStatus
		statusBar exitAction changeStyleShortcut optionsButton optionActions actionStatus
		heart richLabel labelStatus frame frameShapes frameShapeIndex shapeButton frameStatus
		lineEdit lineEditStatus progressBar stepButton progressBarStatus
		lcdNumber countButton lcdNumberStatus dateButton calendar calendarStatus'

start
	colors := #( 'black' 'red' 'green' 'blue' ).
	colorIndex := 0.

	self createWindow.
!
createWindow
	window := QMainWindow new.
	window setWindowTitle: 'Hello NodeGui'.
	window setWindowIcon: self createIcon.
	window setMenuBar: self createMenuBar.
	window setStatusBar: self createStatusBar.
	window setStyleSheet: self createStyleSheet.
	window setCentralWidget: self createCentralWidget.
	self createShortcut.
	window resize: ( QSize width: 720 height: 700 ).
	window onResize: [ self showWindowSize ].
	window show.
!
createIcon
	^ QIcon new: 'assets/logo.ico'.
!
createMenuBar
	| menu menuBar |
	exitAction := QAction new.
	exitAction setText: 'Exit'.
	exitAction setShortcut: ( QKeySequence new: 'Ctrl+Q' ).
	exitAction onTrigger: [ self onFileExit ].

	menuBar := QMenuBar new.
	menu := menuBar addMenuWithTitle: 'File'.
	menu addAction: exitAction.
	^ menuBar.
!
createStatusBar
	"The status bar shows the last menu item triggered by the user."
	statusBar := QStatusBar new.
	statusBar showMessage: 'Ready'.
	^ statusBar.
!
createShortcut
	"Ctrl+S has the same effect as the 'Change style' button."
	changeStyleShortcut := QShortcut new: window.
	changeStyleShortcut setKey: ( QKeySequence new: 'Ctrl+S' ).
	changeStyleShortcut onActivate: [ self changeStyle ].
!
onFileExit
	QApplication instance quit.
!
showWindowSize
	statusBar showMessage: 'Window size: ', window width toString, ' x ', window height toString.
!
createStyleSheet
	^ ( Fs readFileSync: 'assets/default.css' ) toString.
!
createCentralWidget
	| widget |
	widget := QWidget new.
	widget setObjectName: 'root'.
	widget setLayout: self createRootLayout.
	^ widget.
!
createRootLayout
	| layout |
	layout := QBoxLayout new: QLayout topToBottom.
	layout addWidget: self createGreetLabel stretch: 0 align: QLayout alignCenter.
	layout addWidget: self createImageLabel stretch: 0 align: QLayout alignCenter.
	layout addWidget: self createTableScrollArea stretch: 1 align: 0.
	^ layout.
!
createImageLabel
	| image label |
	image := QPixmap new: 'assets/logo.png'.
	label := QLabel new setPixmap: image.
	^ label.
!
createGreetLabel
	| label |
	label := QLabel new.
	label setObjectName: 'greetLabel'.
	label setText: 'Hello from NodeGui!'.
	greetLabel := label.
	^ label.
!
"Widget tester table, like the element tester table of the Browser example.
 Each row shows a widget type, a widget of that type and the status of its last event.
 The 'Change style' button changes the style of the text in its status column instead."

createTableScrollArea
	"The table can be higher than the window, so show it in a scroll area."
	| scrollArea |
	scrollArea := QScrollArea new.
	scrollArea setWidget: self createTable.
	scrollArea setWidgetResizable: true.
	scrollArea setAlignment: QLayout alignHCenter.
	^ scrollArea.
!
createTable
	| layout widget |
	layout := QGridLayout new.
	"Keep the status column wide enough, so the table does not resize when a status changes."
	layout setColumnMinimumWidth: 2 to: 160.

	self addRow: 0 to: layout type: 'PushButton' widget: self createChangeStyleButton
		status: ( styledLabel := self createStatusLabel: 'Styled text' ).
	self addRow: 1 to: layout type: 'CheckBox' widget: self createCheckBox
		status: ( checkBoxStatus := self createStatusLabel: 'unchecked' ).
	self addRow: 2 to: layout type: 'RadioButton' widget: ( self createRow: self createRadioButtons )
		status: ( radioButtonStatus := self createStatusLabel: 'None' ).
	self addRow: 3 to: layout type: 'ToolButton' widget: self createToolButton
		status: ( toolButtonStatus := self createStatusLabel: 'Not clicked' ).
	self addRow: 4 to: layout type: 'GroupBox' widget: self createGroupBox
		status: ( groupBoxStatus := self createStatusLabel: 'checked' ).
	self addRow: 5 to: layout type: 'TabWidget' widget: self createTabWidget
		status: ( tabWidgetStatus := self createStatusLabel: 'Tab: One' ).
	self addRow: 6 to: layout type: 'StackedWidget' widget: self createStackedWidgetRow
		status: ( stackedWidgetStatus := self createStatusLabel: 'Page 1' ).
	self addRow: 7 to: layout type: 'Action' widget: self createOptionsButton
		status: ( actionStatus := self createStatusLabel: 'No options' ).
	self addRow: 8 to: layout type: 'Label' widget: self createLabelRow
		status: ( labelStatus := self createStatusLabel: 'No link clicked' ).
	self addRow: 9 to: layout type: 'Frame' widget: self createFrameRow
		status: ( frameStatus := self createStatusLabel: 'Shape: Box' ).
	self addRow: 10 to: layout type: 'LineEdit' widget: self createLineEdit
		status: ( lineEditStatus := self createStatusLabel: 'Empty' ).
	self addRow: 11 to: layout type: 'ProgressBar' widget: self createProgressBarRow
		status: ( progressBarStatus := self createStatusLabel: 'Value: 0' ).
	self addRow: 12 to: layout type: 'LcdNumber' widget: self createLcdNumberRow
		status: ( lcdNumberStatus := self createStatusLabel: 'Count: 0' ).
	self addRow: 13 to: layout type: 'Calendar' widget: self createDateButton
		status: ( calendarStatus := self createStatusLabel: 'Date: ', QDate today toString ).

	widget := QWidget new.
	widget setObjectName: 'table'.
	widget setLayout: layout.
	^ widget.
!
addRow: row to: layout type: typeName widget: widget status: statusLabel
	"The status tip is shown in the status bar, when the mouse is over the widget."
	widget setStatusTip: 'A widget of type ', typeName.
	layout addWidget: ( self createLabel: typeName name: 'typeName' ) row: row column: 0 align: QLayout alignVCenter.
	layout addWidget: widget row: row column: 1 align: QLayout alignLeft.
	layout addWidget: statusLabel row: row column: 2 align: QLayout alignVCenter.
!
createLabel: text name: name
	| label |
	label := QLabel new.
	label setObjectName: name.
	label setText: text.
	^ label.
!
createStatusLabel: text
	^ self createLabel: text name: 'status'.
!
createRow: widgets
	"Answer a widget with widgets arranged horizontally."
	| layout row |
	layout := QBoxLayout new: QLayout leftToRight.
	widgets do: [ :widget |
		layout addWidget: widget stretch: 0 align: QLayout alignVCenter ].

	row := QWidget new.
	row setLayout: layout.
	^ row.
!
createChangeStyleButton
	changeStyleButton := QPushButton new.
	changeStyleButton setObjectName: 'changeStyleButton'.
	changeStyleButton setText: 'Change style'.
	changeStyleButton onClick: [ self changeStyle ].
	^ changeStyleButton.
!
changeStyle
	colorIndex := colorIndex + 1 % colors length.
	styledLabel setInlineStyle: 'color: ', ( colors at: colorIndex ).
!
createCheckBox
	checkBox := QCheckBox new.
	checkBox setText: 'Tristate'.
	checkBox setTristate: true.
	checkBox onStateChange: [ checkBoxStatus setText: self checkStateName ].
	^ checkBox.
!
checkStateName
	checkBox checkState = QCheckBox unchecked ifTrue: [ ^ 'unchecked' ].
	checkBox checkState = QCheckBox partiallyChecked ifTrue: [ ^ 'partially checked' ].
	^ 'checked'.
!
createRadioButtons
	"The radio buttons are grouped, so only one can be checked."
	| id |
	radioButtons := #( 'Small' 'Medium' 'Large' ) map: [ :text |
		QRadioButton new setText: text ].
	buttonGroup := QButtonGroup new.
	id := 0.
	radioButtons do: [ :radioButton |
		id := id + 1.
		buttonGroup addButton: radioButton id: id ].
	buttonGroup onIdClick: [ :id |
		radioButtonStatus setText: ( buttonGroup button: id ) text ].
	^ radioButtons.
!
createToolButton
	"Clicking the button shows a status, clicking its arrow shows a menu."
	| menu |
	menu := QMenu new.
	toolMenuActions := #( 'Copy' 'Paste' ) map: [ :text | self createToolMenuAction: text ].
	toolMenuActions do: [ :action | menu addAction: action ].

	toolButton := QToolButton new.
	toolButton setText: 'Tool'.
	toolButton setArrowType: QToolButton rightArrow.
	toolButton setToolButtonStyle: QToolButton textBesideIcon.
	toolButton setMenu: menu.
	toolButton setPopupMode: QToolButton menuButtonPopup.
	toolButton onClick: [ toolButtonStatus setText: 'Clicked' ].
	^ toolButton.
!
createToolMenuAction: text
	| action |
	action := QAction new.
	action setText: text.
	action addEventListener: 'triggered' then: [ self onToolMenu: text ].
	^ action.
!
onToolMenu: text
	toolButtonStatus setText: 'Menu: ', text.
!
createGroupBox
	"Unchecking the group box disables the widgets in it."
	| layout |
	layout := QBoxLayout new: QLayout leftToRight.
	layout addWidget: ( QLabel new setText: 'Grouped label' ) stretch: 0 align: QLayout alignLeft.
	layout addWidget: ( QPushButton new setText: 'Grouped button' ) stretch: 0 align: QLayout alignLeft.

	groupBox := QGroupBox new.
	groupBox setTitle: 'Enabled'.
	groupBox setCheckable: true.
	groupBox setLayout: layout.
	groupBox onToggle: [
		groupBoxStatus setText: ( groupBox isChecked ifTrue: [ 'checked' ] ifFalse: [ 'unchecked' ] ) ].
	^ groupBox.
!
createTabWidget
	tabNames := #( 'One' 'Two' 'Three' ).
	tabWidget := QTabWidget new.
	tabNames do: [ :name |
		tabWidget addTab: ( QLabel new setText: 'Page ', name ) label: name ].
	tabWidget onCurrentChange: [
		tabWidgetStatus setText: 'Tab: ', ( tabNames at: tabWidget currentIndex ) ].
	^ tabWidget.
!
createStackedWidgetRow
	"The 'Next' button shows the next page of the stacked widget."
	stackedWidget := QStackedWidget new.
	#( 'Page 1' 'Page 2' 'Page 3' ) do: [ :text |
		stackedWidget addWidget: ( QLabel new setText: text ) ].
	stackedWidget onCurrentChange: [
		stackedWidgetStatus setText: 'Page ', ( stackedWidget currentIndex + 1 ) toString ].

	nextPageButton := QPushButton new.
	nextPageButton setText: 'Next'.
	nextPageButton onClick: [
		stackedWidget setCurrentIndex: stackedWidget currentIndex + 1 % stackedWidget count ].
	^ self createRow: ( Array new add: stackedWidget; add: nextPageButton ).
!
createOptionsButton
	"A button with a menu of checkable actions. The status shows the checked actions.
	 Triggering a menu item also shows it in the status bar."
	| menu resetAction |
	menu := QMenu new.
	menu addSection: 'Options'.
	optionActions := #( 'Bold' 'Italic' 'Underline' ) map: [ :text | self createOptionAction: text ].
	optionActions do: [ :action | menu addAction: action ].
	menu addSeparator.
	resetAction := QAction new setText: 'Reset'.
	resetAction onTrigger: [ self resetOptions ].
	menu addAction: resetAction.
	menu onTrigger: [ :action | statusBar showMessage: 'Menu: ', action text ].

	optionsButton := QToolButton new.
	optionsButton setText: 'Options'.
	optionsButton setMenu: menu.
	optionsButton setPopupMode: QToolButton instantPopup.
	^ optionsButton.
!
createOptionAction: text
	| action |
	action := QAction new.
	action setText: text.
	action setCheckable: true.
	action onToggle: [ self showOptions ].
	^ action.
!
showOptions
	| checked |
	checked := ( optionActions filter: [ :action | action isChecked ] ) map: [ :action | action text ].
	actionStatus setText: ( checked isEmpty ifTrue: [ 'No options' ] ifFalse: [ checked join: ', ' ] ).
!
resetOptions
	optionActions do: [ :action | action setChecked: false ].
!
createLabelRow
	"A label with an animated heart and a rich text label with a link.
	 Clicking the link shows it in the status column, instead of opening it."
	heart := QMovie new: 'assets/heart.gif'.
	heart start.
	richLabel := QLabel new.
	richLabel setTextFormat: QLabel richText.
	richLabel setText: '<i>Rich</i> text with a <a href="#link">link</a>'.
	richLabel onLinkActivate: [ :link | labelStatus setText: 'Link: ', link ].
	^ self createRow: ( Array new add: ( QLabel new setMovie: heart ); add: richLabel ).
!
createFrameRow
	"The 'Shape' button shows the next frame shape."
	frameShapes := #( 'Box' 'Panel' 'StyledPanel' ).
	frameShapeIndex := 0.
	frame := QFrame new.
	frame setFrameShadow: QFrame sunken.
	frame setLineWidth: 2.
	frame setLayout: ( ( QBoxLayout new: QLayout leftToRight ) addWidget: ( QLabel new setText: 'Framed label' ) stretch: 0 align: QLayout alignCenter ).
	self showFrameShape.

	shapeButton := QPushButton new.
	shapeButton setText: 'Shape'.
	shapeButton onClick: [
		frameShapeIndex := frameShapeIndex + 1 % frameShapes length.
		self showFrameShape ].
	^ self createRow: ( Array new add: frame; add: shapeButton ).
!
showFrameShape
	| shapes |
	shapes := Array new add: QFrame box; add: QFrame panel; add: QFrame styledPanel.
	frame setFrameShape: ( shapes at: frameShapeIndex ).
	frameStatus notNil ifTrue: [
		frameStatus setText: 'Shape: ', ( frameShapes at: frameShapeIndex ) ].
!
createLineEdit
	"The status column echoes the text."
	lineEdit := QLineEdit new.
	lineEdit setPlaceholderText: 'Type here'.
	lineEdit setClearButtonEnabled: true.
	lineEdit onTextChange: [
		lineEditStatus setText: ( lineEdit text isEmpty ifTrue: [ 'Empty' ] ifFalse: [ 'Text: ', lineEdit text ] ) ].
	^ lineEdit.
!
createProgressBarRow
	"The 'Step' button adds 25 to the progress, back to 0 after 100."
	progressBar := QProgressBar new.
	progressBar setValue: 0.
	progressBar onValueChange: [ progressBarStatus setText: 'Value: ', progressBar value toString ].

	stepButton := QPushButton new.
	stepButton setText: 'Step'.
	stepButton onClick: [ progressBar setValue: progressBar value + 25 % 125 ].
	^ self createRow: ( Array new add: progressBar; add: stepButton ).
!
createLcdNumberRow
	"The LCD shows the number of clicks on the 'Count' button."
	lcdNumber := QLcdNumber new.
	lcdNumber setDigitCount: 3.
	lcdNumber setSegmentStyle: QLcdNumber flat.
	lcdNumber display: 0.

	countButton := QPushButton new.
	countButton setText: 'Count'.
	countButton onClick: [
		lcdNumber display: lcdNumber intValue + 1.
		lcdNumberStatus setText: 'Count: ', lcdNumber intValue toString ].
	^ self createRow: ( Array new add: lcdNumber; add: countButton ).
!
createDateButton
	"The 'Select date' button pops up the calendar below it.
	 The popup closes when the user clicks a date, or clicks outside it."
	calendar := QCalendar new.
	calendar setWindowFlag: QWidget popup on: true.
	calendar setGridVisible: true.
	calendar setVerticalHeaderFormat: QCalendar noVerticalHeader.
	calendar onSelectionChange: [ calendarStatus setText: 'Date: ', calendar selectedDate toString ].
	calendar onClick: [ calendar hide ].
	calendar onActivate: [ calendar hide ].

	dateButton := QPushButton new.
	dateButton setText: 'Select date'.
	dateButton onClick: [ self showCalendar ].
	^ dateButton.
!
showCalendar
	calendar move: ( dateButton mapToGlobal: ( QPoint x: 0 y: dateButton height ) ).
	calendar show.
!

"Accessing (used by tests)"

greetLabel
	^ greetLabel.
!
colors
	^ colors.
!
colorIndex
	^ colorIndex.
!
changeStyleButton
	^ changeStyleButton.
!
styledLabel
	^ styledLabel.
!
checkBox
	^ checkBox.
!
checkBoxStatus
	^ checkBoxStatus.
!
radioButtons
	^ radioButtons.
!
radioButtonStatus
	^ radioButtonStatus.
!
toolButton
	^ toolButton.
!
toolMenuActions
	^ toolMenuActions.
!
toolButtonStatus
	^ toolButtonStatus.
!
groupBox
	^ groupBox.
!
groupBoxStatus
	^ groupBoxStatus.
!
tabWidget
	^ tabWidget.
!
tabWidgetStatus
	^ tabWidgetStatus.
!
stackedWidget
	^ stackedWidget.
!
nextPageButton
	^ nextPageButton.
!
stackedWidgetStatus
	^ stackedWidgetStatus.
!
statusBar
	^ statusBar.
!
exitAction
	^ exitAction.
!
changeStyleShortcut
	^ changeStyleShortcut.
!
optionActions
	^ optionActions.
!
actionStatus
	^ actionStatus.
!
window
	^ window.
!
heart
	^ heart.
!
richLabel
	^ richLabel.
!
frame
	^ frame.
!
shapeButton
	^ shapeButton.
!
frameStatus
	^ frameStatus.
!
lineEdit
	^ lineEdit.
!
lineEditStatus
	^ lineEditStatus.
!
progressBar
	^ progressBar.
!
stepButton
	^ stepButton.
!
progressBarStatus
	^ progressBarStatus.
!
lcdNumber
	^ lcdNumber.
!
countButton
	^ countButton.
!
lcdNumberStatus
	^ lcdNumberStatus.
!
dateButton
	^ dateButton.
!
calendar
	^ calendar.
!
calendarStatus
	^ calendarStatus.
!
labelStatus
	^ labelStatus.
!
