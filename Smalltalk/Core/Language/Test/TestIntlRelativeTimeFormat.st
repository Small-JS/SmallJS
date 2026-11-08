CLASS TestIntlRelativeTimeFormat EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| format options parts |
	format := IntlRelativeTimeFormat locales: 'en-US'.
	self assert: [ format class = IntlRelativeTimeFormat ].
	self assert: [ ( format format: -1 unit: 'day' ) = '1 day ago' ].
	self assert: [ ( format format: 2 unit: 'hour' ) = 'in 2 hours' ].

	parts := format formatToParts: 2 unit: 'day'.
	self assert: [ ( parts first atJsProperty: 'value' ) = 'in ' ].
	self assert: [ ( ( parts at: 1 ) atJsProperty: 'type' ) = 'integer' ].
	self assert: [ ( ( parts at: 1 ) atJsProperty: 'unit' ) = 'day' ].

	options := JsObject newEmpty atJsProperty: 'numeric' put: 'auto'.
	format := IntlRelativeTimeFormat locales: 'en-US' options: options.
	self assert: [ ( format format: -1 unit: 'day' ) = 'yesterday' ].
!
