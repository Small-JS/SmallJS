CLASS MyElectronView EXTENDS ElectronView MODULE MyElectronRenderer CLASSVARS ''
	VARS 'colorTextButton colorTextResultSpan
		setTitleButton setTitleResultSpan
		pingButton pingResultSpan'

start
	self log: 'MyView: Start'.
	self bindElements.
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
ping
	| data |
 	self log: 'MyElectronView: Ping button clicked.'.
	data := 'Ping'.
	self callApi: 'myApi' method: 'ping' with: data
		then: [ :result | self onPing: result ].
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
