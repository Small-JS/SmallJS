CLASS ProductComponent EXTENDS Component MODULE ShopClient CLASSVARS '' VARS 'productTable products'

htmlPath
	^ 'Product/Product.html'.
!
async start
	productTable := Document getElementById: 'productTable' class: HtmlTableElement.

	await NavBarComponent new
		app: self app;
		loadIntoElement: 'productNavBar'.
	await self loadProducts.
!

"Loading"

async loadProducts
	| productsApi objects |

	productsApi := self app url, '/api/products'.
	objects := await Fetch object: productsApi.

	products := objects map: [ :object | Product fromObject: object ].
	self showProducts.

	self app testMode ifTrue: [
		TestProductComponent new test: self ].
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

productTable
	^ productTable.
!
products
	^ products.
!
