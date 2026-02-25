CLASS CssComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'applyButton removeButton resultParagraph'

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

	resultParagraph := Document getElementById: 'cssResultParagraph' class: HtmlParagraphElement.

	"Check for existence of italicBold style class."
	cssStyleSheet := Document default styleSheets first.
	self assert: [ cssStyleSheet class = CssStyleSheet ].
	index := cssStyleSheet findStyleRuleIndex: '.italicBold'.
	self assert: [ index >= 0 ].
!
onApply
	resultParagraph classList add: 'italicBold'.
!
onRemove
	resultParagraph classList remove: 'italicBold'.
!

"Accessing"

applyButton
	^ applyButton.
!
removeButton
	^ removeButton.
!
resultParagraph
	^ resultParagraph.
!
