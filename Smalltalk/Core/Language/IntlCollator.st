CLASS IntlCollator EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.Collator.
	 It compares Strings for sorting in a language."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.Collator'.
!

METHODS

compare: string1 with: string2
	"Return a negative Integer if string1 sorts before string2, 0 if they are equal, positive otherwise."
	^ Integer fromJs: INLINE 'this.js.compare( string1.js, string2.js )'.
!
