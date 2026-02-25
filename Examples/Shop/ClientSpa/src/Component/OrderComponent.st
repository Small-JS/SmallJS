CLASS OrderComponent EXTENDS Component MODULE ShopClient CLASSVARS ''
	VARS 'orders products navBar orderTable'

METHODS

htmlPath
	^ 'Order/Order.html'.
!
async start
	navBar := NavBarComponent new app: self app.
	await navBar loadIntoElement: 'orderNavBar'.

	orderTable := Document getElementById: 'orderTable' class: HtmlTableElement.

	await self loadOrders.
!
async loadOrders
	|  ordersApi object |

	ordersApi := Window default location hostPath, '/api/orders'.
	object := await Fetch  object: ordersApi.

	orders := ( object atProperty: 'orders' )
		map: [ :object | Order fromObject: object ].
	products := ( object atProperty: 'products' )
		map: [ :object | Product fromObject: object ].

	"Connect orders to products by direct references, replacing product ids."
	orders do: [ :order |
		order product: ( products find: [ :product | product id = order product ] ) ].

	self showOrders.

	self app testMode ifTrue: [
		TestOrderComponent new test: self ].
!
showOrders
	| row priceString |

	orderTable tBody innerHtml: ''.

	orders do: [ :order |
		row := orderTable tBody insertRow: -1.
		row insertCell textContent: order product name.
		row insertCell textContent: order amount.
		row insertCell textContent: order product priceString.
	]
!

"Accessing (used by tests)"

navBar
	^ navBar.
!
orderTable
	^ orderTable.
!
orders
	^ orders.
!
