CLASS ProductApp EXTENDS ClientApp MODULE ShopClient CLASSVARS '' VARS 'productTable products'

METHODS

start
	productTable := Document default getElementById: 'productTable'.
	productTable class = HtmlTableElement ifFalse: [
			self error: 'Could not find product table element.' ].

	self loadProducts.

	self testMode ifTrue: [
		TestProductApp new test: self ].
!

"Loading"

loadProducts
	| productsApi |

	productsApi := self url, '/api/products'.
	Object
		fetchObject: productsApi
		then: [ :objects | self onLoadProducts: objects ]
		onError: [ :error | self onLoadProductsError: error ] .
!
onLoadProducts: objects
	products := objects map: [ :object | Product fromObject: object ].
	self showProducts.
!
onLoadProductsError: error
	self error: error message.
!

"Showing"

showProducts
	| row |

	productTable tBody innerHtml: ''.

	products do: [ :product |
		row := productTable tBody insertRow: -1.
		row insertCell textContent: product name.
		row insertCell textContent: product priceString ].
!

"Accessing (used by tests)"

productTable
	^ productTable.
!
products
	^ products.
!
