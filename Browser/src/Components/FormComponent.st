CLASS FormComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'formElement'

htmlPath
	^ 'Components/FormComponent.html'.
!
start
	self bindElements.
!
bindElements
	formElement := Document getElementById: 'form' class: HtmlFormElement.
!

"Accessing"

formElement
	^ formElement.
!
