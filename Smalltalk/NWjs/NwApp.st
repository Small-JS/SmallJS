CLASS NwApp EXTENDS JsObject MODULE Nwjs CLASSVARS '' VARS ''

INLINE 'let gui = require( "nw.gui" );'

CLASSMETHODS

new
	^ self fromJs: INLINE 'gui.App'.
!

METHODS

"Properties"

argv
	^ Array fromJsStrings: INLINE 'this.js.argv'.
!
fullArgv
	^ Array fromJsStrings: INLINE 'this.js.fullArgv'.
!
testMode
	^ self argv includes: '-test'.
!
dataPath
	^ String fromJs: INLINE 'this.js.dataPath'.
!
manifest
	^ NwManifest fromJs: INLINE 'this.js.manifest'.
!
window
	"Return the default window for the app."
	^ NwWindow get.
!
"Running"

closeAllWindows
	INLINE 'this.js.closeAllWindows()'.
!
quit
	INLINE 'this.js.quit()'.
!
clearCache
	INLINE 'this.js.clearCache()'.
!
getProxyForUrl: url
	^ String fromJs: INLINE 'this.js.getProxyForURL( url.js )'.
!
addOriginAccessWhitelistEntry: sourceOrigin destinationProtocol: destinationProtocol destinationHost: destinationHost
	allowDestinationSubdomains: allowDestinationSubdomains
	INLINE 'this.js.addOriginAccessWhitelistEntry( sourceOrigin.js, destinationProtocol.js, destinationHost.js, allowDestinationSubdomains.js )'.
!
removeOriginAccessWhitelistEntry: sourceOrigin destinationProtocol: destinationProtocol destinationHost: destinationHost
	allowDestinationSubdomains: allowDestinationSubdomains
	INLINE 'this.js.removeOriginAccessWhitelistEntry( sourceOrigin.js, destinationProtocol.js, destinationHost.js, allowDestinationSubdomains.js )'.
!

"Shortcuts"

"Note:
The NW.js class Shortcut is not implemented because
it is only used in these 2 methods and complicates things unnecessarily."

registerGlobalHotKey: key then: block error: errorBlock
	INLINE '
		let shortcutOption = { "key": key.js,
			"active": function () { block.js() },
			"failed": function ( message ) { errorBlock.$value$( stString$class.$fromJs$( message ) ) } };
		this.js.registerGlobalHotKey( new gui.Shortcut( shortcutOption ) )'.
!
unregisterGlobalHotKey: key then: block error: errorBlock
	INLINE '
		let shortcutOption = { "key": key.js,
			"active": function () { block.js() },
			"failed": function ( message ) { errorBlock.$value$( stString$class.$fromJs$( message ) ) } };
		this.js.unregisterGlobalHotKey( new gui.Shortcut( shortcutOption ) )'.
!
