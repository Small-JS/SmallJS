CLASS SelectionComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'input outputButton outputLabel'

htmlPath
	^ 'Components/SelectionComponent.html'.
!
start
	self bindElements.
!
bindElements
	input := Document getElementById: 'selectionInput' class: HtmlInputElement.
	outputButton := Document getElementById: 'selectionOutputButton' class: HtmlButtonElement.
	outputLabel := Document getElementById: 'selectionOutputLabel' class: HtmlLabelElement.

	outputButton onClick: [ self onOutputButtonClicked ].
!
onOutputButtonClicked
	| selectionString |

	"2024-06-16: FireFox fails to get selected text through the global document.getSelection() call.
	 This is the official bug report: https://bugzilla.mozilla.org/show_bug.cgi?id=85686
	 The workaround is to extract the selection through selectionStart and selectionEnd
	 of the specific input field."

	selectionString := Window isFirefox
		ifTrue: [ input value substring: input selectionStart to: input selectionEnd ]
		ifFalse: [ Selection new toString ].

	outputLabel textContent: selectionString.
!

"Accessing"

input
	^ input.
!
outputButton
	^ outputButton.
!
outputLabel
	^ outputLabel.
!

