CLASS IntlListFormat EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.ListFormat.
	 It formats lists of Strings in a language, like: 'a, b, and c'."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.ListFormat'.
!

METHODS

format: list
	^ String fromJs: INLINE 'this.js.format( list.$toJs() )'.
!
formatToParts: list
	"Return an Array of JsObjects with the properties 'type' and 'value'."
	^ Array fromJs: INLINE 'this.js.formatToParts( list.$toJs() )' elementClass: JsObject.
!
