CLASS TestIntlObject EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

testAbstract
	| result |
	result := [ IntlObject new ] tryCatch: [ :error | error ].
	self assert: [ result class = Error ].
!
testNew
	"The default locale depends on the system, so only test that it is set."
	| format |
	format := IntlNumberFormat new.
	self assert: [ format class = IntlNumberFormat ].
	self assert: [ ( format resolvedOptions atJsProperty: 'locale' ) isEmpty not ].
!
testSupportedLocalesOf
	self assert: [ ( IntlNumberFormat supportedLocalesOf: 'en-US' ) = #( 'en-US' ) ].
	self assert: [ ( IntlCollator supportedLocalesOf: #( 'nl-NL' 'en-US' ) ) = #( 'nl-NL' 'en-US' ) ].
!
testInvalidLocale
	| result |
	result := [ IntlNumberFormat locales: 'invalid_locale' ] tryCatch: [ :error | error ].
	self assert: [ result class = Error ].
	self assert: [ result name = 'RangeError' ].
!
