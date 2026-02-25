CLASS ShopApp EXTENDS BrowserApp MODULE ShopClient CLASSVARS ''
	VARS 'component'

"Var 'component' holds the currently loaded SPA component.
It can be one a LoginCompoment, ProductComponent or OrderComponent"

async start
	await self loadComponent: LoginComponent.
!
async loadComponent: componentClass
	component := componentClass new app: self.
	"Note: A compontent's start method is called automatically"
	await component loadIntoElement: 'component'.
!
component
	^ component.
!
