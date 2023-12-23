CLASS NavBarComponent EXTENDS Component MODULE ShopClient CLASSVARS ''
	VARS 'productsLabel ordersLabel'

htmlPath
	^ 'NavBar/NavBar.html'.
!
start
	self bindElements.
!
bindElements
	productsLabel := Document getElementById: 'navBarProductsLabel'.
	self assert: [ productsLabel class = HtmlLabelElement ].
	productsLabel onClick: [ :event | self app loadComponent: ProductComponent ].

	ordersLabel := Document getElementById: 'navBarOrdersLabel'.
	self assert: [ ordersLabel class = HtmlLabelElement ].
	ordersLabel onClick: [ :event | self app loadComponent: OrderComponent ].
!
