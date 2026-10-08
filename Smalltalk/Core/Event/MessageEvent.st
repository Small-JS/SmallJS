CLASS MessageEvent EXTENDS Event MODULE Core CLASSVARS '' VARS ''
	"Encapsulates the JS MessageEvent class:
	 a message received by a target, like a Worker or MessagePort."

CLASSMETHODS

type: type
	^ self fromJs: INLINE 'new MessageEvent( type.js )'.
!
type: type options: options
	"Options is a JsObject with optional keys: data, origin, lastEventId, source, ports."
	^ self fromJs: INLINE 'new MessageEvent( type.js, options.js )'.
!

METHODS

data
	^ JsObject fromJs: INLINE 'this.js.data'.
!
lastEventId
	^ String fromJs: INLINE 'this.js.lastEventId'.
!
origin
	^ String fromJs: INLINE 'this.js.origin'.
!
ports
	"The ports are MessagePorts of the platform (Browser or Node).
	 Use portsAs: to get them as instances of a specific ST class."
	^ self portsAs: EventTarget.
!
portsAs: elementClass
	^ Array fromJs: INLINE 'this.js.ports' elementClass: elementClass.
!
source
	"A MessagePort, WindowProxy or ServiceWorker, or nil."
	^ EventTarget fromJs: INLINE 'this.js.source'.
!
