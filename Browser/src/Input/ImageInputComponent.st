CLASS ImageInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'imageInput outputLabel'

htmlPath
	^ 'Components/Input/ImageInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	imageInput := Document getElementById: 'imageInput' class: HtmlInputElement.
	outputLabel := Document getElementById: 'imageInputOutputLabel' class: HtmlLabelElement.

	imageInput onClick: [ outputLabel textContent: 'Image clicked' ].
!

"Accessing"

imageInput
	^ imageInput.
!
outputLabel
	^ outputLabel.
!
