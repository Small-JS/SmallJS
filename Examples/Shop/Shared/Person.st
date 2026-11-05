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

toLoginJson
	"Return the JSON body of a login request for this person.
	 It contains only the name and password, not the id."
	^ ( Object new
		atProperty: 'name' put: name;
		atProperty: 'password' put: password ) toJson.
!
