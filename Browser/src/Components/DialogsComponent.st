CLASS DialogsComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'alertButton confirmButton promptButton printButton dialogResultParagraph'

"Note: Testing these dialogs can only be done be done manually in the browser."

htmlPath
	^ 'Components/DialogsComponent.html'.
!
start
	self bindElements.
!
bindElements
	alertButton := Document getElementById: 'popupButton' class: HtmlButtonElement.
	alertButton onClick: [ self onPopup ].

	alertButton := Document getElementById: 'alertButton' class: HtmlButtonElement.
	alertButton onClick: [ self onAlert ].

	confirmButton := Document getElementById: 'confirmButton' class: HtmlButtonElement.
	confirmButton onClick: [ self onConfirm ].

	promptButton := Document getElementById: 'promptButton' class: HtmlButtonElement.
	promptButton onClick: [ self onPrompt ].

	printButton := Document getElementById: 'printButton' class: HtmlButtonElement.
	printButton onClick: [ self onPrint ].

	dialogResultParagraph := Document getElementById: 'dialogResultParagraph' class: HtmlParagraphElement.
!
onPopup
	"This requires popups to be enabled in the browser."
	| popup |
	popup := Window default open: '' target: '' features: 'width=400, height=400'.
	popup isNil ifTrue: [ self error: 'Failed to create Window. Enable popups in browser.' ].

	popup document write: '<!DOCTYPE html>\n<html>\n<head>\n<title>SmallJS popop</title>\n</head>\n<body>\n<h1>Hello from SmallJS!</h1>\n</body>\n</html>'.

	popup moveTo: ( 200 @ 100 ).
	popup resizeTo: ( 400 @ 150 ).
!
onAlert
	Window default alert: 'My Alert'.
	dialogResultParagraph textContent: 'Alerted'.
!
onConfirm
	| result |
	result := Window default confirm: 'My Confirm'.
	dialogResultParagraph textContent: result toString.
!
onPrompt
	| result |
	result := Window default prompt: 'My Prompt'.
	dialogResultParagraph textContent: result toString.
!
onPrint
	Window default print.
!
