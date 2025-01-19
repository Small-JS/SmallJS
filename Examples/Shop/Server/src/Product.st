CLASS Product EXTENDS SqlObject MODULE ShopServer CLASSVARS '' VARS 'name price'

CLASSMETHODS

columns
	^ #( #( 'name' String )
		#( 'price' Integer ) ).
!
fromObject: object
	^ Product new
		id: ( object atProperty: 'id' );
		name: ( object atProperty: 'name' );
		price: ( object atProperty: 'price' ).
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
priceString
	^ self price toFloat / 100 toFixed: 2.
!
