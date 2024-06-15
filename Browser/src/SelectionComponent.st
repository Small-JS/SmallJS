CLASS SelectionComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'input outputButton outputLabel'

htmlPath
	^ 'Components/SelectionComponent.html'.
!
start
	self bindElements.
!
bindElements
	input := Document getElementById: 'selectionInput' class: HtmlInputElement.
	outputButton := Document getElementById: 'selectionOutputButton' class: HtmlButtonElement.
	outputLabel := Document getElementById: 'selectionOutputLabel' class: HtmlLabelElement.

	outputButton onClick: [
		outputLabel textContent: Selection new toString ].
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

