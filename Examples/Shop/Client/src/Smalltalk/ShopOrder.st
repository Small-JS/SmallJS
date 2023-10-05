CLASS ShopOrder EXTENDS Object MODULE ShopClient CLASSVARS ''
	VARS 'orderTable orderTableBody orders products'

METHODS

start
	| document |
	document := Document default.

	orderTable := document getElementById: 'orderTable'.
	orderTable class = HtmlTableElement ifFalse: [
			self error: 'Could not find orderTable element.' ].

	self loadOrders.
	"self loadTestOrders."
!
loadOrders
	|  ordersApi |

	ordersApi := Window default location hostPath, '/api/orders'.
	Object
		fetchObject: ordersApi
		then: [ :object | self onLoadOrders: object ]
		onError: [ :error | self onLoadOrdersError: error ] .
!
onLoadOrders: object
	orders := ( object atProperty: 'orders' ) map: [ :object | Order fromObject: object ].
	products := ( object atProperty: 'products' ) map: [ :object | Product fromObject: object ].

	"Connect orders to products by direct reference, replacing product ids."
	orders do: [ :order |
		order product: ( products find: [ :product | product id = order product ] ) ].

	self showOrders.
!
onLoadOrdersError: error
	self error: error message.
!
loadTestOrders
	self onLoadOrders: ( JsObject parse: self jsonTestOrders ).
!
jsonTestOrders
	^ '{ "orders" : [ \
			{ "id": 1, "person": 1, "product": 1, "amount": 10 }, \
			{ "id": 2, "person": 1,"product": 2,"amount": 5 } ], \
		"products" : [ \
			{ "id": 1, "name": "Apple", "price": 100 }, \
			{ "id": 2, "name": "Orange", "price": 150 } ] }'.
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
