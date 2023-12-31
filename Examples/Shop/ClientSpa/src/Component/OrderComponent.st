CLASS OrderComponent EXTENDS Component MODULE ShopClient CLASSVARS ''
	VARS 'orderTable orderTableBody orders products'

METHODS

htmlPath
	^ 'Order/Order.html'.
!
start
	orderTable := Document getElementById: 'orderTable' class: HtmlTableElement.

	NavBarComponent new app: self app;
		loadIntoElement: 'orderNavBar' then: [
			self loadOrders ].
!
loadOrders
	|  ordersApi |

	ordersApi := Window default location hostPath, '/api/orders'.
	Fetch
		object: ordersApi
		then: [ :object | self onLoadOrders: object ]
		catch: [ :error | self onLoadOrdersError: error ] .
!
onLoadOrders: object
	orders := ( object atProperty: 'orders' ) map: [ :object | Order fromObject: object ].
	products := ( object atProperty: 'products' ) map: [ :object | Product fromObject: object ].

	"Connect orders to products by direct references, replacing product ids."
	orders do: [ :order |
		order product: ( products find: [ :product | product id = order product ] ) ].

	self showOrders.

	self app testMode ifTrue: [
		TestOrderComponent new test: self ].
!
onLoadOrdersError: error
	self error: error message.
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
