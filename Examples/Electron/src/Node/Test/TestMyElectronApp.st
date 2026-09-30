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
