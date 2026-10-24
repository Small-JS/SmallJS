CLASS TestCssRule EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: This class tests all the CssRule* classes, and CssStyleDeclaration."

testCssRule
	| cssStyleSheet cssRule |

	cssStyleSheet := CssStyleSheet new.
	cssStyleSheet replaceSync: '.italicBold { font-style: italic; font-weight: bold; }'.
	cssRule := cssStyleSheet cssRules first.

	self assert: [ cssRule cssText = '.italicBold { font-style: italic; font-weight: bold; }' ].
	self assert: [ cssRule parentRule = nil ].
	self assert: [ cssRule parentStyleSheet = cssStyleSheet ].
	self assert: [ cssRule parentStyleSheet class = CssStyleSheet ].
!
testCssStyleRule
	| cssStyleSheet cssRule |

	cssStyleSheet := CssStyleSheet new.
	cssStyleSheet replaceSync: '.italicBold { font-style: italic; font-weight: bold; }'.
	cssRule := cssStyleSheet cssRules first.

	self assert: [ cssRule class = CssStyleRule ].
	self assert: [ cssRule selectorText = '.italicBold' ].
	self assert: [ cssRule style class = CssStyleDeclaration ].
	self assert: [ cssRule style parentRule = cssRule ].
	self assert: [ cssRule style parentRule class = CssStyleRule ].
!
testCssStyleDeclaration
	| cssStyleSheet style |

	cssStyleSheet := CssStyleSheet new.
	cssStyleSheet replaceSync: '.italicBold { font-style: italic; font-weight: bold !important; }'.
	style := cssStyleSheet cssRules first style.

	self assert: [ style length = 2 ].
	self assert: [ ( style item: 0 ) = 'font-style' ].
	self assert: [ ( style getPropertyValue: 'font-style' ) = 'italic' ].
	self assert: [ ( style getPropertyPriority: 'font-style' ) = '' ].
	self assert: [ ( style getPropertyPriority: 'font-weight' ) = 'important' ].

	style setProperty: 'color' value: 'red'.
	self assert: [ style length = 3 ].
	self assert: [ ( style getPropertyValue: 'color' ) = 'red' ].

	self assert: [ ( style removeProperty: 'color' ) = 'red' ].
	self assert: [ style length = 2 ].
	self assert: [ ( style getPropertyValue: 'color' ) = '' ].

	"Setters return the receiver."
	self assert: [ ( style cssText: 'color: blue;' ) = style ].
	self assert: [ style cssText = 'color: blue;' ].
	self assert: [ ( style float: 'left' ) = style ].
	self assert: [ style float = 'left' ].
	self assert: [ style length = 2 ].
!
testCssImportRule
	| htmlDocument cssRule |

	"CssStyleSheet replaceSync: ignores @import rules, so use a style element in a document."
	htmlDocument := Document new.
	INLINE 'let jsStyle = htmlDocument.js.createElement( "style" );
		jsStyle.textContent = "@import url(\"test.css\") screen; .a { color: red; }";
		htmlDocument.js.head.appendChild( jsStyle )'.

	cssRule := htmlDocument styleSheets first cssRules first.
	self assert: [ cssRule class = CssImportRule ].
	self assert: [ cssRule href = 'test.css' ].
	self assert: [ cssRule media mediaText = 'screen' ].
!
