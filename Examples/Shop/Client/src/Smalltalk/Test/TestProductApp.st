CLASS TestProductApp EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS 'productApp'

"Tests the GUI of the Shop client Product page.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aProductApp
	productApp := aProductApp.

	"Check if product fields are filled correctly.
	 Then exit the application."

	Timer timeout: 1000 then: [
		self testProductFields.
		Timer timeout: 1000 then: [
			productApp navigateTo: '../Order/Order.html' ] ].
!
testProductFields
	| tBody cells |

	tBody := productApp productTable tBody.
	self assert: [ tBody class = HtmlTableSectionElement ].
	self assert: [ tBody rows length = 3 ].

	cells := tBody rows first cells.
	self assert: [ cells length = 2 ].
	self assert: [ ( cells at: 0 ) textContent = 'Apple' ].
	self assert: [ ( cells at: 1 ) textContent = '1.00' ].
!
