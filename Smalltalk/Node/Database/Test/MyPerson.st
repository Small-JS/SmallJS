CLASS MyPerson EXTENDS SqlObject MODULE TestDatabase CLASSVARS '' VARS 'name salt password'

CLASSMETHODS

columns
	^ #( #( 'name' String )
		#( 'salt' Integer )
		#( 'password' String ) ).
!

METHODS

"Accessing"

name
	^ name.
!
name: aName
	name := aName.
!
password
	^ password.
!
salt
	^ salt.
!


"Password operations"

"Note: Passwords are stored internally as SHA-256 digests of random salt number + user password"

async setPassword: aPassword
	"Set password using new salt."
	salt := ( Float random * 1000000 ) toInteger.
	password := await self hashPassword: aPassword.
!
async hashPassword: aPassword
	"Return hashed password with stored salt."
	| passwordData digestBuffer hashedPassword |
	passwordData := Uint8Array encodeFromString: self salt toString + aPassword.
	digestBuffer := await Crypto digest: 'SHA-256' data: passwordData.
	hashedPassword := ( Uint8Array buffer: digestBuffer ) toHex.
	^ hashedPassword.
!
async checkPassword: aPassword
	^ ( await self hashPassword: aPassword ) = password.
!
