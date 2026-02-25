CLASS TestShopApp EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS ''

"Tests the GUI of the Shop client login page.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	| shopApp loginComponent productComponent orderComponent |
	"Run sync and async tests of all imported Test* classes and log results."
	await TestPerson all.

	shopApp := ShopApp new.
	await shopApp start.
	await Timer timeout: 2000.

	loginComponent := shopApp component.
	TestLoginComponent new test: loginComponent.
	loginComponent loginButton click.
	await Timer timeout: 2000.

	productComponent := shopApp component.
	TestProductComponent new test: productComponent.
	productComponent navBar ordersSpan click.
	await Timer timeout: 2000.

	orderComponent := shopApp component.
	TestOrderComponent new test: orderComponent.
	shopApp stop.
!
