CLASS TestBrowserWindowOptions EXTENDS Test MODULE TestElectronMain CLASSVARS '' VARS ''

testUnset
	| options |

	options := BrowserWindowOptions new.
	self assert: [ options x isNil ].
	self assert: [ options width isNil ].
	self assert: [ options show isNil ].
	self assert: [ options parent isNil ].
	self assert: [ options title isNil ].
	self assert: [ options icon isNil ].
	self assert: [ options webPreferences isNil ].
!
testPositionAndSize
	| options |

	options := BrowserWindowOptions new.
	options x: 10; y: 20; width: 1000; height: 800; useContentSize: true; center: false.
	self assert: [ options x = 10 ].
	self assert: [ options y = 20 ].
	self assert: [ options width = 1000 ].
	self assert: [ options height = 800 ].
	self assert: [ options useContentSize ].
	self assert: [ options center not ].

	options minWidth: 100; minHeight: 200; maxWidth: 3000; maxHeight: 4000.
	self assert: [ options minWidth = 100 ].
	self assert: [ options minHeight = 200 ].
	self assert: [ options maxWidth = 3000 ].
	self assert: [ options maxHeight = 4000 ].
!
testBehavior
	| options |

	options := BrowserWindowOptions new.
	options resizable: false; focusable: false; alwaysOnTop: true.
	self assert: [ options resizable not ].
	self assert: [ options focusable not ].
	self assert: [ options alwaysOnTop ].

	options fullscreen: false; fullscreenable: true; kiosk: false; disableAutoHideCursor: true.
	self assert: [ options fullscreen not ].
	self assert: [ options fullscreenable ].
	self assert: [ options kiosk not ].
	self assert: [ options disableAutoHideCursor ].

	options show: false; paintWhenInitiallyHidden: true; modal: true.
	self assert: [ options show not ].
	self assert: [ options paintWhenInitiallyHidden ].
	self assert: [ options modal ].
!
testAppearance
	| options |

	options := BrowserWindowOptions new.
	options title: 'Title'; icon: 'icon.png'; name: 'main'.
	self assert: [ options title = 'Title' ].
	self assert: [ options icon = 'icon.png' ].
	self assert: [ options name = 'main' ].

	options frame: false; titleBarStyle: 'hidden'; hasShadow: false; roundedCorners: true.
	self assert: [ options frame not ].
	self assert: [ options titleBarStyle = 'hidden' ].
	self assert: [ options hasShadow not ].
	self assert: [ options roundedCorners ].

	options transparent: true; backgroundColor: '#FF0000'.
	self assert: [ options transparent ].
	self assert: [ options backgroundColor = '#FF0000' ].
!
testWebPreferences
	| options webPreferences |

	options := BrowserWindowOptions new.
	webPreferences := ElectronWebPreferences new.
	options webPreferences: webPreferences.
	self assert: [ options webPreferences = webPreferences ].
!
testParent
	"A parent window can only be created after the app is ready."
	| parent parentOptions options child |

	ElectronApp new ready ifFalse: [ ^ self ].

	parentOptions := BrowserWindowOptions new show: false.
	parent := ElectronBrowserWindow new: parentOptions.
	options := BrowserWindowOptions new show: false; parent: parent; modal: true.
	self assert: [ options parent = parent ].

	"The options are applied to the created window."
	child := ElectronBrowserWindow new: options.
	self assert: [ child parentWindow = parent ].
	self assert: [ child visible not ].

	child destroy.
	parent destroy.
!
