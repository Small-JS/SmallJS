CLASS TestIntlPluralRules EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| rules options |
	rules := IntlPluralRules locales: 'en-US'.
	self assert: [ rules class = IntlPluralRules ].
	self assert: [ ( rules select: 1 ) = 'one' ].
	self assert: [ ( rules select: 2 ) = 'other' ].
	self assert: [ ( rules select: 0 ) = 'other' ].
	self assert: [ ( rules selectRange: 1 to: 2 ) = 'other' ].

	options := JsObject newEmpty atJsProperty: 'type' put: 'ordinal'.
	rules := IntlPluralRules locales: 'en-US' options: options.
	self assert: [ ( rules select: 1 ) = 'one' ].
	self assert: [ ( rules select: 2 ) = 'two' ].
	self assert: [ ( rules select: 3 ) = 'few' ].
	self assert: [ ( rules select: 4 ) = 'other' ].
!
