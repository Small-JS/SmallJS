CLASS MyComponent EXTENDS Component MODULE TestDom CLASSVARS ''
	VARS 'label button'

htmlPath
	^ 'Test/MyComponent.html'.
!
start
	self bindElements.
!
bindElements
	label := Document getElementById: 'myComponentLabel' class: HtmlLabelElement.

	button := Document getElementById: 'myComponentButton' class: HtmlButtonElement.
	button onClick: [ :event | self buttonClicked ].
!
buttonClicked
	| resultLabel |

	resultLabel := Document getElementById: 'componentResultLabel' class: HtmlLabelElement.
	resultLabel textContent: 'Component clicked.'.
!

"Accessing"

label
	^ label.
!
button
	^ button.
!
