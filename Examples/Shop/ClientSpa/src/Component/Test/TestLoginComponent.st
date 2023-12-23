CLASS TestLoginComponent EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS 'loginComponent'

"Tests the GUI of the Shop client login page.
 This class is not a subclass of Test so is not called automatically with Test all."

test: aLoginComponent
	loginComponent := aLoginComponent.

	"Run sync and async tests of all imported Test* classes and log results."
	Test allThen: [
		self testGui ].
!
testGui
	"Check if login fields are filled correctly and then press login button.
	 Should navigate tot producs page then."

	Timer timeout: 500 then: [
		self testLoginFields.
		loginComponent loginButton click ].
!
testLoginFields
	self assert: [ loginComponent userNameInput value = 'John' ].
	self assert: [ loginComponent passwordInput value = 'secret' ].
!
