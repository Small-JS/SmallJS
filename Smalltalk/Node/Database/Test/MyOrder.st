CLASS MyOrder EXTENDS SqlObject MODULE TestDatabase CLASSVARS '' VARS 'person product amount'

CLASSMETHODS

columns
	^ #( #( 'person' Integer )
		#( 'product' Integer )
		#( 'amount' Integer ) ).
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
