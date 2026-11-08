CLASS IntlDurationFormat EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.DurationFormat.
	 It formats durations in a language.
	 A duration is a JsObject with properties like 'hours' and 'minutes'."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.DurationFormat'.
!

METHODS

format: duration
	^ String fromJs: INLINE 'this.js.format( duration.$toJs() )'.
!
formatToParts: duration
	"Return an Array of JsObjects with the properties 'type' and 'value', and 'unit' for numbers."
	^ Array fromJs: INLINE 'this.js.formatToParts( duration.$toJs() )' elementClass: JsObject.
!
