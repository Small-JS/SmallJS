CLASS ImageInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'imageInput outputParagraph'

htmlPath
	^ 'InputComponents/ImageInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	imageInput := Document getElementById: 'imageInput' class: HtmlInputElement.
	outputParagraph := Document getElementById: 'imageInputOutputParagraph' class: HtmlParagraphElement.

	imageInput onClick: [ outputParagraph textContent: 'Image clicked' ].
!

"Accessing"

imageInput
	^ imageInput.
!
outputParagraph
	^ outputParagraph.
!
