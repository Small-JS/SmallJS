CLASS TestElectronBaseWindow EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

"Tests that do not need an actual window, which can only be created after the app is ready."

testClassMethods
	self assert: [ ElectronBaseWindow allWindows class = Array ].
	self assert: [ ( ElectronBaseWindow fromId: 999999 ) isNil ].
	self assert: [ ElectronBaseWindow focusedWindow isNil or: [
		ElectronBaseWindow focusedWindow isKindOf: ElectronBaseWindow ] ].
!
testJsRect
	| jsRect |
	jsRect := JsObject fromJs:
		( ElectronBaseWindow newEmpty jsRect: ( Rect origin: 1 @ 2 extent: 3 @ 4 ) ).

	self assert: [ ( jsRect atJsProperty: 'x' ) = 1 ].
	self assert: [ ( jsRect atJsProperty: 'y' ) = 2 ].
	self assert: [ ( jsRect atJsProperty: 'width' ) = 3 ].
	self assert: [ ( jsRect atJsProperty: 'height' ) = 4 ].
!
