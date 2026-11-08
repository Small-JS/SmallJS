CLASS IntlNumberFormat EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.NumberFormat.
	 It formats numbers, currencies and units in a language."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.NumberFormat'.
!

METHODS

format: number
	^ String fromJs: INLINE 'this.js.format( number.js )'.
!
formatToParts: number
	"Return an Array of JsObjects with the properties 'type' and 'value'."
	^ Array fromJs: INLINE 'this.js.formatToParts( number.js )' elementClass: JsObject.
!
formatRange: start to: end
	^ String fromJs: INLINE 'this.js.formatRange( start.js, end.js )'.
!
formatRangeToParts: start to: end
	"Return an Array of JsObjects with the properties 'type', 'value' and 'source'."
	^ Array fromJs: INLINE 'this.js.formatRangeToParts( start.js, end.js )' elementClass: JsObject.
!
