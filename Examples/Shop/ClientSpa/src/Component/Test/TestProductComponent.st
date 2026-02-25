CLASS TestProductComponent EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS ''

"Tests the GUI of the Shop client Product page.
 This class is not a subclass of Test so is not called automatically with Test all."

test: productComponent
	| tBody cells |

	tBody := productComponent productTable tBody.
	self assert: [ tBody class = HtmlTableSectionElement ].
	self assert: [ tBody rows length = 3 ].

	cells := tBody rows first cells.
	self assert: [ cells length = 2 ].
	self assert: [ ( cells at: 0 ) textContent = 'Apple' ].
	self assert: [ ( cells at: 1 ) textContent = '1.00' ].
!
