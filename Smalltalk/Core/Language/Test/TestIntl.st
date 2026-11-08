CLASS TestIntl EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

METHODS

testNew
	| result |
	result := [ Intl new ] tryCatch: [ :error | error ].
	self assert: [ result class = Error ].
!
testGetCanonicalLocales
	| result |
	self assert: [ ( Intl getCanonicalLocales: 'EN-us' ) = #( 'en-US' ) ].
	self assert: [ ( Intl getCanonicalLocales: #( 'EN-us' 'nl-nl' 'en-US' ) ) = #( 'en-US' 'nl-NL' ) ].
	self assert: [ ( Intl getCanonicalLocales: #() ) isEmpty ].

	result := [ Intl getCanonicalLocales: 'invalid_locale' ] tryCatch: [ :error | error ].
	self assert: [ result class = Error ].
	self assert: [ result name = 'RangeError' ].
!
testSupportedValuesOf
	| currencies result |
	currencies := Intl supportedValuesOf: 'currency'.
	self assert: [ currencies class = Array ].
	self assert: [ currencies includes: 'EUR' ].
	self assert: [ currencies includes: 'USD' ].
	self assert: [ ( Intl supportedValuesOf: 'timeZone' ) includes: 'Europe/Amsterdam' ].
	self assert: [ ( Intl supportedValuesOf: 'unit' ) includes: 'meter' ].
	self assert: [ ( Intl supportedValuesOf: 'calendar' ) includes: 'gregory' ].
	self assert: [ ( Intl supportedValuesOf: 'collation' ) isEmpty not ].
	self assert: [ ( Intl supportedValuesOf: 'numberingSystem' ) includes: 'latn' ].

	result := [ Intl supportedValuesOf: 'invalidKey' ] tryCatch: [ :error | error ].
	self assert: [ result class = Error ].
	self assert: [ result name = 'RangeError' ].
!
testConstructors
	self assert: [ Intl collator = IntlCollator ].
	self assert: [ Intl dateTimeFormat = IntlDateTimeFormat ].
	self assert: [ Intl displayNames = IntlDisplayNames ].
	self assert: [ Intl durationFormat = IntlDurationFormat ].
	self assert: [ Intl listFormat = IntlListFormat ].
	self assert: [ Intl locale = IntlLocale ].
	self assert: [ Intl numberFormat = IntlNumberFormat ].
	self assert: [ Intl pluralRules = IntlPluralRules ].
	self assert: [ Intl relativeTimeFormat = IntlRelativeTimeFormat ].
	self assert: [ Intl segmenter = IntlSegmenter ].
	self assert: [ ( ( Intl numberFormat locales: 'en-US' ) format: 1000 ) = '1,000' ].
!
