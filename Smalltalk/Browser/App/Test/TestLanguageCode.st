CLASS TestLanguageCode EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| code |
	code := LanguageCode fromCode: 'en-US'.
	self assert: [ code language = 'en' ].
	self assert: [ code country = 'US' ].
	self assert: [ code toString = 'en-US' ].

	"Language is converted to lower case, country to upper case."
	code := LanguageCode fromCode: 'EN-us'.
	self assert: [ code language = 'en' ].
	self assert: [ code country = 'US' ].

	"Country is optional."
	code := LanguageCode fromCode: 'ES'.
	self assert: [ code language = 'es' ].
	self assert: [ code country isNil ].
	self assert: [ code toString = 'es' ].
!
testMatch
	| code |
	code := LanguageCode fromCode: 'en-US'.
	self assert: [ code match: 'en-US' ].
	self assert: [ code match: 'EN-us' ].
	self assert: [ ( code match: 'en-GB' ) not ].
	self assert: [ ( code match: 'en' ) not ].
	self assert: [ ( code match: 'es-US' ) not ].

	self assert: [ code matchLanguage: 'en-GB' ].
	self assert: [ code matchLanguage: 'en' ].
	self assert: [ ( code matchLanguage: 'es' ) not ].

	code := LanguageCode fromCode: 'es'.
	self assert: [ code match: 'ES' ].
	self assert: [ ( code match: 'es-MX' ) not ].
	self assert: [ code matchLanguage: 'es-MX' ].
!
