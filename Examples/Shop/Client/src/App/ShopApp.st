CLASS ShopApp EXTENDS BrowserApp MODULE ShopClient CLASSVARS '' VARS ''

"Base class of the apps of the Shop client pages.
 Fetches data from the Shop server API and shows errors on the page."

METHODS

"Fetching"

async fetchApi: path
	^ await self fetchApi: path options: nil.
!
async fetchApi: path options: options
	"Return the object fetched from the Shop server API path, or nil if that failed.
	 If the user is not logged in (anymore), navigate to the login page."
	| response |

	response := await async [ await Fetch request: self url, path options: options ]
		tryAwaitCatch: [ :error | self showError: 'Cannot reach Shop server: ', error message. nil ].
	response ifNil: [ ^ nil ].

	response status = 401 ifTrue: [
		self navigateTo: '../Login/Login.html'.
		^ nil ].
	response ok ifFalse: [
		self showError: 'Shop server error: ', response statusAndText.
		^ nil ].

	^ await response json.
!

"Showing"

showError: message
	self log: message.
	( Document getElementById: 'errorSpan' class: HtmlSpanElement ) textContent: message.
!
