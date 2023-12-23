CLASS Order EXTENDS SqlObject MODULE ShopClient CLASSVARS '' VARS 'person product amount'

CLASSMETHODS

columns
	^ #( 'person' 'product' 'amount' ).
!
fromObject: object
	^ Order new
		id: ( object atProperty: 'id' );
		person: ( object atProperty: 'person' );
		product: ( object atProperty: 'product' );
		amount: ( object atProperty: 'amount' ).
!

METHODS

person
	^ person.
!
person: aPerson
	person := aPerson.
!
product
	^ product.
!
product: aProduct
	product := aProduct.
!
amount
	^ amount.
!
amount: aAmount
	amount := aAmount.
!
