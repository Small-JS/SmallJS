CLASS MyComponent EXTENDS Component MODULE TestDom CLASSVARS ''
	VARS 'label button'

htmlPath
	^ 'Test/MyComponent.html'.
!
start
	self bindElements.
!
bindElements
	label := Document getElementById: 'myComponentLabel'.
	self assert: [ label class = HtmlLabelElement ].

	button := Document getElementById: 'myComponentButton'.
	self assert: [ button class = HtmlButtonElement ].
	button onClick: [ :event | self buttonClicked ].
!
buttonClicked
	| resultLabel |

	resultLabel := Document getElementById: 'componentResultLabel'.
	self assert: [ resultLabel class = HtmlLabelElement ].
	resultLabel textContent: 'Component clicked.'.
!

"Accessing"

label
	^ label.
!
button
	^ button.
!
