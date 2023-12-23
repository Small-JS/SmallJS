CLASS TestCssStyleSheet EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| cssStyleSheet index ruleText |

	cssStyleSheet := Document default styleSheets first.
	self assert: [ cssStyleSheet class = CssStyleSheet ].
	self assert: [ cssStyleSheet ownerRule = nil ].

	index := cssStyleSheet findStyleRuleIndex: '.italicBold'.
	self assert: [ index >= 0 ].
	cssStyleSheet deleteRule: index.

	ruleText := '.italicBold { font-style: italic; font-weight: bold; }'.
	cssStyleSheet insertRule: ruleText index: index.
!
testApplyRemove
	| document  |
	document := Document default.
	( document getElementById: 'cssApplyButton' class: HtmlButtonElement ) onClick: [ :event | self onApply ].
	( document getElementById: 'cssRemoveButton' class: HtmlButtonElement ) onClick: [ :event | self onRemove ].
!
onApply
	( Document getElementById: 'cssResultLabel' class: HtmlLabelElement ) classList add: 'italicBold'.
!
onRemove
	( Document getElementById: 'cssResultLabel' class: HtmlLabelElement ) classList remove: 'italicBold'.
!
