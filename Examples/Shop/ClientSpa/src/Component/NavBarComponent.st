CLASS NavBarComponent EXTENDS Component MODULE ShopClient CLASSVARS ''
	VARS 'productsLabel ordersLabel'

htmlPath
	^ 'NavBar/NavBar.html'.
!
start
	self bindElements.
!
bindElements
	productsLabel := Document getElementById: 'navBarProductsLabel' class: HtmlLabelElement.
	productsLabel onClick: [ :event | self app loadComponent: ProductComponent ].

	ordersLabel := Document getElementById: 'navBarOrdersLabel' class: HtmlLabelElement.
	ordersLabel onClick: [ :event | self app loadComponent: OrderComponent ].
!
