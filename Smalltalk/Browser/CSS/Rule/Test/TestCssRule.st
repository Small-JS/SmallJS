CLASS TestCssRule EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: This class tests all the CssRule* classes."

testCssRule
	| cssStyleSheet ruleText cssRule |

	cssStyleSheet := CssStyleSheet new.
	cssStyleSheet replace: '.italicBold { font-style: italic; font-weight: bold; }'.
	cssRule := cssStyleSheet cssRules first.

	self assert: [ cssRule cssText = '.italicBold { font-style: italic; font-weight: bold; }' ].
	self assert: [ cssRule parentRule = nil ].
	self assert: [ cssRule parentStyleSheet = cssStyleSheet ].
!
