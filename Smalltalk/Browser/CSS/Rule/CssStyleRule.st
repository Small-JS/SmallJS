CLASS CssStyleRule EXTENDS CssRule MODULE DOM CLASSVARS '' VARS ''

selectorText
	^ String fromJs: INLINE 'this.js.selectorText'.
!
style
	^ CssStyleDeclaration fromJs: INLINE 'this.js.style'.
!
