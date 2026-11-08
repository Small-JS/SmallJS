CLASS TestIntlLocale EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"Tests use explicit locales and the UTC time zone, so the results do not depend on the system settings."

METHODS

test
	| locale |
	locale := IntlLocale tag: 'en-Latn-US'.
	self assert: [ locale class = IntlLocale ].
	self assert: [ locale language = 'en' ].
	self assert: [ locale script = 'Latn' ].
	self assert: [ locale region = 'US' ].
	self assert: [ locale baseName = 'en-Latn-US' ].
	self assert: [ locale toString = 'en-Latn-US' ].
	self assert: [ locale calendar isNil ].
	self assert: [ locale caseFirst isNil ].
	self assert: [ locale collation isNil ].
	self assert: [ locale hourCycle isNil ].
	self assert: [ locale numberingSystem isNil ].
	self assert: [ locale numeric not ].
!
testOptions
	| options locale |
	options := JsObject newEmpty
		atJsProperty: 'region' put: 'GB';
		atJsProperty: 'hourCycle' put: 'h23';
		atJsProperty: 'calendar' put: 'gregory';
		atJsProperty: 'numeric' put: true.
	locale := IntlLocale tag: 'en-US' options: options.
	self assert: [ locale region = 'GB' ].
	self assert: [ locale hourCycle = 'h23' ].
	self assert: [ locale calendar = 'gregory' ].
	self assert: [ locale numeric ].
	self assert: [ locale baseName = 'en-GB' ].
	self assert: [ locale toString = 'en-GB-u-ca-gregory-hc-h23-kn' ].
!
testMaximize
	self assert: [ ( IntlLocale tag: 'en' ) maximize toString = 'en-Latn-US' ].
	self assert: [ ( IntlLocale tag: 'en-Latn-US' ) minimize toString = 'en' ].
!
testInvalid
	| result |
	result := [ IntlLocale tag: 'invalid_tag' ] tryCatch: [ :error | error ].
	self assert: [ result class = Error ].
	self assert: [ result name = 'RangeError' ].
!
