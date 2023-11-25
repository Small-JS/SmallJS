CLASS TestOrderApp EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS 'orderApp'

"Tests the GUI of the Shop client Order page.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aOrderApp
	orderApp := aOrderApp.

	"Check if order fields are filled correctly.
	 Then exit the application."

	Timer timeout: 1000 then: [
		self testOrderFields.
		Timer timeout: 1000 then: [
			orderApp stop ] ].
!
testOrderFields
	| tBody cells |

	tBody := orderApp orderTable tBody.
	self assert: [ tBody class = HtmlTableSectionElement ].
	self assert: [ tBody rows length = 2 ].

	cells := tBody rows first cells.
	self assert: [ cells length = 3 ].
	self assert: [ ( cells at: 0 ) textContent = 'Apple' ].
	self assert: [ ( cells at: 1 ) textContent = '10' ].
	self assert: [ ( cells at: 2 ) textContent = '1.00' ].
!
