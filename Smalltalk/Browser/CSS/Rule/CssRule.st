CLASS CssRule EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class: CSSRule,
	 of which variable value contains an instance."

CLASSMETHODS

fromJsSubRule: jsCssRule
	"Create ST CssRule or subclass object from the argument JS CSSRule object.
	 Default to CssRule, because not all CssRule subclasses are implemented yet."

	| jsClassName |

	INLINE 'if( jsCssRule == null ) return stNil'.

	jsClassName := String fromJs: INLINE 'jsCssRule.constructor.name'.

	jsClassName = 'CSSStyleRule' ifTrue: [ ^ CssStyleRule fromJs: jsCssRule ].
	jsClassName = 'CSSImportRule' ifTrue: [ ^ CssImportRule fromJs: jsCssRule ].

	^ CssRule fromJs: jsCssRule.
!

METHODS

cssText
	^ String fromJs: INLINE 'this.js.cssText'.
!
parentRule
	^ CssRule fromJsSubRule: INLINE 'this.js.parentRule'.
!
parentStyleSheet
	^ StyleSheet fromJs: INLINE 'this.js.parentStyleSheet'.
!
