CLASS MyElectronApp EXTENDS ElectronApp MODULE MyElectronMain CLASSVARS ''
	VARS 'browserWindow aboutWindow'

async start
	await self whenReady.
	self setListeners.
	self setMenu.
	self createWindow.
	self restoreWindowState.
	self forwardWindowEvents.
	self setContextMenu.
	self loadHtml.

	"Uncomment this to open the browser devtools in the view:"
	"browserWindow openDevTools."
!

"Listeners"

setListeners
	self on: 'setTitle' then: [ :event :title | self onSetTitle: title ].
	self handle: 'ping' then: [ :event :data | self onPing: data ].
	self on: 'quit' then: [ self onQuit ].
!
onSetTitle: title
	self log: 'MyElectronApp: Received new title: ', title.
	browserWindow title: title.
!
onPing: data
	| result |
	self log: 'MyElectronApp: Received ping with data: ', data.

	result := 'Pong'.
	self log: 'MyElectronApp: Replying with result data: ', result.
	^ result.
!
async onQuit
	self log: 'MyElectronApp: Received quit request.'.
	await Timer timeout: 1000.
	self quit.
!

"Menu"

setMenu
	| mainMenu mainFileMenuItem fileMenu fileExitMenuItem |

	fileExitMenuItem := ElectronMenuItemOptions new
		label: 'Exit';
		click: [ self onFileExit ].
	fileMenu := ElectronMenu new.
	fileMenu append: fileExitMenuItem.

	mainFileMenuItem := ElectronMenuItemOptions new
		label: 'File';
		submenu: fileMenu.
	mainMenu := ElectronMenu new.
	mainMenu append: mainFileMenuItem.
	mainMenu append: self windowMenuItem.
	mainMenu append: self dialogMenuItem.

	ElectronMenu applicationMenu: mainMenu.
!
onFileExit
	self quit.
!

"Menu items"

item: label click: block
	^ ElectronMenuItemOptions new label: label; click: block.
!
item: label submenu: submenu
	^ ElectronMenuItemOptions new label: label; submenu: submenu.
!
checkboxItem: label checked: checked click: block
	"The block receives the new checked state."
	^ ElectronMenuItemOptions new label: label; type: 'checkbox'; checked: checked;
		click: [ :menuItem | block value: ( ElectronMenuItem fromJs: menuItem ) checked ].
!
radioItem: label checked: checked click: block
	"Radio items next to each other in a menu form a group."
	^ ElectronMenuItemOptions new label: label; type: 'radio'; checked: checked; click: block.
!
separatorItem
	^ ElectronMenuItemOptions new type: 'separator'.
!

"Dialog menu
 For manual testing of ElectronDialog, results are logged to the console."

dialogMenuItem
	| dialogMenu |

	dialogMenu := ElectronMenu new.
	dialogMenu append: ( self item: 'Open...' click: [ self onDialogOpen ] ).
	dialogMenu append: ( self item: 'Save...' click: [ self onDialogSave ] ).
	dialogMenu append: ( self item: 'Message...' click: [ self onDialogMessage ] ).
	dialogMenu append: ( self item: 'Error...' click: [ self onDialogError ] ).
	^ self item: 'Dialog' submenu: dialogMenu.
!
fileFilters
	^ Array
		with: ( ElectronFileFilter name: 'Text files' extensions: #( 'txt' 'md' ) )
		with: ( ElectronFileFilter name: 'All files' extensions: #( '*' ) ).
!
async onDialogOpen
	| options result |

	options := ElectronFileDialogOptions new
		title: 'Open test';
		defaultPath: ( self path: 'documents' );
		buttonLabel: 'Open it';
		filters: self fileFilters;
		properties: #( 'openFile' 'multiSelections' ).
	result := await ElectronDialog new showOpenDialog: options window: browserWindow.
	self log: 'MyElectronApp: Open dialog canceled: ', result canceled toString,
		', file paths: ', result filePaths toString.
!
async onDialogSave
	| options result |

	options := ElectronFileDialogOptions new
		title: 'Save test';
		defaultPath: ( Path join: ( self path: 'documents' ) with: 'test.txt' );
		buttonLabel: 'Save it';
		filters: self fileFilters;
		properties: #( 'showOverwriteConfirmation' ).
	result := await ElectronDialog new showSaveDialog: options window: browserWindow.
	self log: 'MyElectronApp: Save dialog canceled: ', result canceled toString,
		', file path: ', result filePath.
!
async onDialogMessage
	| options result |

	options := ElectronMessageBoxOptions new
		message: 'Test message';
		type: 'question';
		title: 'Message test';
		detail: 'Choose a button and check the checkbox.';
		buttons: #( 'Yes' 'No' 'Cancel' );
		defaultId: 0;
		cancelId: 2;
		checkboxLabel: 'Checkbox';
		checkboxChecked: false.
	result := await ElectronDialog new showMessageBox: options window: browserWindow.
	self log: 'MyElectronApp: Message box response: ', result response toString,
		', checkbox checked: ', result checkboxChecked toString.
!
onDialogError
	ElectronDialog new showErrorBox: 'Error test' content: 'This is a test error message.'.
	self log: 'MyElectronApp: Error box closed.'.
!

"Window menu
 For manual testing of ElectronBaseWindow and ElectronBrowserWindow, results are logged to the console.
 Note: The menu is created before the window, so the blocks must not use the window directly."

windowMenuItem
	| menu |

	menu := ElectronMenu new.
	menu append: ( self item: 'Maximize / Restore' click: [ self onToggleMaximize ] ).
	menu append: ( self item: 'Minimize' click: [ browserWindow minimize ] ).
	menu append: ( ( self item: 'Full screen' click: [ self onToggleFullScreen ] ) accelerator: 'F11' ).
	menu append: self separatorItem.
	menu append: ( self item: 'Size' submenu: self sizeMenu ).
	menu append: ( self item: 'Opacity' submenu: self opacityMenu ).
	menu append: ( self item: 'Focus' submenu: self focusMenu ).
	menu append: ( self checkboxItem: 'Always on top' checked: false click: [ :checked |
		browserWindow alwaysOnTop: checked.
		self log: 'MyElectronApp: Always on top: ', browserWindow alwaysOnTop toString ] ).
	menu append: ( self checkboxItem: 'Shadow' checked: true click: [ :checked |
		browserWindow shadow: checked.
		self log: 'MyElectronApp: Shadow: ', browserWindow shadow toString ] ).
	menu append: self separatorItem.
	menu append: ( self item: 'Progress demo' click: [ self onProgressDemo ] ).
	menu append: ( self item: 'Hide for 2 seconds' click: [ self onHideDemo ] ).
	menu append: ( self item: 'Click-through for 3 seconds' click: [ self onClickThroughDemo ] ).
	menu append: self separatorItem.
	menu append: ( self item: 'About...' click: [ self onAbout ] ).
	^ self item: 'Window' submenu: menu.
!
sizeMenu
	| menu |

	menu := ElectronMenu new.
	menu append: ( self item: '800 x 600' click: [ self onSize: 800 @ 600 ] ).
	menu append: ( self item: '1200 x 900' click: [ self onSize: 1200 @ 900 ] ).
	menu append: ( self item: 'Center' click: [ browserWindow center ] ).
	menu append: self separatorItem.
	menu append: ( self checkboxItem: 'Limit size to 600 x 400 .. 1400 x 1000' checked: false
		click: [ :checked | self onLimitSize: checked ] ).
	menu append: ( self checkboxItem: 'Aspect ratio 4:3' checked: false click: [ :checked |
		browserWindow aspectRatio: ( checked ifTrue: [ 4.0 / 3 ] ifFalse: [ 0 ] ) ] ).
	menu append: ( self checkboxItem: 'Resizable' checked: true click: [ :checked |
		browserWindow resizable: checked ] ).
	^ menu.
!
opacityMenu
	| menu |

	menu := ElectronMenu new.
	#( 100 80 50 ) do: [ :percentage |
		menu append: ( self radioItem: percentage toString, '%' checked: percentage = 100
			click: [ browserWindow opacity: percentage toFloat / 100 ] ) ].
	^ menu.
!
focusMenu
	| menu |

	menu := ElectronMenu new.
	menu append: ( self item: 'Blur window' click: [ browserWindow blur. self logFocus ] ).
	menu append: ( self item: 'Blur web view' click: [ browserWindow blurWebView. self logFocus ] ).
	menu append: ( self item: 'Focus web view' click: [ browserWindow focusOnWebView. self logFocus ] ).
	^ menu.
!
logFocus
	self log: 'MyElectronApp: Window focused: ', browserWindow focused toString,
		', web view focused: ', browserWindow webContents focused toString.
!
onToggleMaximize
	browserWindow maximized
		ifTrue: [ browserWindow unmaximize ]
		ifFalse: [ browserWindow maximize ].
!
onToggleFullScreen
	browserWindow fullScreen: browserWindow fullScreen not.
!
onSize: size
	browserWindow maximized ifTrue: [ browserWindow unmaximize ].
	browserWindow size: size.
	browserWindow center.
	self log: 'MyElectronApp: Window bounds: ', browserWindow bounds toString,
		', content size: ', browserWindow contentSize toString.
!
onLimitSize: limit
	"A size of 0 @ 0 removes the limit."
	limit
		ifTrue: [
			browserWindow minimumSize: 600 @ 400.
			browserWindow maximumSize: 1400 @ 1000 ]
		ifFalse: [
			browserWindow minimumSize: 0 @ 0.
			browserWindow maximumSize: 0 @ 0 ].
	self log: 'MyElectronApp: Minimum size: ', browserWindow minimumSize toString,
		', maximum size: ', browserWindow maximumSize toString.
!
onProgressDemo
	"Shows progress on the taskbar button and in the window title for 5 seconds.
	 Then flashes the taskbar button until the window gets focus again."
	| title step timer |

	self log: 'MyElectronApp: Progress demo started, see the taskbar button and window title.'.
	title := browserWindow title.
	step := 0.
	timer := Timer interval: 500 then: [
		step := step + 1.
		step <= 10
			ifTrue: [
				browserWindow progressBar: step toFloat / 10.
				browserWindow title: title, ' - Progress ', ( step * 10 ) toString, '%' ]
			ifFalse: [
				timer clearInterval.
				browserWindow progressBar: -1.
				browserWindow title: title.
				self flashUntilFocused ] ].
!
flashUntilFocused
	"The OS only flashes a window that does not have focus,
	 so if the window has focus, flashing starts when it loses focus."
	browserWindow focused
		ifTrue: [
			self log: 'MyElectronApp: Progress demo done, switch to another window to see the taskbar button flash.'.
			browserWindow onceWindowEvent: 'blur' then: [ self flashUntilFocused ] ]
		ifFalse: [
			browserWindow flashFrame: true.
			browserWindow onceWindowEvent: 'focus' then: [ browserWindow flashFrame: false ] ].
!
async onHideDemo
	browserWindow hide.
	self log: 'MyElectronApp: Window visible: ', browserWindow visible toString.
	await Timer timeout: 2000.
	browserWindow showInactive.
	self log: 'MyElectronApp: Window visible: ', browserWindow visible toString,
		', focused: ', browserWindow focused toString.
!
async onClickThroughDemo
	"Mouse clicks go to the window below, e.g. the desktop."
	browserWindow ignoreMouseEvents: true.
	await Timer timeout: 3000.
	browserWindow ignoreMouseEvents: false.
	self log: 'MyElectronApp: Mouse events restored'.
!

"About window"

onAbout
	"Shows a modal child window. Only one can be open."
	| options |

	( aboutWindow notNil and: [ aboutWindow destroyed not ] ) ifTrue: [ ^ aboutWindow focus ].

	options := BrowserWindowOptions new
		width: 460;
		height: 240;
		resizable: false;
		parent: browserWindow;
		modal: true;
		show: false.
	aboutWindow := ElectronBrowserWindow new: options.
	aboutWindow onceWindowEvent: 'ready-to-show' then: [
		aboutWindow show.
		aboutWindow moveTop ].
	aboutWindow loadFile: 'about.html'
		then: [ self log: 'MyElectronApp: About window opened, child windows: ',
			browserWindow childWindows length toString ]
		error: [ :error | self log: error ].
!

"Context menu"

setContextMenu
	browserWindow webContents onWebContentsEvent: 'context-menu' then: [ self contextMenu popup ].
!
contextMenu
	| menu |

	menu := ElectronMenu new.
	menu append: ( self item: 'Light blue' click: [ self pageBackgroundColor: 'lightblue' ] ).
	menu append: ( self item: 'Light green' click: [ self pageBackgroundColor: 'lightgreen' ] ).
	menu append: ( self item: 'Grey' click: [ self pageBackgroundColor: '' ] ).
	^ menu.
!
async pageBackgroundColor: color
	"An empty color resets the background to the grey of the style sheet."
	await browserWindow webContents executeJavaScript: 'document.body.style.backgroundColor = "', color, '"'.
!
async pageBackgroundColor
	^ await browserWindow webContents executeJavaScript: 'document.body.style.backgroundColor'.
!

"Create window"

createWindow
	| webPreferences options  |

	webPreferences := ElectronWebPreferences new
		nodeIntegration: true;
		nodeIntegrationInWorker: true;
		nodeIntegrationInSubFrames: true;
		contextIsolation: true;
		sandbox: false;
		preload: ( Path resolve: 'preload.mjs' ).

	options := BrowserWindowOptions new
		width: 1000;
		height: 800;
		webPreferences: webPreferences.

	browserWindow := ElectronBrowserWindow new: options.
!

"Window state"

windowStatePath
	^ Path join: ( self path: 'userData' ) with: 'window-state.json'.
!
restoreWindowState
	"Restores the window bounds of the previous run, and saves them when the window closes.
	 Not in test mode, so the tests always start with the same window."
	| state |

	self testMode ifTrue: [ ^ self ].
	state := MyElectronWindowState load: self windowStatePath.
	state notNil ifTrue: [ state applyTo: browserWindow ].
	browserWindow onWindowEvent: 'close' then: [
		( MyElectronWindowState fromWindow: browserWindow ) save: self windowStatePath ].
!

"Window events"

windowEvents
	^ #( 'focus' 'blur' 'show' 'hide' 'maximize' 'unmaximize' 'minimize' 'restore'
		'resize' 'move' 'enter-full-screen' 'leave-full-screen' ).
!
forwardWindowEvents
	"Sends the window events to the page, which shows the last one."
	self windowEvents do: [ :name |
		browserWindow onWindowEvent: name then: [ self sendWindowEvent: name ] ].
!
sendWindowEvent: name
	"Events can still arrive while the window is closing."
	( browserWindow destroyed or: [ browserWindow webContents destroyed ] ) ifTrue: [ ^ self ].
	browserWindow webContents send: 'windowEvent' with: name.
!

"HTML"

loadHtml
	browserWindow loadFile: 'index.html' options: self loadOptions
		then: [ self log: 'MyElectronApp: HTML file loaded in browser window' ]
		error: [ :error | self log: error ].
!
loadOptions
	| options |
	options := ElectronLoadFileOptions new.
	self testMode ifTrue: [
		options search: '?test' ].
	^ options.
!

"Accessing - Used by tests"

browserWindow
	^ browserWindow.
!
aboutWindow
	^ aboutWindow.
!
