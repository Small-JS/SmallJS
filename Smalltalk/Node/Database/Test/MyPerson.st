CLASS MyPerson EXTENDS SqlObject MODULE TestDatabase CLASSVARS '' VARS 'name salt password'

CLASSMETHODS

columns
	^ #( #( 'name' String )
		#( 'salt' Integer )
		#( 'password' String ) ).
!

METHODS

name
	^ name.
!
name: aName
	name := aName.
!

"Password"

"Note: Passwords are stored internally as SHA-256 digests of random salt + user password"

password
	^ password.
!
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
salt
	^ salt.
!
