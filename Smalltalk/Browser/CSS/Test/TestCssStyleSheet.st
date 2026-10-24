CLASS TestCssStyleSheet EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| cssStyleSheet index |

	cssStyleSheet := CssStyleSheet new.
	self assert: [ cssStyleSheet class = CssStyleSheet ].
	self assert: [ cssStyleSheet ownerRule isNil ].
	self assert: [ cssStyleSheet cssRules length = 0 ].

	index := cssStyleSheet insertRule: '.italicBold { font-style: italic; font-weight: bold; }' index: 0.
	self assert: [ index = 0 ].
	index := cssStyleSheet insertRule: '.underline { text-decoration: underline; }' index: 1.
	self assert: [ index = 1 ].
	self assert: [ cssStyleSheet cssRules length = 2 ].

	self assert: [ ( cssStyleSheet findStyleRuleIndex: '.italicBold' ) = 0 ].
	self assert: [ ( cssStyleSheet findStyleRuleIndex: '.underline' ) = 1 ].
	self assert: [ ( cssStyleSheet findStyleRuleIndex: '.missing' ) = -1 ].
	self assert: [ ( cssStyleSheet findStyleRule: '.underline' ) selectorText = '.underline' ].
	self assert: [ ( cssStyleSheet findStyleRule: '.missing' ) isNil ].

	cssStyleSheet deleteRule: 0.
	self assert: [ cssStyleSheet cssRules length = 1 ].
	self assert: [ ( cssStyleSheet findStyleRuleIndex: '.underline' ) = 0 ].

	cssStyleSheet replaceSync: '.a { color: red; } .b { color: blue; }'.
	self assert: [ cssStyleSheet cssRules length = 2 ].
	self assert: [ ( cssStyleSheet findStyleRuleIndex: '.b' ) = 1 ].
!
