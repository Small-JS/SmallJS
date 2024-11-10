CLASS MessageEvent  EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS object of creaeting a Worker instance."

CLASSMETHODS

new: type
	^ self fromJs: INLINE 'new MessageEvent( type.js )'.
!
new: type options: options
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
	^ Array fromJs: INLINE 'this.js.ports' elemenClass: MessagePort.
!
source
	"TODO: Implement WindowProxy and ServiceWorker"
	^ MessagePort fromJs: INLINE 'this.js.source'.
!
