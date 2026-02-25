CLASS TestLoginComponent EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS ''

"Tests the GUI of the Shop client login page.
 This class is not a subclass of Test so is not called automatically with Test all."

test: loginComponent
	self assert: [ loginComponent userNameInput value = 'John' ].
	self assert: [ loginComponent passwordInput value = 'secret' ].
!
