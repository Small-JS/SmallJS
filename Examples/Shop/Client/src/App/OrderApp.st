CLASS OrderApp EXTENDS BrowserApp MODULE ShopClient CLASSVARS ''
	VARS 'orderTable orders products'

METHODS

async start
	orderTable := Document getElementById: 'orderTable' class: HtmlTableElement.

	await self loadOrders.
!
async loadOrders
	|  ordersApi object |

	ordersApi := Window default location hostPath, '/api/orders'.
	object := await Fetch object: ordersApi.

	products := ( object atProperty: 'products' )
		map: [ :object | Product fromObject: object ].
	orders := ( object atProperty: 'orders' )
		map: [ :object | Order fromObject: object ].
	"Connect orders to products by direct references, replacing product ids."
	orders do: [ :order | order product:
		( products find: [ :product | product id = order product ] ) ].

	self showOrders.

	self testMode ifTrue: [
		TestOrderApp new test: self ].
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

orderTable
	^ orderTable.
!
orders
	^ orders.
!
