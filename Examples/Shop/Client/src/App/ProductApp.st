CLASS ProductApp EXTENDS BrowserApp MODULE ShopClient CLASSVARS '' VARS 'productTable products'

METHODS

async start
	productTable := Document getElementById: 'productTable' class: HtmlTableElement.

	await self loadProducts.
!

"Loading"

async loadProducts
	| productsApi objects |

	productsApi := self url, '/api/products'.
	objects := await Fetch object: productsApi.

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
