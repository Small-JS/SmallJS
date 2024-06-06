CLASS EmbedComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'embedElement'

htmlPath
	^ 'Components/EmbedComponent.html'.
!
start
	self bindElements.
!
bindElements
	embedElement := Document getElementById: 'embed' class: HtmlEmbedElement.
!

"Accessing"

embedElement
	^ embedElement.
!
