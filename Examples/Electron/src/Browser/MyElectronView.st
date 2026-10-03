CLASS MyElectronView EXTENDS ElectronView MODULE MyElectronRenderer CLASSVARS ''
	VARS 'colorTextButton colorTextResultSpan
		setTitleButton setTitleResultSpan
		pingButton pingResultSpan
		windowEventSpan windowEventCount'

start
	self log: 'MyView: Start'.
	self bindElements.
	self listenForWindowEvents.
!
listenForWindowEvents
	"The main process sends the window events it receives, e.g. 'resize' or 'focus'."
	windowEventCount := 0.
	self callApi: 'myApi' method: 'onWindowEvent'
		withCallback: [ :name | self onWindowEvent: ( String fromJs: name ) ].
!
onWindowEvent: name
	windowEventCount := windowEventCount + 1.
	windowEventSpan textContent: name, ' (', windowEventCount toString, ')'.
!
bindElements
	colorTextButton := Document getElementById: 'colorTextButton' class: HtmlButtonElement.
	colorTextButton onClick: [ self colorText ].
	colorTextResultSpan := Document getElementById: 'colorTextResultSpan' class: HtmlSpanElement.

	setTitleButton := Document getElementById: 'setTitleButton' class: HtmlButtonElement.
	setTitleButton onClick: [ self setTitle ].
	setTitleResultSpan := Document getElementById: 'setTitleResultSpan' class: HtmlSpanElement.

	pingButton := Document getElementById: 'pingButton' class: HtmlButtonElement.
	pingButton onClick: [ self ping ].
	pingResultSpan := Document getElementById: 'pingResultSpan' class: HtmlSpanElement.

	windowEventSpan := Document getElementById: 'windowEventSpan' class: HtmlSpanElement.
!
colorText
	self log: 'MyElectronView: Color text button clicked.'.
	colorTextResultSpan style setProperty: 'background' value: 'lightgreen'.
	colorTextResultSpan textContent: 'Colored text'.
!
setTitle
	| title |
	self log: 'MyElectronView: Modify title button clicked.'.
	title := 'Hello Electron! (modified title)'.
	self callApi: 'myApi' method: 'setTitle' with: title.
	setTitleResultSpan textContent: 'Title modified'.
!
async ping
	| data result |
 	self log: 'MyElectronView: Ping button clicked.'.
	data := 'Ping'.
	result := await self callApi: 'myApi' method: 'ping' with: data.
	self onPing: result.
!
onPing: result
	self log: 'MyElectronView: Received result from API: ', result.
	pingResultSpan textContent: result.
!
quit
	self log: 'MyElectronView: Requesting app to quit.'.
	self callApi: 'myApi' method: 'quit'.
!

"Accessing - Used by tests"

colorTextButton
	^ colorTextButton.
!
colorTextResultSpan
	^ colorTextResultSpan.
!
setTitleButton
	^ setTitleButton.
!
setTitleResultSpan
	^ setTitleResultSpan.
!
pingButton
	^ pingButton.
!
pingResultSpan
	^ pingResultSpan.
!
windowEventSpan
	^ windowEventSpan.
!
