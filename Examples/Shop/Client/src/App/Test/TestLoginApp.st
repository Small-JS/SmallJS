CLASS TestLoginApp EXTENDS Object MODULE TestShopClient CLASSVARS '' VARS 'loginApp'

"Tests the GUI of the Shop client login page.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	loginApp := LoginApp new start.

	"Run sync and async tests of all imported Test* classes and log results."
	await TestPerson all.

	await Timer timeout: 500.
	self testLoginFields.
	self testLoginOptions.

	"Press login button.
	 App should navigate to producs page then."
	loginApp loginButton click.
!
testLoginFields
	"Check if login fields are filled correctly"

	self assert: [ loginApp userNameInput value = 'John' ].
	self assert: [ loginApp passwordInput value = 'secret' ].
!
testLoginOptions
	"Check if the login request is a POST with a JSON body."
	| options |

	options := loginApp loginOptions: ( Person new name: 'Test'; password: 'secret' ).
	self assert: [ options method = 'POST' ].
	self assert: [ ( options headers get: 'content-type' ) = 'application/json' ].
!
