CLASS CheckboxInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'checkboxInput outputLabel'

htmlPath
	^ 'Components/Input/CheckboxInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	checkboxInput := Document getElementById: 'checkboxInput' class: HtmlInputElement.
	outputLabel := Document getElementById: 'checkboxInputOutputLabel' class: HtmlLabelElement.

	checkboxInput onClick: [ self onCheckboxInputClicked ].
!
onCheckboxInputClicked
	outputLabel textContent: (
		checkboxInput checked ifTrue: [ 'Checked' ] ifFalse: [ 'Unchecked' ] ).
!

"Accessing"

checkboxInput
	^ checkboxInput.
!
outputLabel
	^ outputLabel.
!
