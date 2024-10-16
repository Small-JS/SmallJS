CLASS MyNodeGuiApp EXTENDS QApplication MODULE MyNodeGuiApp CLASSVARS ''
	VARS 'greetLabel changeStyleButton colors colorIndex'

start
	| window |

	colors := #( 'black' 'red' 'green' 'blue' ).
	colorIndex := 0.

	window := self createWindow.
	window show.

	self testMode ifTrue: [
		TestMyNodeGuiApp new test: self ].
!
createWindow
	| window |
	window := QMainWindow new.
	window setWindowTitle: 'Hello NodeGui'.
	window setWindowIcon: self createIcon.
	window setStyleSheet: self createStyleSheet.
	window setMenuBar: self createMenuBar.
	window setCentralWidget: self createCentralWidget.
	^ window.
!
createIcon
	^ QIcon new: 'assets/logo.ico'.
!
createStyleSheet
	^ Fs readFileSync: 'assets/default.css'.
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
