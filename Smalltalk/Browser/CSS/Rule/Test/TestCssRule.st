CLASS TestCssRule EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

"Note: This class tests all the CssRule* classes."

testCssRule
	| cssStyleSheet cssRule |

	cssStyleSheet := Document default styleSheets first.
	cssRule := cssStyleSheet cssRules first.

	self assert: [ cssRule cssText = '@import url("Test/Import.css");' ].
	self assert: [ cssRule parentRule = nil ].
	self assert: [ cssRule parentStyleSheet = cssStyleSheet ].
!
testCssImportRule
	| cssStyleSheet cssImportRule importStyleSheet |

	cssStyleSheet := Document default styleSheets first.
	cssImportRule := cssStyleSheet cssRules first.

	self assert: [ cssImportRule href = 'Test/Import.css' ].
	self assert: [ cssImportRule media class = MediaList ].

	importStyleSheet := cssImportRule styleSheet.
	self assert: [ importStyleSheet class = CssStyleSheet ].
	self assert: [ importStyleSheet ownerRule = cssImportRule ].
!
testCssStyleRule
	| cssStyleSheet cssStyleRule |

	cssStyleSheet := Document default styleSheets first.
	cssStyleRule := cssStyleSheet findStyleRule: '.italicBold'.

	self assert: [ cssStyleRule class = CssStyleRule ].
	self assert: [ cssStyleRule selectorText = '.italicBold' ].
	self assert: [ cssStyleRule style cssText startsWith: 'font-style' ].
!
