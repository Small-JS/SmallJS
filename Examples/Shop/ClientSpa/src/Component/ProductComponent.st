CLASS ProductComponent EXTENDS Component MODULE ShopClient CLASSVARS '' VARS 'productTable products'

htmlPath
	^ 'Product/Product.html'.
!
start
	productTable := Document getElementById: 'productTable' class: HtmlTableElement.

	NavBarComponent new app: self app;
		loadIntoElement: 'productNavBar' then: [
			self loadProducts ].
!

"Loading"

loadProducts
	| productsApi |

	productsApi := self app url, '/api/products'.
	Fetch
		object: productsApi
		then: [ :objects | self onLoadProducts: objects ]
		catch: [ :error | self onLoadProductsError: error ] .
!
onLoadProducts: objects
	products := objects map: [ :object | Product fromObject: object ].
	self showProducts.

	self app testMode ifTrue: [
		TestProductComponent new test: self ].
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
