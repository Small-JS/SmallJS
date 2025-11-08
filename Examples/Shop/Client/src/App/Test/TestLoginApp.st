CLASS TestLoginApp EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS 'loginApp'

"Tests the GUI of the Shop client login page.
 This class is not a subclass of Test so is not called automatically with Test all."

async test: aLoginApp
	loginApp := aLoginApp.

	"Run sync and async tests of all imported Test* classes and log results."
	await Test all.

	await Timer timeout: 500.
	self testLoginFields.

	"Press login button.
	 App should navigate to producs page then."
	loginApp loginButton click.
!
testLoginFields
	"Check if login fields are filled correctly"

	self assert: [ loginApp userNameInput value = 'John' ].
	self assert: [ loginApp passwordInput value = 'secret' ].
!
