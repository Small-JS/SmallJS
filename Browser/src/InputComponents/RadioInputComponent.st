CLASS RadioInputComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'radioInput1 radioInput2 outputParagraph'

htmlPath
	^ 'InputComponents/RadioInputComponent.html'.
!
start
	self bindElements.
!
bindElements
	radioInput1 := Document getElementById: 'radioInput1' class: HtmlInputElement.
	radioInput2 := Document getElementById: 'radioInput2' class: HtmlInputElement.
	outputParagraph := Document getElementById: 'radioInputOutputParagraph' class: HtmlParagraphElement.

	radioInput1 onClick: [ outputParagraph textContent: 'Radio 1' ].
	radioInput2 onClick: [ outputParagraph textContent: 'Radio 2' ].
!

"Accessing"

radioInput1
	^ radioInput1.
!
radioInput2
	^ radioInput2.
!
outputParagraph
	^ outputParagraph.
!
