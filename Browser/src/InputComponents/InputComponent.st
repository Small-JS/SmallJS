CLASS InputComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'input outputButton outputParagraph'

htmlPath
	^ 'InputComponents/InputComponent.html'.
!
start
	self bindElements.
!
bindElements
	input := Document getElementById: 'input' class: HtmlInputElement.
	outputButton := Document getElementById: 'inputOutputButton' class: HtmlButtonElement.
	outputParagraph := Document getElementById: 'inputOutputParagraph' class: HtmlParagraphElement.

	outputButton onClick: [ outputParagraph textContent: input value ].
!

"Accessing"

input
	^ input.
!
outputButton
	^ outputButton.
!
outputParagraph
	^ outputParagraph.
!
