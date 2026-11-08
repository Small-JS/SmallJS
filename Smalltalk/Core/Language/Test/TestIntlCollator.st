CLASS TestIntlCollator EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| collator options |
	collator := IntlCollator locales: 'en-US'.
	self assert: [ collator class = IntlCollator ].
	self assert: [ ( collator compare: 'a' with: 'b' ) < 0 ].
	self assert: [ ( collator compare: 'b' with: 'a' ) > 0 ].
	self assert: [ ( collator compare: 'a' with: 'a' ) = 0 ].
	self assert: [ ( collator compare: 'a' with: 'A' ) ~= 0 ].
	self assert: [ ( collator resolvedOptions atJsProperty: 'locale' ) = 'en-US' ].

	options := JsObject newEmpty
		atJsProperty: 'sensitivity' put: 'base';
		atJsProperty: 'numeric' put: true.
	collator := IntlCollator locales: 'en-US' options: options.
	self assert: [ ( collator compare: 'a' with: 'A' ) = 0 ].
	self assert: [ ( collator compare: '2' with: '10' ) < 0 ].
	self assert: [ collator resolvedOptions atJsProperty: 'numeric' ].
!
