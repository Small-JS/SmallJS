CLASS TestUri EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

testEncode
	| url |
	url := 'https://example.com/a b/ü?q=1&r=x y#top'.
	self assert: [ ( Uri encode: url ) = 'https://example.com/a%20b/%C3%BC?q=1&r=x%20y#top' ].
	self assert: [ ( Uri decode: ( Uri encode: url ) ) = url ].
	"Escapes of characters that structure a URL are not decoded."
	self assert: [ ( Uri decode: 'a%2Fb%20c' ) = 'a%2Fb c' ].
!
testEncodeComponent
	| component |
	component := 'a b/ü?q=1&r#top'.
	self assert: [ ( Uri encodeComponent: component ) = 'a%20b%2F%C3%BC%3Fq%3D1%26r%23top' ].
	self assert: [ ( Uri decodeComponent: ( Uri encodeComponent: component ) ) = component ].
	self assert: [ ( Uri encodeComponent: '-_.!~*\'()' ) = '-_.!~*\'()' ].
	self assert: [ ( Uri decodeComponent: 'a%2Fb%20c' ) = 'a/b c' ].
!
testErrors
	| loneSurrogate |
	"These throw a JS URIError, not an Error."
	loneSurrogate := String fromJs: INLINE '"\uD800"'.
	self assert: [ ( [ Uri encode: loneSurrogate ] tryCatch: [ :error | error name ] ) = 'URIError' ].
	self assert: [ ( [ Uri encodeComponent: loneSurrogate ] tryCatch: [ :error | error name ] ) = 'URIError' ].
	self assert: [ ( [ Uri decode: '%E0%A4%A' ] tryCatch: [ :error | error name ] ) = 'URIError' ].
	self assert: [ ( [ Uri decodeComponent: '%E0%A4%A' ] tryCatch: [ :error | error name ] ) = 'URIError' ].
!
