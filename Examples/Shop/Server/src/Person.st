CLASS Person EXTENDS SqlObject MODULE ShopServer CLASSVARS '' VARS 'name salt password'

CLASSMETHODS

columns
	^ #( #( 'name' String )
		#( 'password' String )
		#( 'salt' Integer ) ).
!
fromObject: object
	^ self new
		id: ( object atProperty: 'id' );
		name: ( object atProperty: 'name' );
		password: ( object atProperty: 'password' );
		salt: ( object atProperty: 'salt' ).
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
password: aPassword
	password := aPassword.
!
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
