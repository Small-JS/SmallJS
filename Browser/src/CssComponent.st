CLASS CssComponent EXTENDS Component MODULE BrowserApp CLASSVARS ''
	VARS 'applyButton removeButton resultLabel'

htmlPath
	^ 'Components/CssComponent.html'.
!
start
	self bindElements.
!
bindElements
	| cssStyleSheet index |

	applyButton := Document getElementById: 'cssApplyButton' class: HtmlButtonElement.
	applyButton onClick: [ self onApply ].

	removeButton := Document getElementById: 'cssRemoveButton' class: HtmlButtonElement.
	removeButton onClick: [ self onRemove ].

	resultLabel := Document getElementById: 'cssResultLabel' class: HtmlLabelElement.

	"Check for existence of italicBold style class."
	cssStyleSheet := Document default styleSheets first.
	self assert: [ cssStyleSheet class = CssStyleSheet ].
	index := cssStyleSheet findStyleRuleIndex: '.italicBold'.
	self assert: [ index >= 0 ].
!
onApply
	resultLabel classList add: 'italicBold'.
!
onRemove
	resultLabel classList remove: 'italicBold'.
!

"Accessing"

applyButton
	^ applyButton.
!
removeButton
	^ removeButton.
!
resultLabel
	^ resultLabel.
!
