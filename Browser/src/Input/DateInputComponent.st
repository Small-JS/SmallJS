CLASS DateInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'dateInput outputLabel'

htmlPath
	^ 'Components/Input/DateInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	dateInput := Document getElementById: 'dateInput' class: HtmlInputElement.
	outputLabel := Document getElementById: 'dateInputOutputLabel' class: HtmlLabelElement.

	dateInput addEventListener: 'change' then: [ self onDateSelected ].
!
onDateSelected
	outputLabel textContent: dateInput value.
!

"Accessing"

dateInput
	^ dateInput.
!
outputLabel
	^ outputLabel.
!
