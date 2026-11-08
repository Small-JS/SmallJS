CLASS TestIntlDurationFormat EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| options format duration parts |
	options := JsObject newEmpty atJsProperty: 'style' put: 'long'.
	format := IntlDurationFormat locales: 'en-US' options: options.
	self assert: [ format class = IntlDurationFormat ].
	duration := JsObject newEmpty
		atJsProperty: 'hours' put: 1;
		atJsProperty: 'minutes' put: 30.
	self assert: [ ( format format: duration ) = '1 hour, 30 minutes' ].

	parts := format formatToParts: duration.
	self assert: [ ( parts first atJsProperty: 'type' ) = 'integer' ].
	self assert: [ ( parts first atJsProperty: 'value' ) = '1' ].
	self assert: [ ( parts first atJsProperty: 'unit' ) = 'hour' ].
!
