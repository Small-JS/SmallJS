CLASS TestCrypto EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| buffer |

	buffer := Uint8Array new: 8.
	Crypto randomValues: buffer.
	self assert: [ buffer toArray ~= #( 0 0 0 0 0 0 0 0 ) ].

	self assert: [ Crypto randomUuid length = 36 ].
!
testCryptoKey
	self assert: [ CryptoKey new class = CryptoKey ].
!
async testHmac
	"HMAC has no params class, so a JsObject is used for the algorithm."
	| params key data signature verified |
	params := JsObject newEmpty.
	params atJsProperty: 'name' put: 'HMAC';
		atJsProperty: 'hash' put: 'SHA-256'.

	key := await Crypto generateKey: params extractable: false usages: #( 'sign' 'verify' ).
	self assert: [ key class = CryptoKey ].
	self assert: [ key type = 'secret' ].
	self assert: [ key algorithm class = JsObject ].
	self assert: [ ( key algorithm atJsProperty: 'name' ) = 'HMAC' ].

	data := Uint8Array encodeFromString: 'Hello, HMAC!'.
	signature := await Crypto sign: params key: key data: data.
	verified := await Crypto verify: params key: key signature: signature data: data.
	self assert: [ verified class = Boolean ].
	self assert: [ verified ].
!
async testEd25519
	"Ed25519 generates a key pair, without its name starting with 'RS' or 'EC'."
	| keyPair data signature verified |
	keyPair := await Crypto generateKey: 'Ed25519' extractable: false usages: #( 'sign' 'verify' ).
	self assert: [ keyPair class = CryptoKeyPair ].
	self assert: [ ( keyPair privateKey algorithm atJsProperty: 'name' ) = 'Ed25519' ].

	data := Uint8Array encodeFromString: 'Hello, Ed25519!'.
	signature := await Crypto sign: 'Ed25519' key: keyPair privateKey data: data.
	verified := await Crypto verify: 'Ed25519' key: keyPair publicKey signature: signature data: data.
	self assert: [ verified ].
!
async testDigest
	| plainText plainData digestBuffer digestData |
	plainText := 'secret'.
	plainData := Uint8Array encodeFromString: plainText.

	digestBuffer := await Crypto digest: 'SHA-256' data: plainData.
	self assert: [ digestBuffer class = ArrayBuffer ].
	self assert: [ digestBuffer byteLength = 32 ].

	digestData := Uint8Array buffer: digestBuffer.
	self assert: [ digestData toHex = '2bb80d537b1da3e38bd30361aa855686bde0eacd7162fef6a25fe97bf527a25b' ].
!
