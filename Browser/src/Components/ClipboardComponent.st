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
onClipboardReadButton
	"Note: This function cannot be GUI tested automatically
		because it may require user permission first."
	Window default navigator clipboard readTextThen:
		[ :text | clipboardResultParagraph textContent: text ].
!
onClipboardWriteButton
	"Note: This function cannot be GUI tested automatically
		because it may require user permission first."
	Window default navigator clipboard writeText: clipboardInput value then:
		[ :text | clipboardResultParagraph textContent: '[written]' ].
!
