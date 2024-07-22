CLASS NavBarComponent EXTENDS Component MODULE ShopClient CLASSVARS ''
	VARS 'productsSpan ordersSpan'

htmlPath
	^ 'NavBar/NavBar.html'.
!
start
	self bindElements.
!
bindElements
	productsSpan := Document getElementById: 'navBarProductsSpan' class: HtmlSpanElement.
	productsSpan onClick: [ :event | self app loadComponent: ProductComponent ].

	ordersSpan := Document getElementById: 'navBarOrdersSpan' class: HtmlSpanElement.
	ordersSpan onClick: [ :event | self app loadComponent: OrderComponent ].
!
