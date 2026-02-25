CLASS AnchorComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'anchorElement'

htmlPath
	^ 'Components/AnchorComponent.html'.
!
start
	self bindElements.
!
bindElements
	anchorElement := Document getElementById: 'anchor' class: HtmlAnchorElement.
!

"Accessing"

anchorElement
	^ anchorElement.
!
