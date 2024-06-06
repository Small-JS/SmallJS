CLASS ListInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'listInput dataList outputLabel'

htmlPath
	^ 'Components/Input/ListInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	listInput := Document getElementById: 'listInput' class: HtmlInputElement.
	dataList := Document getElementById: 'dataList' class: HtmlDataListElement.
	outputLabel := Document getElementById: 'listInputOutputLabel' class: HtmlLabelElement.

	listInput addEventListener: 'input' then: [
		outputLabel textContent: listInput value ].
!

"Accessing"

listInput
	^ listInput.
!
dataList
	^ dataList.
!
outputLabel
	^ outputLabel.
!
