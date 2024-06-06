CLASS TestCssStyleSheet EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| cssStyleSheet ruleText index |

	cssStyleSheet := CssStyleSheet new.
	self assert: [ cssStyleSheet class = CssStyleSheet ].
	self assert: [ cssStyleSheet ownerRule isNil ].

	ruleText := '.italicBold { font-style: italic; font-weight: bold; }'.
	cssStyleSheet insertRule: ruleText index: index.
	index := cssStyleSheet findStyleRuleIndex: '.italicBold'.
	self assert: [ index >= 0 ].

	cssStyleSheet deleteRule: index.
	self assert: [ cssStyleSheet cssRules length = 0 ].
!
