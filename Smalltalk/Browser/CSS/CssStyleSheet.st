CLASS CssStyleSheet EXTENDS StyleSheet MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new CSSStyleSheet()'.
!

METHODS

"Properties"

cssRules
	^ Array fromJs: INLINE 'this.js.cssRules' elementConverter:
		[ :jsCssRule | CssRule fromJsSubRule: jsCssRule ].
!
ownerRule
	^ CssRule fromJsSubRule: INLINE 'this.js.ownerRule'.
!

"Searching"

findStyleRule: selectorText
	^ self cssRules find: [ :cssRule | cssRule class = CssStyleRule and: [ cssRule selectorText = selectorText ] ].
!
findStyleRuleIndex: selectorText
	^ self cssRules findIndex: [ :cssRule | cssRule class = CssStyleRule and: [ cssRule selectorText = selectorText ] ].
!

"Changing"

deleteRule: index
	INLINE 'this.js.deleteRule( index.js )'.
!
insertRule: rule index: index
	"Return the index of the inserted rule."
	^ Integer fromJs: INLINE 'this.js.insertRule( rule.js, index.js )'.
!
replaceSync: text
	"Replace all rules with the rules in text. Note: @import rules are ignored."
	INLINE 'this.js.replaceSync( text.js )'.
!
