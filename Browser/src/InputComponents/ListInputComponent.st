CLASS ListInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'listInput dataList outputParagraph'

htmlPath
	^ 'InputComponents/ListInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	listInput := Document getElementById: 'listInput' class: HtmlInputElement.
	dataList := Document getElementById: 'dataList' class: HtmlDataListElement.
	outputParagraph := Document getElementById: 'listInputOutputParagraph' class: HtmlParagraphElement.

	listInput addEventListener: 'input' then: [
		outputParagraph textContent: listInput value ].
!

"Accessing"

listInput
	^ listInput.
!
dataList
	^ dataList.
!
outputParagraph
	^ outputParagraph.
!
