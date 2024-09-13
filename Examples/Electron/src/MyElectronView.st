CLASS MyElectronView EXTENDS ElectronView MODULE MyElectronRenderer CLASSVARS ''
	VARS 'colorTextButton colorTextResultSpan
		modifyTitleButton modifyTitleResultSpan
		pingButton pingResultSpan'

start
	self log: 'MyView: Start'.
	self bindElements.

	self testMode ifTrue: [
		TestMyElectronView new test: self ].
!
bindElements
	colorTextButton := Document getElementById: 'colorTextButton' class: HtmlButtonElement.
	colorTextButton onClick: [ self colorText ].
	colorTextResultSpan := Document getElementById: 'colorTextResultSpan' class: HtmlSpanElement.

	modifyTitleButton := Document getElementById: 'modifyTitleButton' class: HtmlButtonElement.
	modifyTitleButton onClick: [ self modifyTitle ].
	modifyTitleResultSpan := Document getElementById: 'modifyTitleResultSpan' class: HtmlSpanElement.

	pingButton := Document getElementById: 'pingButton' class: HtmlButtonElement.
	pingButton onClick: [ self ping ].
	pingResultSpan := Document getElementById: 'pingResultSpan' class: HtmlSpanElement.
!
colorText
	self log: 'MyElectronView: Color text button clicked.'.
	colorTextResultSpan style setProperty: 'background' value: 'lightgreen'.
	colorTextResultSpan textContent: 'Colored text'.
!
modifyTitle
	| title |
	self log: 'MyElectronView: Modify title button clicked.'.
	title := 'Hello Electron! (modified title)'.
	self callApi: 'myApi' method: 'setTitle' with: title.
	modifyTitleResultSpan textContent: 'Title modified'.
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
	| title |
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
modifyTitleButton
	^ modifyTitleButton.
!
modifyTitleResultSpan
	^ modifyTitleResultSpan.
!
pingButton
	^ pingButton.
!
pingResultSpan
	^ pingResultSpan.
!
