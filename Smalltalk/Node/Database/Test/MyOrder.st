CLASS MyOrder EXTENDS SqlObject MODULE TestDatabase CLASSVARS '' VARS 'person product amount'

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
