CLASS ShopApp EXTENDS BrowserApp MODULE ShopClient CLASSVARS ''
	VARS 'component'

"Var 'component' holds the currently loaded SPA component.
It can be a LoginComponent, ProductComponent or OrderComponent."

async start
	await self loadComponent: LoginComponent.
!
async loadComponent: componentClass
	component := componentClass new app: self.
	"Note: A component's start method is called automatically"
	await component loadIntoElement: 'component'.
!
component
	^ component.
!

"Fetching"

async fetchApi: path
	^ await self fetchApi: path options: nil.
!
async fetchApi: path options: options
	"Return the object fetched from the Shop server API path, or nil if that failed.
	 If the user is not logged in (anymore), load the login component."
	| response |

	response := await async [ await Fetch request: self url, path options: options ]
		tryAwaitCatch: [ :error | self showError: 'Cannot reach Shop server: ', error message. nil ].
	response ifNil: [ ^ nil ].

	response status = 401 ifTrue: [
		self loadComponent: LoginComponent.
		^ nil ].
	response ok ifFalse: [
		self showError: 'Shop server error: ', response statusAndText.
		^ nil ].

	^ await response json.
!

"Showing"

showError: message
	"Show message in the error span of the current component."
	self log: message.
	( Document getElementById: 'errorSpan' class: HtmlSpanElement ) textContent: message.
!
