CLASS IntlDateTimeFormat EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.DateTimeFormat.
	 It formats Dates and times in a language."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.DateTimeFormat'.
!

METHODS

format: date
	^ String fromJs: INLINE 'this.js.format( date.js )'.
!
formatToParts: date
	"Return an Array of JsObjects with the properties 'type' and 'value'."
	^ Array fromJs: INLINE 'this.js.formatToParts( date.js )' elementClass: JsObject.
!
formatRange: startDate to: endDate
	^ String fromJs: INLINE 'this.js.formatRange( startDate.js, endDate.js )'.
!
formatRangeToParts: startDate to: endDate
	"Return an Array of JsObjects with the properties 'type', 'value' and 'source'."
	^ Array fromJs: INLINE 'this.js.formatRangeToParts( startDate.js, endDate.js )' elementClass: JsObject.
!
