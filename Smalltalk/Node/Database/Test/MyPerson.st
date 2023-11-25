CLASS MyPerson EXTENDS SqlObject MODULE TestDatabase CLASSVARS '' VARS 'name salt password'

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

"Note: Passwords are stored internally as SHA256 digests of random salt + user password"

password
	^ password.
!
password: aPassword
	salt := ( Float random * 1000000 ) toInteger.
	password := self hashPassword: aPassword.
!
checkPassword: aPassword
	^ password = ( self hashPassword: aPassword ).
!
hashPassword: aPassword
	^ ( Hash create: 'sha256' ) update: self salt toString + aPassword; digest: 'hex'.
!
salt
	^ salt.
!
