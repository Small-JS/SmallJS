CLASS MyElectronApp EXTENDS ElectronApp MODULE MyElectronMain CLASSVARS ''
	VARS 'browserWindow'

start
self log: 'Testmode: ', self testMode toString.
	self whenReady: [ self start2 ].
!
start2
	self setListeners.
	self setMenu.
	self createWindow.
	self loadHtml.
	self openDevTools.

	self testMode ifTrue: [
		TestMyElectronApp new test: self ].
!

"Listeners"

setListeners
	self on: 'setTitle' then: [ :event :title | self onSetTitle: title ].
	self handle: 'ping' then: [ :event :data | self onPing: data ].
	self on: 'quit' then: [ self onQuit ].
!
onSetTitle: title
	self log: 'MyElectronApp: Received new title: ', title.
	browserWindow setTitle: title.
!
onPing: data
	| result |
	self log: 'MyElectronApp: Received ping with data: ', data.

	result := 'Pong'.
	self log: 'MyElectronApp: Replying with result data: ', result.
	^ result.
!
onQuit
	self log: 'MyElectronApp: Received quit request.'.
	Timer timeout: 1000 then: [
		self quit ].
!

"Menu"

setMenu
	| fileMenu mainMenu |

	fileMenu := ElectronMenu new.
	fileMenu append: ( ElectronMenuItemOptions new label: 'Exit'; click: [ self onFileExit ] ).

	mainMenu := ElectronMenu new.
	mainMenu append: ( ElectronMenuItemOptions new label: 'File'; submenu: fileMenu ).

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

	browserWindow := BrowserWindow new: options.
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

"Testing"

openDevTools
	browserWindow openDevTools.
!

