CLASS ShopApp EXTENDS BrowserApp MODULE ShopClient CLASSVARS '' VARS ''

METHODS

start
	self loadComponent: LoginComponent.
!
loadComponent: componentClass
	| component |
	component := componentClass new app: self.
	"Note: The compontent start method is called automatically"
	component loadIntoElement: 'component' then: [ ].
!
