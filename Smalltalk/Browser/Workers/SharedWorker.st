CLASS SharedWorker EXTENDS EventTarget MODULE Browser CLASSVARS '' VARS ''

"Implements JS SharedWorker: a worker that can be accessed from multiple browsing contexts,
 like windows, iframes or other workers, from the same origin.
 Communication goes through its MessagePort, returned by: port."

CLASSMETHODS

new: url
	^ self fromJs: INLINE 'new SharedWorker( url.js )'.
!
new: url name: name
	"Connects to an existing shared worker with the same url and name, or creates a new one."
	^ self fromJs: INLINE 'new SharedWorker( url.js, name.js )'.
!
new: url options: options
	^ self fromJs: INLINE 'new SharedWorker( url.js, options.js )'.
!

METHODS

port
	"The MessagePort used to communicate with the shared worker."
	^ MessagePort fromJs: INLINE 'this.js.port'.
!
onError: block
	"Called when an error occurs in the worker script, including failing to load it.
	 Block argument is an ErrorEvent, or an Event if the browser does not provide details."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJsSubEvent: jsEvent ) ].
	INLINE 'this.js.onerror = jsBlock.js'.
!
