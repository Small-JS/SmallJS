CLASS TestIntlDisplayNames EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| options names |
	options := JsObject newEmpty atJsProperty: 'type' put: 'region'.
	names := IntlDisplayNames locales: 'en-US' options: options.
	self assert: [ names class = IntlDisplayNames ].
	self assert: [ ( names of: 'NL' ) = 'Netherlands' ].

	options := JsObject newEmpty atJsProperty: 'type' put: 'language'.
	names := IntlDisplayNames locales: 'en-US' options: options.
	self assert: [ ( names of: 'nl' ) = 'Dutch' ].
	names := IntlDisplayNames locales: 'nl-NL' options: options.
	self assert: [ ( names of: 'nl' ) = 'Nederlands' ].

	options := JsObject newEmpty
		atJsProperty: 'type' put: 'currency';
		atJsProperty: 'fallback' put: 'none'.
	names := IntlDisplayNames locales: 'en-US' options: options.
	self assert: [ ( names of: 'EUR' ) = 'Euro' ].
	self assert: [ ( names of: 'XYZ' ) isNil ].
!
testMissingType
	| result |
	result := [ IntlDisplayNames locales: 'en-US' ] tryCatch: [ :error | error ].
	self assert: [ result class = Error ].
	self assert: [ result name = 'TypeError' ].
!
