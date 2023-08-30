CLASS Product EXTENDS SqlObject MODULE ShopServer CLASSVARS '' VARS 'name price'

CLASSMETHODS

columns
	^ #( 'name' 'price' ).
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
