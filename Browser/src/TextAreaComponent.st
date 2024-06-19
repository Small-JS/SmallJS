CLASS TextAreaComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'textArea outputButton outputSpan'

htmlPath
	^ 'Components/TextAreaComponent.html'.
!
start
	self bindElements.
!
bindElements
	textArea := Document getElementById: 'textArea' class: HtmlTextAreaElement.
	outputButton := Document getElementById: 'textAreaOutputButton' class: HtmlButtonElement.
	outputSpan := Document getElementById: 'textAreaOutputSpan' class: HtmlSpanElement.

	outputButton onClick: [ self onOutputButtonClicked ].
!
onOutputButtonClicked
	| textAreaString |

	outputSpan textContent: textArea value.
!

"Accessing"

textArea
	^ textArea.
!
outputButton
	^ outputButton.
!
outputSpan
	^ outputSpan.
!

