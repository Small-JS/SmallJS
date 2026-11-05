CLASS OrderApp EXTENDS ShopApp MODULE ShopClient CLASSVARS ''
	VARS 'orderTable orders products'

METHODS

async start
	orderTable := Document getElementById: 'orderTable' class: HtmlTableElement.

	await self loadOrders.
!
async loadOrders
	| object |

	object := await self fetchApi: '/api/orders'.
	object ifNil: [ ^ nil ].

	products := ( object atProperty: 'products' )
		map: [ :productObject | Product fromObject: productObject ].
	orders := ( object atProperty: 'orders' )
		map: [ :orderObject | Order fromObject: orderObject ].
	"Connect orders to products by direct references, replacing product ids."
	orders do: [ :order | order product:
		( products find: [ :product | product id = order product ] ) ].

	self showOrders.
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

orderTable
	^ orderTable.
!
orders
	^ orders.
!
