CLASS MyProduct EXTENDS SqlObject MODULE TestDatabase CLASSVARS '' VARS 'name price'

CLASSMETHODS

columns
	^ #( #( 'name' String )
		#( 'price' Integer ) ).
!

METHODS

name
	^ name.
!
name: aName
	name := aName.
!
price
	^ price.
!
price: aPrice
	price := aPrice.
!
