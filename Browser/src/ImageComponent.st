CLASS ImageComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'imageElement'

htmlPath
	^ 'Components/ImageComponent.html'.
!
start
	self bindElements.
!
bindElements
	imageElement := Document getElementById: 'image' class: HtmlImageElement.
!

"Accessing"

imageElement
	^ imageElement.
!
