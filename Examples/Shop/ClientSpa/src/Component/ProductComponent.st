CLASS ProductComponent EXTENDS Component MODULE ShopClient CLASSVARS ''
	VARS 'products navBar productTable'

htmlPath
	^ 'Product/Product.html'.
!
async start
	navBar := NavBarComponent new app: self app.

	await navBar loadIntoElement: 'productNavBar'.
	productTable := Document getElementById: 'productTable' class: HtmlTableElement.

	await self loadProducts.
!

"Loading"

async loadProducts
	| productsApi objects |

	productsApi := self app url, '/api/products'.
	objects := await Fetch object: productsApi.

	products := objects map: [ :object | Product fromObject: object ].
	self showProducts.
!

"Showing"

async showProducts
	| row |

	productTable tBody innerHtml: ''.

	products do: [ :product |
		row := productTable tBody insertRow: -1.
		row insertCell textContent: product name.
		row insertCell textContent: product priceString ].
!

"Accessing (used by tests)"

navBar
	^ navBar.
!
productTable
	^ productTable.
!
products
	^ products.
!
