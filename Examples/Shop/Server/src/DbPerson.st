CLASS DbPerson EXTENDS Person MODULE ShopServer CLASSVARS '' VARS 'salt'

"Implements a person in the datase, which is a supperset of the shared Person class."

CLASSMETHODS

columns
	^ super columns
		add: #( 'salt' Integer ).
!
fromObject: object
	^ super fromObject: object
		salt: ( object atProperty: 'salt' ).
!

METHODS

"Accessing"

salt
	^ salt.
!
salt: aSalt
	salt := aSalt.
!

"Password management
 Passwords are stored internally as a SHA256 digests of a random salt prefixed to the plaintext password."

setPassword: aPassword then: block error: errorBlock
	salt := ( Float random * 1000000 ) toInteger.
	self hashPassword: aPassword
		then: [ :hash | password := hash. block value ]
		error: [ :error | error throw ].
!
checkPassword: aPassword then: block error: errorBlock
	self hashPassword: aPassword
		then: [ :hash | block value: hash = password ]
		error: [ :error | error throw ].
!
hashPassword: aPassword then: block error: errorBlock
	| passwordData |
	passwordData := Uint8Array encodeFromString: self salt toString + aPassword.
	Crypto digest: 'SHA-256' data: passwordData
		then: [ :digestBuffer | block value: ( Uint8Array buffer: digestBuffer ) toHex ]
		error: [ :error | error throw ].
!
