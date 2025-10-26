CLASS TestCrypto EXTENDS Test MODULE TestCrypto CLASSVARS '' VARS ''

test
	| buffer |

	buffer := Uint8Array new: 8.
	Crypto randomValues: buffer.
	self assert: [ buffer toArray ~= #( 0 0 0 0 0 0 0 0 ) ].

	self assert: [ Crypto randomUuid length = 36 ].
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
