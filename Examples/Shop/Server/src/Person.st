CLASS Person EXTENDS SqlObject MODULE ShopServer CLASSVARS '' VARS 'name salt password'

CLASSMETHODS

columns
	^ #( 'name' 'salt' 'password' ).
!

METHODS

name
	^ name.
!
name: aName
	name := aName.
!

"Password"

"Passwords are stored internally as SHA256 digests of a random salt plus plaintext password"

password
	^ password.
!
password: aPassword
	salt := ( Float random * 1000000 ) toInteger.
	password := self hashPassword: aPassword.
!
hashPassword: aPassword
	^ ( Hash create: 'sha256' ) update: self salt toString + aPassword; digest: 'hex'.
!
checkPassword: aPassword
	^ password = ( self hashPassword: aPassword ).
!
salt
	^ salt.
!
