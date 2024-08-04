CLASS CanvasComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'canvasElement'

htmlPath
	^ 'Components/CanvasComponent.html'.
!
start
	self bindElements.
!
bindElements
	canvasElement := Document getElementById: 'canvas' class: HtmlCanvasElement.
!

"Accessing"

canvasElement
	^ canvasElement.
!
