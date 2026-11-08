CLASS TestIntlNumberFormat EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| format options parts |
	format := IntlNumberFormat locales: 'en-US'.
	self assert: [ format class = IntlNumberFormat ].
	self assert: [ ( format format: 1234.5 ) = '1,234.5' ].
	self assert: [ ( ( IntlNumberFormat locales: 'nl-NL' ) format: 1234.5 ) = '1.234,5' ].

	parts := format formatToParts: 1234.5.
	self assert: [ ( parts first atJsProperty: 'type' ) = 'integer' ].
	self assert: [ ( parts first atJsProperty: 'value' ) = '1' ].
	self assert: [ ( parts last atJsProperty: 'type' ) = 'fraction' ].

	options := JsObject newEmpty
		atJsProperty: 'style' put: 'currency';
		atJsProperty: 'currency' put: 'EUR'.
	format := IntlNumberFormat locales: 'en-US' options: options.
	self assert: [ ( format format: 1234.5 ) = '€1,234.50' ].
	self assert: [ ( format resolvedOptions atJsProperty: 'currency' ) = 'EUR' ].
!
testRange
	| format parts |
	format := IntlNumberFormat locales: 'en-US'.
	self assert: [ ( format formatRange: 3 to: 5 ) = '3–5' ].
	parts := format formatRangeToParts: 3 to: 5.
	self assert: [ ( parts first atJsProperty: 'source' ) = 'startRange' ].
	self assert: [ ( parts last atJsProperty: 'source' ) = 'endRange' ].
!
