CLASS InputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'input outputButton outputLabel'

htmlPath
	^ 'Components/Input/InputComponent.html'.
!
start
	self bindElements.
!
bindElements
	input := Document getElementById: 'input' class: HtmlInputElement.
	outputButton := Document getElementById: 'inputOutputButton' class: HtmlButtonElement.
	outputLabel := Document getElementById: 'inputOutputLabel' class: HtmlLabelElement.

	outputButton onClick: [ outputLabel textContent: input value ].
!

"Accessing"

input
	^ input.
!
outputButton
	^ outputButton.
!
outputLabel
	^ outputLabel.
!
