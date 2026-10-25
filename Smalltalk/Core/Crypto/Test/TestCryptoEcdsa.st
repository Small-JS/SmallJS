CLASS TestCryptoEcdsa EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

"Tests the signing algorithm ECDSA."

async testSignVerify
	| params keyPair signParams data signature verified |
	params := EcKeyGenParams new
		name: 'ECDSA';
		namedCurve: 'P-521'.

	keyPair := await Crypto generateKey: params extractable: false usages: #( 'sign' 'verify' ).
	self assert: [ keyPair class = CryptoKeyPair ].
	self assert: [ keyPair privateKey algorithm class = EcKeyGenParams ].
	self assert: [ keyPair privateKey algorithm name = 'ECDSA' ].
	self assert: [ keyPair privateKey algorithm namedCurve = 'P-521' ].

	"ECDSA has no params class, so a JsObject is used for the algorithm."
	signParams := JsObject newEmpty.
	signParams atJsProperty: 'name' put: 'ECDSA';
		atJsProperty: 'hash' put: 'SHA-256'.
	data := Uint8Array encodeFromString: 'Hello, ECDSA!'.
	signature := await Crypto sign: signParams key: keyPair privateKey data: data.

	verified := await Crypto verify: signParams key: keyPair publicKey signature: signature data: data.
	self assert: [ verified ].

	verified := await Crypto verify: signParams key: keyPair publicKey signature: signature
		data: ( Uint8Array encodeFromString: 'Tampered' ).
	self assert: [ verified not ].
!
