CLASS ProductApp EXTENDS ShopApp MODULE ShopClient CLASSVARS '' VARS 'productTable products'

METHODS

async start
	productTable := Document getElementById: 'productTable' class: HtmlTableElement.

	await self loadProducts.
!

"Loading"

async loadProducts
	| objects |

	objects := await self fetchApi: '/api/products'.
	objects ifNil: [ ^ nil ].

	products := objects map: [ :object | Product fromObject: object ].

	self showProducts.
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
