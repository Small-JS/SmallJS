CLASS TestIntlListFormat EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| format options parts |
	format := IntlListFormat locales: 'en-US'.
	self assert: [ format class = IntlListFormat ].
	self assert: [ ( format format: #( 'a' 'b' 'c' ) ) = 'a, b, and c' ].
	self assert: [ ( format format: #( 'a' 'b' ) ) = 'a and b' ].

	parts := format formatToParts: #( 'a' 'b' 'c' ).
	self assert: [ parts length = 5 ].
	self assert: [ ( parts first atJsProperty: 'type' ) = 'element' ].
	self assert: [ ( ( parts at: 1 ) atJsProperty: 'type' ) = 'literal' ].

	options := JsObject newEmpty atJsProperty: 'type' put: 'disjunction'.
	format := IntlListFormat locales: 'en-US' options: options.
	self assert: [ ( format format: #( 'a' 'b' 'c' ) ) = 'a, b, or c' ].

	format := IntlListFormat locales: 'nl-NL'.
	self assert: [ ( format format: #( 'a' 'b' 'c' ) ) = 'a, b en c' ].
!
