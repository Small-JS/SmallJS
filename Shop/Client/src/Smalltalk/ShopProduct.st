CLASS ShopProduct EXTENDS Object MODULE ShopClient CLASSVARS '' VARS 'productTable products'

METHODS

start
	| document |
	document := Document default.

	productTable := document getElementById: 'productTable'.
	productTable class = HtmlTableElement ifFalse: [
			self error: 'Could not find product table element.' ].

	self loadProducts.
"	self loadTestProducts."
!

"Loading"

loadProducts
	| productsApi |

	productsApi := Window default location hostPath, '/api/products'.
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
loadTestProducts
	self onLoadProducts: ( Object parse: self jsonTestProducts ).
!
jsonTestProducts
	^ '[ { "id": 1, "name" : "Apple", "price": 100 }, \
		{ "id": 2, "name": "Orange", "price": 150 }, \
		{ "id": 3, "name": "Mango", "price": 220 } ]'.
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
