CLASS CryptoKeyPair EXTENDS JsObject MODULE Crypto CLASSVARS '' VARS ''

"This class is tested in class TestCryptoRsa."

privateKey
	^ CryptoKey fromJs: INLINE 'this.js.privateKey'.
!
publicKey
	^ CryptoKey fromJs: INLINE 'this.js.publicKey'.
!
