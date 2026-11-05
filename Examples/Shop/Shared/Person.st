CLASS Person EXTENDS SqlObject MODULE ShopShared CLASSVARS '' VARS 'name password'

CLASSMETHODS

columns
	^ #( #( 'name' String )
		#( 'password' String ) ).
!
fromObject: object
	^ self new
		id: ( object atProperty: 'id' );
		name: ( object atProperty: 'name' );
		password: ( object atProperty: 'password' ).
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

"Converting"

toQuery
	"Return URL query part to request this person, with escaped values."
	^ '?name=', ( Uri encodeComponent: name ), '&password=', ( Uri encodeComponent: password ).
!
