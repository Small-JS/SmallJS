CLASS IframeComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'iframeElement'

htmlPath
	^ 'Components/IframeComponent.html'.
!
start
	self bindElements.
!
bindElements
	iframeElement := Document getElementById: 'iframe' class: HtmlIframeElement.
!

"Accessing"

iframeElement
	^ iframeElement.
!
