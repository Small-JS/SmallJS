CLASS MyNodeGuiApp EXTENDS QApplication MODULE MyNodeGuiApp CLASSVARS ''
	VARS 'window greetLabel colors colorIndex
		changeStyleButton styledLabel checkBox checkBoxStatus
		radioButtons buttonGroup radioButtonStatus toolButton toolMenuActions toolButtonStatus
		groupBox groupBoxStatus tabWidget tabNames tabWidgetStatus
		stackedWidget nextPageButton stackedWidgetStatus
		statusBar exitAction changeStyleShortcut optionsButton optionActions actionStatus'

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
	layout addWidget: self createTable stretch: 0 align: QLayout alignCenter.
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

	widget := QWidget new.
	widget setObjectName: 'table'.
	widget setLayout: layout.
	^ widget.
!
addRow: row to: layout type: typeName widget: widget status: statusLabel
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
