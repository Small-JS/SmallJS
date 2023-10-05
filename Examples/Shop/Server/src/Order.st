CLASS Order EXTENDS SqlObject MODULE ShopServer CLASSVARS '' VARS 'person product amount'

CLASSMETHODS

columns
	^ #( 'person' 'product' 'amount' ).
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
