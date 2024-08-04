CLASS CheckboxInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'checkboxInput outputParagraph'

htmlPath
	^ 'Components/Input/CheckboxInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	checkboxInput := Document getElementById: 'checkboxInput' class: HtmlInputElement.
	outputParagraph := Document getElementById: 'checkboxInputOutputParagraph' class: HtmlParagraphElement.

	checkboxInput onClick: [ self onCheckboxInputClicked ].
!
onCheckboxInputClicked
	outputParagraph textContent: (
		checkboxInput checked ifTrue: [ 'Checked' ] ifFalse: [ 'Unchecked' ] ).
!

"Accessing"

checkboxInput
	^ checkboxInput.
!
outputParagraph
	^ outputParagraph.
!
