CLASS ClipboardComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'clipboardInput clipboardWriteButton clipboardReadButton clipboardResultLabel'

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

	clipboardResultLabel := Document getElementById: 'clipboardResultLabel' class: HtmlLabelElement.
!
onClipboardReadButton
	"Note: This function cannot be GUI tested automatically
		because it may require user permission first."
	Window default navigator clipboard readTextThen:
		[ :text | clipboardResultLabel textContent: text ].
!
onClipboardWriteButton
	"Note: This function cannot be GUI tested automatically
		because it may require user permission first."
	Window default navigator clipboard writeText: clipboardInput value then:
		[ :text | clipboardResultLabel textContent: '[written]' ].
!
