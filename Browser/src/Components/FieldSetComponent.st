CLASS FieldSetComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'fieldSetElement'

htmlPath
	^ 'Components/FieldSetComponent.html'.
!
start
	self bindElements.
!
bindElements
	fieldSetElement := Document getElementById: 'fieldSet' class: HtmlFieldSetElement.
!

"Accessing"

fieldSetElement
	^ fieldSetElement.
!
