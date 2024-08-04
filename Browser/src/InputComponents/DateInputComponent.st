CLASS DateInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'dateInput outputParagraph'

htmlPath
	^ 'Components/Input/DateInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	dateInput := Document getElementById: 'dateInput' class: HtmlInputElement.
	outputParagraph := Document getElementById: 'dateInputOutputParagraph' class: HtmlParagraphElement.

	dateInput addEventListener: 'change' then: [ self onDateSelected ].
!
onDateSelected
	outputParagraph textContent: dateInput value.
!

"Accessing"

dateInput
	^ dateInput.
!
outputParagraph
	^ outputParagraph.
!
