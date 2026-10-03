CLASS TestElectronMenuItemOptions EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

testUnset
	| options |

	options := ElectronMenuItemOptions new.
	self assert: [ options id isNil ].
	self assert: [ options label isNil ].
	self assert: [ options enabled isNil ].
	self assert: [ options checked isNil ].
	self assert: [ options icon isNil ].
	self assert: [ options submenu isNil ].
	self assert: [ options before isNil ].
!
testProperties
	| options menu |

	options := ElectronMenuItemOptions new.
	options role: 'copy'; type: 'normal'; label: 'Label';
		accelerator: 'CmdOrCtrl+K'; enabled: false; visible: true.
	self assert: [ options role = 'copy' ].
	self assert: [ options type = 'normal' ].
	self assert: [ options label = 'Label' ].
	self assert: [ options accelerator = 'CmdOrCtrl+K' ].
	self assert: [ options enabled = false ].
	self assert: [ options visible = true ].

	options id: 'check'; checked: true; icon: 'icon.png'.
	self assert: [ options id = 'check' ].
	self assert: [ options checked ].
	self assert: [ options icon = 'icon.png' ].

	menu := ElectronMenu new.
	options submenu: menu.
	self assert: [ options submenu = menu ].
!
testPositioningProperties
	| options |

	options := ElectronMenuItemOptions new.
	options before: #( 'a' ); after: #( 'b' 'c' ); beforeGroupContaining: #( 'd' ); afterGroupContaining: #( 'e' ).
	self assert: [ options before = #( 'a' ) ].
	self assert: [ options after = #( 'b' 'c' ) ].
	self assert: [ options beforeGroupContaining = #( 'd' ) ].
	self assert: [ options afterGroupContaining = #( 'e' ) ].
!
testAppliedToItem
	"Options are applied to the created item.
	 Note: The icon is not applied here, because the file must exist."
	| options menu item |

	options := ElectronMenuItemOptions new label: 'Check'; type: 'checkbox'; id: 'check'; checked: true.
	menu := ElectronMenu new.
	menu append: options.
	item := menu menuItemById: 'check'.
	self assert: [ item label = 'Check' ].
	self assert: [ item checked ].
!
testPositioning
	"Positioning is applied when building a menu from a template."
	| template |

	template := Array new.
	template add: ( ElectronMenuItemOptions new label: 'A'; id: 'a' ).
	template add: ( ElectronMenuItemOptions new label: 'B'; id: 'b'; before: #( 'a' ) ).
	self assert: [ ( self labelsFromTemplate: template ) = #( 'B' 'A' ) ].

	template := Array new.
	template add: ( ElectronMenuItemOptions new label: 'A'; id: 'a'; after: #( 'b' ) ).
	template add: ( ElectronMenuItemOptions new label: 'B'; id: 'b' ).
	self assert: [ ( self labelsFromTemplate: template ) = #( 'B' 'A' ) ].
!
labelsFromTemplate: template
	"Note: ElectronMenu does not implement buildFromTemplate yet, so call it via JS."
	| menu |

	menu := ElectronMenu new.
	menu := ElectronMenu fromJs: ( INLINE 'menu.js.constructor.buildFromTemplate( template.js.map( options => options.js ) )' ).
	^ Array fromJsStrings: ( INLINE 'menu.js.items.map( item => item.label )' ).
!
