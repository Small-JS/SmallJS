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
	await self testDialog.
	await self testWebContents.
	await self testContextMenu.
	await self testShell.
	self testWindow.
	self testWindowState.
	self testWindowMenu.
	await self testWindowEventForwarding.
	await self testAboutWindow.

	"A hanging async test stops silently, so log that all live tests have finished."
	self log: 'TestMyElectronApp: Live tests done'.

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
async testDialog
	"Only the async message box can be closed without user interaction, using an AbortSignal.
	 The other dialogs need user interaction, so they are not tested here."
	| controller options result |

	controller := AbortController new.
	options := ElectronMessageBoxOptions message: 'Test message box'.
	options type: 'info'; buttons: #( 'OK' 'Cancel' ); defaultId: 0; cancelId: 1;
		checkboxLabel: 'Check'; checkboxChecked: true; signal: controller signal.
	Timer timeout: 500 then: [ controller abort ].
	result := await ElectronDialog new showMessageBox: options.
	self assert: [ result class = ElectronMessageBoxResult ].
	self assert: [ result response = 1 ].
	self assert: [ result checkboxChecked ].
!
async testWebContents
	"Uses a hidden window with data URL pages, so no page content is shown."
	| options window webContents closed |

	options := BrowserWindowOptions new.
	options atJsProperty: 'show' put: false.
	window := ElectronBrowserWindow new: options.
	webContents := window webContents.
	self assert: [ webContents class = ElectronWebContents ].
	self assert: [ window webContents = webContents ].

	await webContents loadURL: ( self pageUrl: 'One' ).
	self testWebContentsInformation: webContents.
	await self testWebContentsNavigation: webContents.
	await self testWebContentsJavaScript: webContents.
	await self testWebContentsEditing: webContents.
	self testWebContentsSettings: webContents.
	self testWebContentsEvents: webContents.
	await self testWebContentsSaving: webContents.

	"Closing the page also closes the window, asynchronously."
	closed := INLINE 'new Promise( resolve => window.js.once( "closed", resolve ) )'.
	webContents close.
	await closed.
	self assert: [ webContents destroyed ].
	self assert: [ window destroyed ].
!
pageUrl: title
	^ 'data:text/html,<html><head><title>', title, '</title></head><body>', title, '</body></html>'.
!
waitForLoad: webContents
	"Returns a promise that resolves when the next page load has finished.
	 Must be called before starting the navigation that triggers the load."
	^ INLINE 'new Promise( resolve => webContents.js.once( "did-finish-load", resolve ) )'.
!
testWebContentsInformation: webContents
	self assert: [ webContents id class = Integer ].
	self assert: [ ( ElectronWebContents fromId: webContents id ) = webContents ].
	self assert: [ ElectronWebContents all includes: webContents ].
	self assert: [ webContents type = 'window' ].
	self assert: [ webContents title = 'One' ].
	self assert: [ webContents url startsWith: 'data:text/html' ].
	self assert: [ webContents processId class = Integer ].
	self assert: [ webContents osProcessId > 0 ].
	"The loading state may still be updating when loadURL: has resolved."
	self assert: [ webContents loading class = Boolean ].
	self assert: [ webContents loadingMainFrame class = Boolean ].
	self assert: [ webContents waitingForResponse class = Boolean ].
	self assert: [ webContents destroyed not ].
	self assert: [ webContents crashed not ].
	self assert: [ webContents offscreen not ].
	self assert: [ webContents focused class = Boolean ].
!
async testWebContentsNavigation: webContents
	| loaded |

	await webContents loadURL: ( self pageUrl: 'Two' ).
	self assert: [ webContents title = 'Two' ].
	self assert: [ webContents historyLength = 2 ].
	self assert: [ webContents historyActiveIndex = 1 ].
	self assert: [ webContents canGoBack ].
	self assert: [ webContents canGoForward not ].
	self assert: [ webContents canGoToOffset: -1 ].
	self assert: [ ( webContents canGoToOffset: 1 ) not ].

	loaded := self waitForLoad: webContents.
	webContents goBack.
	await loaded.
	self assert: [ webContents title = 'One' ].
	self assert: [ webContents canGoForward ].

	loaded := self waitForLoad: webContents.
	webContents goForward.
	await loaded.
	self assert: [ webContents title = 'Two' ].

	loaded := self waitForLoad: webContents.
	webContents goToOffset: -1.
	await loaded.
	self assert: [ webContents historyActiveIndex = 0 ].

	loaded := self waitForLoad: webContents.
	webContents goToIndex: 1.
	await loaded.
	self assert: [ webContents historyActiveIndex = 1 ].

	loaded := self waitForLoad: webContents.
	webContents reload.
	await loaded.
	self assert: [ webContents title = 'Two' ].

	loaded := self waitForLoad: webContents.
	webContents reloadIgnoringCache.
	await loaded.
	self assert: [ webContents title = 'Two' ].

	webContents clearHistory.
	self assert: [ webContents historyLength = 1 ].
	self assert: [ webContents canGoBack not ].
	webContents stop.
!
async testWebContentsJavaScript: webContents
	| result key |

	result := await webContents executeJavaScript: '1 + 2'.
	self assert: [ result = 3 ].
	result := await webContents executeJavaScript: '"a" + "b"'.
	self assert: [ result = 'ab' ].
	result := await webContents executeJavaScript: 'navigator.userActivation.isActive' userGesture: true.
	self assert: [ result ].

	key := await webContents insertCSS: 'body { color: rgb( 1, 2, 3 ) }'.
	self assert: [ key isEmpty not ].
	result := await webContents executeJavaScript: 'getComputedStyle( document.body ).color'.
	self assert: [ result = 'rgb(1, 2, 3)' ].
	await webContents removeInsertedCSS: key.
	result := await webContents executeJavaScript: 'getComputedStyle( document.body ).color'.
	self assert: [ result = 'rgb(0, 0, 0)' ].
!
async testWebContentsEditing: webContents
	"Uses a focused input element.
	 Note: The edit commands are executed asynchronously in the renderer,
	 so their results are checked after a round trip with executeJavaScript."
	| value |

	await webContents executeJavaScript: 'document.body.innerHTML = "<input id=input>"; input.focus()'.
	await webContents insertText: 'Hello'.
	value := await webContents executeJavaScript: 'input.value'.
	self assert: [ value = 'Hello' ].

	webContents selectAll.
	webContents replace: 'World'.
	value := await webContents executeJavaScript: 'input.value'.
	self assert: [ value = 'World' ].

	webContents selectAll.
	webContents delete.
	value := await webContents executeJavaScript: 'input.value'.
	self assert: [ value isEmpty ].

	webContents undo.
	value := await webContents executeJavaScript: 'input.value'.
	self assert: [ value = 'World' ].
	webContents redo.
	value := await webContents executeJavaScript: 'input.value'.
	self assert: [ value isEmpty ].

	"These need the clipboard or a selection, so only test that the calls succeed."
	webContents unselect; copySelection; cut; paste; pasteAndMatchStyle; replaceMisspelling: 'x';
		scrollToTop; scrollToBottom.
	self assert: [ ( webContents findInPage: 'World' ) class = Integer ].
	webContents stopFindInPage: 'clearSelection'.
!
testWebContentsSettings: webContents
	| userAgent |

	webContents zoomFactor: 1.5.
	self assert: [ webContents zoomFactor = 1.5 ].
	webContents zoomLevel: 1.
	self assert: [ webContents zoomLevel = 1 ].
	webContents zoomLevel: 0.
	self assert: [ webContents zoomFactor = 1 ].

	webContents audioMuted: true.
	self assert: [ webContents audioMuted ].
	webContents audioMuted: false.
	self assert: [ webContents audioMuted not ].
	self assert: [ webContents currentlyAudible not ].

	webContents backgroundThrottling: false.
	self assert: [ webContents backgroundThrottling not ].
	webContents backgroundThrottling: true.
	self assert: [ webContents backgroundThrottling ].

	userAgent := webContents userAgent.
	self assert: [ userAgent isEmpty not ].
	webContents userAgent: 'TestAgent'.
	self assert: [ webContents userAgent = 'TestAgent' ].
	webContents userAgent: userAgent.

	webContents ignoreMenuShortcuts: true; ignoreMenuShortcuts: false.
	self assert: [ webContents devToolsOpened not ].
	self assert: [ webContents devToolsFocused not ].
!
testWebContentsEvents: webContents
	| onCount onceCount received |

	"Emit events directly, as Electron would do."
	onCount := 0.
	onceCount := 0.
	webContents onWebContentsEvent: 'test-event' then: [ :event :data |
		onCount := onCount + 1.
		received := Integer fromJs: data ].
	webContents onceWebContentsEvent: 'test-event' then: [ onceCount := onceCount + 1 ].
	INLINE 'webContents.js.emit( "test-event", {}, 42 )'.
	INLINE 'webContents.js.emit( "test-event", {}, 43 )'.
	self assert: [ onCount = 2 ].
	self assert: [ onceCount = 1 ].
	self assert: [ received = 43 ].
!
async testWebContentsSaving: webContents
	| pdf path |

	pdf := await webContents printToPDF.
	self assert: [ pdf class = Buffer ].
	self assert: [ pdf length > 0 ].

	path := Path join: Os tmpDir with: 'SmallJS-webcontents-save.html'.
	await webContents savePage: path saveType: 'HTMLOnly'.
	self assert: [ Fs existsSync: path ].
	Fs unlinkSync: path.
!
async testContextMenu
	| menu labels color |

	menu := myElectronApp contextMenu.
	labels := Array fromJsStrings: ( INLINE 'menu.js.items.map( item => item.label )' ).
	self assert: [ labels = #( 'Light blue' 'Light green' 'Grey' ) ].

	await myElectronApp pageBackgroundColor: 'lightblue'.
	color := await myElectronApp pageBackgroundColor.
	self assert: [ color = 'lightblue' ].
	await myElectronApp pageBackgroundColor: 'lightgreen'.
	color := await myElectronApp pageBackgroundColor.
	self assert: [ color = 'lightgreen' ].
	await myElectronApp pageBackgroundColor: ''.
	color := await myElectronApp pageBackgroundColor.
	self assert: [ color isEmpty ].
!
async testShell
	"Only methods that do not open external applications are tested here.
	 Note: The trash test leaves a small temp file in the OS trash."
	| shell missingPath path error |

	shell := ElectronShell new.
	missingPath := Path resolve: ( Path join: Os tmpDir with: 'SmallJS-shell-missing.txt' ).

	"Opening a missing file returns an error message, without opening anything."
	error := await shell openPath: missingPath.
	self assert: [ error isEmpty not ].

	"Trashing a file removes it."
	path := Path resolve: ( Path join: Os tmpDir with: 'SmallJS-shell-trash.txt' ).
	Fs writeFileSync: path data: 'Trash me' options: nil.
	self assert: [ Fs existsSync: path ].
	await shell trashItem: path.
	self assert: [ ( Fs existsSync: path ) not ].

	"Trashing a missing file throws an error."
	error := nil.
	await async [ await shell trashItem: missingPath ] tryAwaitCatch: [ :e | error := e ].
	self assert: [ error class = Error ].
!
hiddenWindow
	| options |
	options := BrowserWindowOptions new.
	options atJsProperty: 'show' put: false.
	^ ElectronBrowserWindow new: options.
!
testWindow
	"Uses hidden windows, so the methods that need a visible window are only called.
	 Those can be tested manually with the Window menu of the app."
	| window |

	window := self hiddenWindow.
	self testWindowSizeAndPosition: window.
	self testWindowAppearance: window.
	self testWindowParentAndChild: window.
	self testWindowEvents: window.

	"Visibility & focus"
	self assert: [ window visible not ].
	window hide; blur; focusOnWebView; blurWebView.
	self assert: [ window visible not ].
	self assert: [ window mediaSourceId startsWith: 'window:' ].

	window destroy.
!
testWindowSizeAndPosition: window
	| bounds |

	window size: 640 @ 480.
	self assert: [ window size = ( 640 @ 480 ) ].
	window position: 100 @ 120.
	self assert: [ window position = ( 100 @ 120 ) ].
	window center.
	self assert: [ window position class = Point ].

	bounds := Rect origin: 50 @ 60 extent: 700 @ 500.
	window bounds: bounds.
	self assert: [ window bounds = bounds ].
	self assert: [ window normalBounds = bounds ].

	window contentSize: 600 @ 400.
	self assert: [ window contentSize = ( 600 @ 400 ) ].
	bounds := Rect origin: 80 @ 90 extent: 620 @ 420.
	window contentBounds: bounds.
	self assert: [ window contentBounds = bounds ].

	"Size limits are applied to new sizes. A size of 0 @ 0 removes the limit."
	window minimumSize: 300 @ 200.
	window maximumSize: 900 @ 700.
	self assert: [ window minimumSize = ( 300 @ 200 ) ].
	self assert: [ window maximumSize = ( 900 @ 700 ) ].
	window size: 2000 @ 2000.
	self assert: [ window size = ( 900 @ 700 ) ].
	window size: 100 @ 100.
	self assert: [ window size = ( 300 @ 200 ) ].
	window minimumSize: 0 @ 0.
	window maximumSize: 0 @ 0.
	self assert: [ window minimumSize = ( 0 @ 0 ) ].
	self assert: [ window maximumSize = ( 0 @ 0 ) ].

	"The aspect ratio is only applied when the user resizes the window."
	window aspectRatio: 4.0 / 3.
	window aspectRatio: 0.

	window resizable: false.
	self assert: [ window resizable not ].
	window resizable: true.
	self assert: [ window resizable ].
!
testWindowAppearance: window
	"Opacity is stored with limited precision."
	window opacity: 0.5.
	self assert: [ ( window opacity - 0.5 ) abs < 0.01 ].
	window opacity: 1.
	self assert: [ window opacity = 1 ].

	window shadow: false.
	self assert: [ window shadow not ].
	window shadow: true.
	self assert: [ window shadow ].

	window fullScreenable: false.
	self assert: [ window fullScreenable not ].
	window fullScreenable: true.
	self assert: [ window fullScreenable ].

	"These have no getter, so only test that the calls succeed."
	window progressBar: 0.5; progressBar: -1.
	window flashFrame: true; flashFrame: false.
	window ignoreMouseEvents: true; ignoreMouseEvents: false.
	self assert: [ window destroyed not ].
!
testWindowParentAndChild: window
	| child |

	child := self hiddenWindow.
	self assert: [ child parentWindow isNil ].
	self assert: [ window childWindows isEmpty ].

	child parentWindow: window.
	self assert: [ child parentWindow = window ].
	self assert: [ window childWindows = ( Array with: child ) ].

	child parentWindow: nil.
	self assert: [ child parentWindow isNil ].
	self assert: [ window childWindows isEmpty ].
	child destroy.
!
testWindowEvents: window
	| onCount onceCount |

	"Emit events directly, as Electron would do."
	onCount := 0.
	onceCount := 0.
	window onWindowEvent: 'test-event' then: [ onCount := onCount + 1 ].
	window onceWindowEvent: 'test-event' then: [ onceCount := onceCount + 1 ].
	INLINE 'window.js.emit( "test-event" )'.
	INLINE 'window.js.emit( "test-event" )'.
	self assert: [ onCount = 2 ].
	self assert: [ onceCount = 1 ].
!
testWindowState
	| window bounds state path loaded other |

	window := self hiddenWindow.
	bounds := Rect origin: 60 @ 70 extent: 640 @ 480.
	window bounds: bounds.
	state := MyElectronWindowState fromWindow: window.
	self assert: [ state bounds = bounds ].
	self assert: [ state maximized not ].

	"Save, load and apply to another window."
	path := Path join: Os tmpDir with: 'SmallJS-window-state.json'.
	state save: path.
	loaded := MyElectronWindowState load: path.
	self assert: [ loaded bounds = bounds ].
	self assert: [ loaded maximized not ].
	other := self hiddenWindow.
	loaded applyTo: other.
	self assert: [ other bounds = bounds ].

	"Missing and invalid files are ignored."
	Fs writeFileSync: path data: 'not json' options: nil.
	self assert: [ ( MyElectronWindowState load: path ) isNil ].
	Fs writeFileSync: path data: '{ "x": 1 }' options: nil.
	self assert: [ ( MyElectronWindowState load: path ) isNil ].
	Fs unlinkSync: path.
	self assert: [ ( MyElectronWindowState load: path ) isNil ].

	window destroy.
	other destroy.
!
labelsOf: menu
	^ Array fromJsStrings: ( INLINE 'menu.js.items.map( item => item.label )' ).
!
testWindowMenu
	| menu window received item |

	"Menu structure"
	menu := myElectronApp windowMenuItem submenu.
	self assert: [ ( self labelsOf: menu ) = #( 'Maximize / Restore' 'Minimize' 'Full screen' ''
		'Size' 'Opacity' 'Focus' 'Always on top' 'Shadow' ''
		'Progress demo' 'Hide for 2 seconds' 'Click-through for 3 seconds' '' 'About...' ) ].
	self assert: [ ( self labelsOf: myElectronApp sizeMenu ) = #( '800 x 600' '1200 x 900' 'Center' ''
		'Limit size to 600 x 400 .. 1400 x 1000' 'Aspect ratio 4:3' 'Resizable' ) ].
	self assert: [ ( self labelsOf: myElectronApp opacityMenu ) = #( '100%' '80%' '50%' ) ].
	self assert: [ ( self labelsOf: myElectronApp focusMenu ) = #( 'Blur window' 'Blur web view' 'Focus web view' ) ].

	"Clicking a checkbox item toggles it and passes the new state to the block."
	menu := ElectronMenu new.
	menu append: ( myElectronApp checkboxItem: 'Check' checked: false click: [ :checked | received := checked ] ).
	item := ElectronMenuItem fromJs: ( INLINE 'menu.js.items[ 0 ]' ).
	INLINE 'item.js.click()'.
	self assert: [ received = true ].
	INLINE 'item.js.click()'.
	self assert: [ received = false ].

	"Menu actions on the main window."
	window := myElectronApp browserWindow.
	myElectronApp onSize: 900 @ 700.
	self assert: [ window size = ( 900 @ 700 ) ].
	myElectronApp onLimitSize: true.
	self assert: [ window minimumSize = ( 600 @ 400 ) ].
	self assert: [ window maximumSize = ( 1400 @ 1000 ) ].
	myElectronApp onLimitSize: false.
	self assert: [ window minimumSize = ( 0 @ 0 ) ].
	myElectronApp onSize: 1000 @ 800.

	"Click the 50% opacity radio item, then back to 100%."
	menu := myElectronApp opacityMenu.
	INLINE 'menu.js.items[ 2 ].click()'.
	self assert: [ ( window opacity - 0.5 ) abs < 0.01 ].
	INLINE 'menu.js.items[ 0 ].click()'.
	self assert: [ window opacity = 1 ].
!
async testWindowEventForwarding
	"A window event must be shown in the page."
	| text |

	text := await self emitMoveUntilShown: 50.
	self assert: [ text startsWith: 'move (' ].
!
async emitMoveUntilShown: tries
	"The page may not listen yet, so the event is emitted until it is shown or the tries are used up."
	| window text |

	window := myElectronApp browserWindow.
	INLINE 'window.js.emit( "move" )'.
	await Timer timeout: 100.
	text := await window webContents executeJavaScript:
		'document.getElementById( "windowEventSpan" ).textContent'.
	( ( text startsWith: 'move (' ) or: [ tries <= 1 ] ) ifTrue: [ ^ text ].
	^ await self emitMoveUntilShown: tries - 1.
!
async testAboutWindow
	"Opens the modal about window, waits until it is shown and closes it."
	| window about closed |

	window := myElectronApp browserWindow.
	myElectronApp onAbout.
	about := myElectronApp aboutWindow.
	self assert: [ about class = ElectronBrowserWindow ].
	self assert: [ about parentWindow = window ].
	self assert: [ window childWindows = ( Array with: about ) ].
	self assert: [ about modal ].
	self assert: [ about resizable not ].

	"Only one about window can be open."
	myElectronApp onAbout.
	self assert: [ myElectronApp aboutWindow = about ].

	await self waitUntilVisible: about tries: 50.
	self assert: [ about visible ].
	self assert: [ about webContents url endsWith: 'about.html' ].

	closed := INLINE 'new Promise( resolve => about.js.once( "closed", resolve ) )'.
	about close.
	await closed.
	self assert: [ window childWindows isEmpty ].
!
async waitUntilVisible: window tries: tries
	( window visible or: [ tries <= 0 ] ) ifTrue: [ ^ self ].
	await Timer timeout: 100.
	await self waitUntilVisible: window tries: tries - 1.
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
