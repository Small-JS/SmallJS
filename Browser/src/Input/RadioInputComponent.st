CLASS RadioInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'radioInput1 radioInput2 outputLabel'

htmlPath
	^ 'Components/Input/RadioInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	radioInput1 := Document getElementById: 'radioInput1' class: HtmlInputElement.
	radioInput2 := Document getElementById: 'radioInput2' class: HtmlInputElement.
	outputLabel := Document getElementById: 'radioInputOutputLabel' class: HtmlLabelElement.

	radioInput1 onClick: [ outputLabel textContent: 'Radio 1' ].
	radioInput2 onClick: [ outputLabel textContent: 'Radio 2' ].
!

"Accessing"

radioInput1
	^ radioInput1.
!
radioInput2
	^ radioInput2.
!
outputLabel
	^ outputLabel.
!
