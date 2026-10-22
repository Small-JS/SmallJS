CLASS TestLanguage EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Loading a language file is tested in the Todo example."

test
	| language |
	language := Language supported: #( 'en-US' 'es' ).
	self assert: [ language supported = #( 'en-US' 'es' ) ].
	self assert: [ language current isNil ].
	self assert: [ language translations isNil ].
!
testMatchCode
	| language |
	language := Language supported: #( 'en-US' 'en-GB' 'es' ).

	"Exact match, ignoring case."
	self assert: [ ( language matchCode: 'en-GB' ) = 'en-GB' ].
	self assert: [ ( language matchCode: 'EN-gb' ) = 'en-GB' ].
	self assert: [ ( language matchCode: 'es' ) = 'es' ].

	"First supported code with the same language, from another country."
	self assert: [ ( language matchCode: 'en-AU' ) = 'en-US' ].
	self assert: [ ( language matchCode: 'en' ) = 'en-US' ].
	self assert: [ ( language matchCode: 'es-MX' ) = 'es' ].

	"Default is the first supported code."
	self assert: [ ( language matchCode: 'fr-FR' ) = 'en-US' ].
	self assert: [ ( language matchCode: 'fr' ) = 'en-US' ].
!
testMatchCodeUnsupported
	self assertError: [ Language new matchCode: 'en-US' ].
!
