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

setPassword: aPassword
	salt := ( Float random * 1000000 ) toInteger.
	password := self hashPassword: aPassword.
!
hashPassword: aPassword
	^ ( Hash create: 'sha256' ) update: self salt toString + aPassword; digest: 'hex'.
!
checkPassword: aPassword
	^ password = ( self hashPassword: aPassword ).
!
