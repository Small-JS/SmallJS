CLASS TestIntlDateTimeFormat EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

date
	^ Date utcYear: 2026 month: 11 day: 8 hours: 12 minutes: 0 seconds: 0.
!
longOptions
	^ JsObject newEmpty
		atJsProperty: 'dateStyle' put: 'long';
		atJsProperty: 'timeZone' put: 'UTC'.
!
test
	| options format parts |
	options := self longOptions.
	format := IntlDateTimeFormat locales: 'en-US' options: options.
	self assert: [ format class = IntlDateTimeFormat ].
	self assert: [ ( format format: self date ) = 'November 8, 2026' ].
	self assert: [ ( format resolvedOptions atJsProperty: 'timeZone' ) = 'UTC' ].

	parts := format formatToParts: self date.
	self assert: [ ( parts first atJsProperty: 'type' ) = 'month' ].
	self assert: [ ( parts first atJsProperty: 'value' ) = 'November' ].

	format := IntlDateTimeFormat locales: 'nl-NL' options: options.
	self assert: [ ( format format: self date ) = '8 november 2026' ].
!
testRange
	| options format endDate range parts |
	options := self longOptions.
	format := IntlDateTimeFormat locales: 'en-US' options: options.
	endDate := Date utcYear: 2026 month: 11 day: 10 hours: 12 minutes: 0 seconds: 0.

	"The separator contains special spaces, so only test the start and the end."
	range := format formatRange: self date to: endDate.
	self assert: [ range startsWith: 'November 8' ].
	self assert: [ range endsWith: '10, 2026' ].

	parts := format formatRangeToParts: self date to: endDate.
	self assert: [ ( parts first atJsProperty: 'source' ) = 'shared' ].
	self assert: [ parts some: [ :part | ( part atJsProperty: 'source' ) = 'endRange' ] ].
!
