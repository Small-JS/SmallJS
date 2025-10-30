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

"Password management"

"Passwords are stored internally as a SHA256 digests
of a random salt integer prefixed to the plaintext password."

async setPassword: aPassword
	"Set password using new salt."
	salt := ( Float random * 1000000 ) toInteger.
	password := await self hashPassword: aPassword.
!
async checkPassword: aPassword
	^ ( await self hashPassword: aPassword ) = password.
!
async hashPassword: aPassword
	"Return hashed password with stored salt."
	| passwordData digestBuffer hashedPassword |
	passwordData := Uint8Array encodeFromString: self salt toString + aPassword.
	digestBuffer := await Crypto digest: 'SHA-256' data: passwordData.
	hashedPassword := ( Uint8Array buffer: digestBuffer ) toHex.
	^ hashedPassword.
!
