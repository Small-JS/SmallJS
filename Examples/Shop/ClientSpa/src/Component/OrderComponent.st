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
	| object |

	object := await self app fetchApi: '/api/orders'.
	object ifNil: [ ^ nil ].

	orders := ( object atProperty: 'orders' )
		map: [ :orderObject | Order fromObject: orderObject ].
	products := ( object atProperty: 'products' )
		map: [ :productObject | Product fromObject: productObject ].

	"Connect orders to products by direct references, replacing product ids."
	orders do: [ :order |
		order product: ( products find: [ :product | product id = order product ] ) ].

	self showOrders.

	self app testMode ifTrue: [
		TestOrderComponent new test: self ].
!
showOrders
	| row |

	orderTable tBody innerHtml: ''.

	orders do: [ :order |
		row := orderTable tBody insertRow: -1.
		row insertCell textContent: order product name.
		row insertCell textContent: order amount.
		row insertCell textContent: order product priceString ].
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
