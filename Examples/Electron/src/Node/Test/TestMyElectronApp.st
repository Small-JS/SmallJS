CLASS TestMyElectronApp EXTENDS Object MODULE TestMyElectronMain CLASSVARS ''
	VARS 'myElectronApp'

"Test ShopServer units and API.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	myElectronApp := MyElectronApp new.
	await myElectronApp start.

	"For import of ElectromMain module."
	TestElectronApp.

	"The method 'all' will test all imported test classes, so only need to run it once."
	Test all.

	"Test ElectronApp functionality in Node."
	await self testApp.
	self testMenu.

	"Note: GUI testing is done in class TestMyElectronView."
!
async testApp
	"Note: Methods that quit or restart the app are not tested here."

	self assert: [ myElectronApp ready ].
	self assert: [ myElectronApp testMode ].

	self testFocus.
	self testLocales.
	self testPaths.
	self testSingleInstanceLock.
	self testProtocol.
	await self testProxy.
	self testAppEvents.
	self testHardwareAcceleration.
!
testMenu
	| menu first second item labels |

	first := ElectronMenuItemOptions new label: 'First'; id: 'first'.
	second := ElectronMenuItemOptions new label: 'Second'; id: 'second'.

	menu := ElectronMenu new.
	menu append: second.
	menu insert: first position: 0.

	"Insert must put the item at the given position."
	labels := Array fromJsStrings: ( INLINE 'menu.js.items.map( item => item.label )' ).
	self assert: [ labels = #( 'First' 'Second' ) ].

	item := menu menuItemById: 'second'.
	self assert: [ item class = ElectronMenuItem ].
	self assert: [ item label = 'Second' ].
	self assert: [ ( menu menuItemById: 'none' ) isNil ].

	self testMenuItem.
	self testMenuItemOptions.
!
testMenuItemOptions
	| options menu item template labels |

	"Unset properties"
	options := ElectronMenuItemOptions new.
	self assert: [ options id isNil ].
	self assert: [ options checked isNil ].
	self assert: [ options icon isNil ].
	self assert: [ options before isNil ].

	self assert: [ options label isNil ].
	self assert: [ options enabled isNil ].
	self assert: [ options submenu isNil ].

	"Getters and setters"
	options role: 'copy'; type: 'normal'; label: 'Label';
		accelerator: 'CmdOrCtrl+K'; enabled: false; visible: true.
	self assert: [ options role = 'copy' ].
	self assert: [ options type = 'normal' ].
	self assert: [ options label = 'Label' ].
	self assert: [ options accelerator = 'CmdOrCtrl+K' ].
	self assert: [ options enabled = false ].
	self assert: [ options visible = true ].
	menu := ElectronMenu new.
	options submenu: menu.
	self assert: [ options submenu = menu ].

	options := ElectronMenuItemOptions new.
	options id: 'check'; checked: true; icon: 'icon.png'.
	self assert: [ options id = 'check' ].
	self assert: [ options checked ].
	self assert: [ options icon = 'icon.png' ].
	options before: #( 'a' ); after: #( 'b' 'c' ); beforeGroupContaining: #( 'd' ); afterGroupContaining: #( 'e' ).
	self assert: [ options before = #( 'a' ) ].
	self assert: [ options after = #( 'b' 'c' ) ].
	self assert: [ options beforeGroupContaining = #( 'd' ) ].
	self assert: [ options afterGroupContaining = #( 'e' ) ].

	"Options are applied to the created item.
	 Note: The icon is not applied here, because the file must exist."
	options := ElectronMenuItemOptions new label: 'Check'; type: 'checkbox'; id: 'check'; checked: true.
	menu := ElectronMenu new.
	menu append: options.
	item := menu menuItemById: 'check'.
	self assert: [ item label = 'Check' ].
	self assert: [ item checked ].

	"Positioning is applied when building a menu from a template.
	 Note: ElectronMenu does not implement buildFromTemplate yet, so call it via JS."
	template := Array new.
	template add: ( ElectronMenuItemOptions new label: 'A'; id: 'a' ).
	template add: ( ElectronMenuItemOptions new label: 'B'; id: 'b'; before: #( 'a' ) ).
	menu := ElectronMenu fromJs: ( INLINE 'menu.js.constructor.buildFromTemplate( template.js.map( options => options.js ) )' ).
	labels := Array fromJsStrings: ( INLINE 'menu.js.items.map( item => item.label )' ).
	self assert: [ labels = #( 'B' 'A' ) ].

	template := Array new.
	template add: ( ElectronMenuItemOptions new label: 'A'; id: 'a'; after: #( 'b' ) ).
	template add: ( ElectronMenuItemOptions new label: 'B'; id: 'b' ).
	menu := ElectronMenu fromJs: ( INLINE 'menu.js.constructor.buildFromTemplate( template.js.map( options => options.js ) )' ).
	labels := Array fromJsStrings: ( INLINE 'menu.js.items.map( item => item.label )' ).
	self assert: [ labels = #( 'B' 'A' ) ].
!
testMenuItem
	| menu subMenu options item parent clicked |

	"Writable properties"
	options := ElectronMenuItemOptions new label: 'Check'; type: 'checkbox'; accelerator: 'CmdOrCtrl+K'.
	menu := ElectronMenu new.
	menu append: options.
	item := menu menuItemById: 'none'.
	self assert: [ item isNil ].
	item := ElectronMenuItem fromJs: ( INLINE 'menu.js.items[ 0 ]' ).

	item id: 'check'.
	self assert: [ item id = 'check' ].
	self assert: [ ( menu menuItemById: 'check' ) label = 'Check' ].
	item label: 'Check 2'.
	self assert: [ item label = 'Check 2' ].
	item enabled: false.
	self assert: [ item enabled not ].
	item enabled: true.
	self assert: [ item enabled ].
	item visible: false.
	self assert: [ item visible not ].
	item visible: true.
	self assert: [ item visible ].
	item checked: true.
	self assert: [ item checked ].
	item checked: false.
	self assert: [ item checked not ].
	self assert: [ item icon isNil ].

	"Read-only properties"
	self assert: [ item type = 'checkbox' ].
	self assert: [ item role isNil ].
	self assert: [ item accelerator = 'CmdOrCtrl+K' ].
	self assert: [ item commandId class = Integer ].
	self assert: [ item menu = menu ].
	self assert: [ item submenu isNil ].

	"Submenu"
	subMenu := ElectronMenu new.
	subMenu append: ( ElectronMenuItemOptions new label: 'Child' ).
	menu append: ( ElectronMenuItemOptions new label: 'Parent'; submenu: subMenu ).
	parent := ElectronMenuItem fromJs: ( INLINE 'menu.js.items[ 1 ]' ).
	self assert: [ parent type = 'submenu' ].
	self assert: [ parent submenu = subMenu ].

	"Click: Invoke the JS click function directly, as a user would do."
	clicked := false.
	item click: [ clicked := true ].
	INLINE 'item.js.click()'.
	self assert: [ clicked ].
!
testFocus
	"Actual focus is decided by the OS, so only test that the call succeeds."
	myElectronApp focus.
	self assert: [ myElectronApp ready ].
!
testLocales
	"Locales are only valid after the app is ready."
	self assert: [ myElectronApp locale isEmpty not ].
	self assert: [ myElectronApp systemLocale isEmpty not ].
	self assert: [ myElectronApp localeCountryCode class = String ].
	self assert: [ myElectronApp preferredSystemLanguages isEmpty not ].
!
testPaths
	| tempPath sessionDataPath logsPath |

	self assert: [ myElectronApp appPath isEmpty not ].
	#( 'home' 'appData' 'userData' 'sessionData' 'temp' 'exe' 'module' 'logs' ) do: [ :name |
		self assert: [ ( myElectronApp path: name ) isEmpty not ] ].

	"Set path to an existing directory and restore it."
	tempPath := myElectronApp path: 'temp'.
	sessionDataPath := myElectronApp path: 'sessionData'.
	myElectronApp path: 'sessionData' path: tempPath.
	self assert: [ ( myElectronApp path: 'sessionData' ) = tempPath ].
	myElectronApp path: 'sessionData' path: sessionDataPath.
	self assert: [ ( myElectronApp path: 'sessionData' ) = sessionDataPath ].

	"Set logs path and restore it."
	logsPath := myElectronApp path: 'logs'.
	myElectronApp appLogsPath: tempPath.
	self assert: [ ( myElectronApp path: 'logs' ) = tempPath ].
	myElectronApp appLogsPath: logsPath.
	self assert: [ ( myElectronApp path: 'logs' ) = logsPath ].
	myElectronApp appLogsPath.
	self assert: [ ( myElectronApp path: 'logs' ) isEmpty not ].
!
testSingleInstanceLock
	| hasLock |

	"The lock is not obtained if another instance of the app is running."
	hasLock := myElectronApp requestSingleInstanceLock.
	self assert: [ myElectronApp hasSingleInstanceLock = hasLock ].
	myElectronApp releaseSingleInstanceLock.
	self assert: [ myElectronApp hasSingleInstanceLock not ].
!
testProtocol
	"The result depends on the installed applications, so can be empty."
	self assert: [ ( myElectronApp applicationNameForProtocol: 'https://' ) class = String ].
!
async testProxy
	| proxy |
	proxy := await myElectronApp resolveProxy: 'https://www.example.com'.
	self assert: [ proxy isEmpty not ].
!
testAppEvents
	| options window onceCount onCount |

	"Creating a hidden window triggers event 'browser-window-created'."
	onceCount := 0.
	onCount := 0.
	myElectronApp onceAppEvent: 'browser-window-created' then: [ onceCount := onceCount + 1 ].
	myElectronApp onAppEvent: 'browser-window-created' then: [ onCount := onCount + 1 ].

	options := BrowserWindowOptions new.
	options atJsProperty: 'show' put: false.

	window := ElectronBrowserWindow new: options.
	window destroy.
	window := ElectronBrowserWindow new: options.
	window destroy.

	self assert: [ onceCount = 1 ].
	self assert: [ onCount = 2 ].
!
testHardwareAcceleration
	"Enabled by default, because this app does not call #disableHardwareAcceleration.
	 That can only be called before the app is ready, so it is not tested here."
	self assert: [ myElectronApp hardwareAccelerationEnabled ].
!
