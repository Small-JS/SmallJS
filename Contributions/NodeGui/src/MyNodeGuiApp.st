CLASS MyNodeGuiApp EXTENDS QApplication MODULE MyNodeGuiApp CLASSVARS ''
	VARS 'window greetLabel changeStyleButton colors colorIndex
		statusLabel checkBox radioButtons buttonGroup toolButton toolMenuActions'

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
	window setStyleSheet: self createStyleSheet.
	window setCentralWidget: self createCentralWidget.
	window show.
!
createIcon
	^ QIcon new: 'assets/logo.ico'.
!
createMenuBar
	| action menu menuBar |

	action := QAction new.
	action setText: 'Exit'.
	action addEventListener: 'triggered' then: [ self onFileExit ].

	menu := QMenu new.
	menu setTitle: 'File'.
	menu addAction: action.

	menuBar := QMenuBar new.
	menuBar addMenu: menu.
	^ menuBar.
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
	layout addWidget: self createImageLabel stretch: 0 align: QLayout alignCenter.
	layout addWidget: self createGreetLabel stretch: 0 align: QLayout alignCenter.
	layout addWidget: self createChangeStyleButton stretch: 0 align: QLayout alignCenter.
	layout addWidget: self createButtonsWidget stretch: 0 align: QLayout alignCenter.
	layout addWidget: self createStatusLabel stretch: 0 align: QLayout alignCenter.
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
createChangeStyleButton
	| button |
	button := QPushButton new.
	button setObjectName: 'changeStyleButton'.
	button setText: 'Change style'.
	button onClick: [ self changeStyle ].
	changeStyleButton := button.
	^ button.
!
changeStyle
	colorIndex := colorIndex + 1 % colors length.
	greetLabel setInlineStyle: 'color: ', ( colors at: colorIndex ).
!

"Buttons, for manually testing the button classes.
 The status label shows the last button event."

createButtonsWidget
	"Arrange the buttons vertically, grouped by type."
	| widget layout |
	layout := QBoxLayout new: QLayout topToBottom.
	layout addWidget: ( self createGroup: 'Check box' widgets: ( Array new add: self createCheckBox ) )
		stretch: 0 align: QLayout alignLeft.
	layout addWidget: ( self createGroup: 'Radio buttons' widgets: ( Array new add: ( self createRow: self createRadioButtons ) ) )
		stretch: 0 align: QLayout alignLeft.
	layout addWidget: ( self createGroup: 'Tool button' widgets: ( Array new add: self createToolButton ) )
		stretch: 0 align: QLayout alignLeft.

	widget := QWidget new.
	widget setObjectName: 'buttons'.
	widget setLayout: layout.
	^ widget.
!
createGroup: title widgets: widgets
	"Answer a widget with a title label above widgets."
	| titleLabel layout group |
	titleLabel := QLabel new.
	titleLabel setObjectName: 'groupTitle'.
	titleLabel setText: title.

	layout := QBoxLayout new: QLayout topToBottom.
	layout addWidget: titleLabel stretch: 0 align: QLayout alignLeft.
	widgets do: [ :widget |
		layout addWidget: widget stretch: 0 align: QLayout alignLeft ].

	group := QWidget new.
	group setLayout: layout.
	^ group.
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
createCheckBox
	checkBox := QCheckBox new.
	checkBox setText: 'Tristate'.
	checkBox setTristate: true.
	checkBox onStateChange: [ self showStatus: 'Check box: ', self checkStateName ].
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
		self showStatus: 'Radio button: ', ( buttonGroup button: id ) text ].
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
	toolButton onClick: [ self showStatus: 'Tool button clicked' ].
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
	self showStatus: 'Tool menu: ', text.
!
createStatusLabel
	statusLabel := QLabel new.
	statusLabel setObjectName: 'statusLabel'.
	statusLabel setText: 'Click a button.'.
	^ statusLabel.
!
showStatus: text
	statusLabel setText: text.
!

"Accessing (used by tests)"

greetLabel
	^ greetLabel.
!
changeStyleButton
	^ changeStyleButton.
!
colors
	^ colors.
!
colorIndex
	^ colorIndex.
!
statusLabel
	^ statusLabel.
!
checkBox
	^ checkBox.
!
radioButtons
	^ radioButtons.
!
toolButton
	^ toolButton.
!
toolMenuActions
	^ toolMenuActions.
!
