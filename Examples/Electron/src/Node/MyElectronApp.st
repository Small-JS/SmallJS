CLASS MyElectronApp EXTENDS ElectronApp MODULE MyElectronMain CLASSVARS ''
	VARS 'browserWindow'

async start
	await self whenReady.
	self setListeners.
	self setMenu.
	self createWindow.
	self loadHtml.

	"Uncomment this to open the devtools in the view."
	"self browserWindow openDevTools."
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

	ElectronMenu setApplicationMenu: mainMenu.
!
onFileExit
	self quit.
!

"Create window"

createWindow
	| webPreferences options  |

	webPreferences := WebPreferences new
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
