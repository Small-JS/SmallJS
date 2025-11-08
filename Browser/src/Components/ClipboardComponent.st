CLASS ClipboardComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'clipboardInput clipboardWriteButton clipboardReadButton clipboardResultParagraph'

htmlPath
	^ 'Components/ClipboardComponent.html'.
!
start
	self bindElements.
!
bindElements
	clipboardInput := Document getElementById: 'clipboardInput' class: HtmlInputElement.

	clipboardReadButton := Document getElementById: 'clipboardReadButton' class: HtmlButtonElement.
	clipboardReadButton onClick: [ self onClipboardReadButton ].

	clipboardWriteButton := Document getElementById: 'clipboardWriteButton' class: HtmlButtonElement.
	clipboardWriteButton onClick: [ self onClipboardWriteButton ].

	clipboardResultParagraph := Document getElementById: 'clipboardResultParagraph' class: HtmlParagraphElement.
!
async onClipboardReadButton
	| text |
	"Note: This function cannot be GUI tested automatically
		because it may require user permission first."
	text := await Clipboard default readText.
	clipboardResultParagraph textContent: text.
!
async onClipboardWriteButton
	"Note: This function cannot be GUI tested automatically
		because it may require user permission first."
	await Clipboard default writeText: clipboardInput value.
	clipboardResultParagraph textContent: '[written]'.
!
