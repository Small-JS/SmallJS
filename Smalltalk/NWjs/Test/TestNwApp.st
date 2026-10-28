CLASS TestNwApp EXTENDS Test MODULE TestNwjs CLASSVARS '' VARS 'app'

"Also tests NwManifest"

test
	| manifest hotKey |

	app := NwApp new.
	self assert: [ app class = NwApp ].

	app clearCache.
	self assert: [ app argv includes: '-test' ].
	self assert: [ app fullArgv includes: '-test' ].
	self assert: [ app dataPath includes: 'my-nw-app' ].

	"'app quit' cannot be tested here."
	self assert: [ ( app getProxyForUrl: 'localhost:8080' ) = 'DIRECT' ].

	app addOriginAccessWhitelistEntry: 'http://github.com/'
		destinationProtocol: 'chrome-extension' destinationHost: 'http://localhost'
		allowDestinationSubdomains: true.

	app removeOriginAccessWhitelistEntry: 'http://github.com/'
		destinationProtocol: 'chrome-extension' destinationHost: 'http://localhost'
		allowDestinationSubdomains: true.

	"Manifest"

	manifest := app manifest.
	self assert: [ manifest class = NwManifest ].
	self assert: [ manifest name = 'my-nw-app' ].
	self assert: [ manifest main endsWith: 'index.html' ].

	"Hotkey"

	"The then: block is only evaluated when the user presses the hotkey,
	 so only registering and unregistering it is tested here.
	 Failing to register is not a test failure, because the OS can reserve the hotkey."
	hotKey := 'Ctrl+Shift+A'.
	app registerGlobalHotKey: hotKey
		then: [ ]
		error: [ :message | ].
	app unregisterGlobalHotKey: hotKey.

	"closeAllWindows cannot be tested here because it terminates the app."
	"app closeAllWindows."
!
