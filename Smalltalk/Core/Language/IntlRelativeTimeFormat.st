CLASS IntlRelativeTimeFormat EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.RelativeTimeFormat.
	 It formats relative times in a language, like: '1 day ago'."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.RelativeTimeFormat'.
!

METHODS

format: value unit: unit
	"Unit is one of: 'year', 'quarter', 'month', 'week', 'day', 'hour', 'minute', 'second'.
	 A negative value is in the past."
	^ String fromJs: INLINE 'this.js.format( value.js, unit.js )'.
!
formatToParts: value unit: unit
	"Return an Array of JsObjects with the properties 'type' and 'value', and 'unit' for numbers."
	^ Array fromJs: INLINE 'this.js.formatToParts( value.js, unit.js )' elementClass: JsObject.
!
