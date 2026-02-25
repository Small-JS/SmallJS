CLASS TextAreaComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'textArea outputButton outputParagraph'

htmlPath
	^ 'Components/TextAreaComponent.html'.
!
start
	self bindElements.
!
bindElements
	textArea := Document getElementById: 'textArea' class: HtmlTextAreaElement.
	outputButton := Document getElementById: 'textAreaOutputButton' class: HtmlButtonElement.
	outputParagraph := Document getElementById: 'textAreaOutputParagraph' class: HtmlParagraphElement.

	outputButton onClick: [ self onOutputButtonClicked ].
!
onOutputButtonClicked
	| textAreaString |

	outputParagraph textContent: textArea value.
!

"Accessing"

textArea
	^ textArea.
!
outputButton
	^ outputButton.
!
outputParagraph
	^ outputParagraph.
!

