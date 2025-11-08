CLASS TestLoginComponent EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS 'loginComponent'

"Tests the GUI of the Shop client login page.
 This class is not a subclass of Test so is not called automatically with Test all."

async test: aLoginComponent
	loginComponent := aLoginComponent.

	"Run sync and async tests of all imported Test* classes and log results."
	await Test all.

	self testLoginFields.

	"Press login button, should navigate tot producs page then."
	loginComponent loginButton click.
!
testLoginFields
	self assert: [ loginComponent userNameInput value = 'John' ].
	self assert: [ loginComponent passwordInput value = 'secret' ].
!
