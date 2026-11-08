CLASS IntlPluralRules EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.PluralRules.
	 It selects the plural category of numbers in a language."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.PluralRules'.
!

METHODS

select: number
	"Return the plural category of number: 'zero', 'one', 'two', 'few', 'many' or 'other'."
	^ String fromJs: INLINE 'this.js.select( number.js )'.
!
selectRange: start to: end
	^ String fromJs: INLINE 'this.js.selectRange( start.js, end.js )'.
!
