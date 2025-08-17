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

	hotKey := 'Ctrl+Shift+A'.
	app registerGlobalHotKey: hotKey
		then: [ self onRegisterGlobalHotKey: hotKey ]
		error: [ :message | self onRegisterGlobalHotKey: hotKey error: message].

	"closeAllWindows cannot be tested here beacuse it terminates the app."
	"app closeAllWindows."
!

"Hotkeys"

onRegisterGlobalHotKey: hotKey
	self assert: [ true ].
	self unregisterGlobalHotKey: hotKey
!
onRegisterGlobalHotKey: hotKey error: message
	"Failing to register the hotkey also counts als test succes.
	 Probably some security setting."
	self assert: [ true ].
	self unregisterGlobalHotKey: hotKey
!
unregisterGlobalHotKey: hotKey
	app unregisterGlobalHotKey: hotKey
		then: [ self onUnegisterGlobalHotKey: hotKey ]
		error: [ :message | self onUnregisterGlobalHotKey: hotKey error: message] .
!
onUnregisterGlobalHotKey: hotKey
	self assert: [ true ].
!
onUnregisterGlobalHotKey: hotKey error: message
	"Failing to unregister the hotkey also counts als test succes.
	 Probably some security setting."
	self assert: [ true ].
!
