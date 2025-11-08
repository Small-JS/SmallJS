CLASS TestProductComponent EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS 'productComponent'

"Tests the GUI of the Shop client Product page.
 This class is not a subclass of Test so is not called automatically with Test all."

async test: aProductComponent
	productComponent := aProductComponent.

	"Check if product fields are filled correctly.
	 Then exit the application."

	await Timer timeout: 1000.
	self testProductFields.

	await Timer timeout: 1000.
	self navigateToOrders.
!
testProductFields
	| tBody cells |

	tBody := productComponent productTable tBody.
	self assert: [ tBody class = HtmlTableSectionElement ].
	self assert: [ tBody rows length = 3 ].

	cells := tBody rows first cells.
	self assert: [ cells length = 2 ].
	self assert: [ ( cells at: 0 ) textContent = 'Apple' ].
	self assert: [ ( cells at: 1 ) textContent = '1.00' ].
!
navigateToOrders
	| ordersSpan |
	ordersSpan := Document getElementById: 'navBarOrdersSpan' class: HtmlSpanElement.
	ordersSpan click.
!
