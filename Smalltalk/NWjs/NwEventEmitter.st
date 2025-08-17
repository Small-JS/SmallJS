CLASS NwEventEmitter EXTENDS JsObject MODULE Nwjs CLASSVARS '' VARS ''

"declare class EventEmitter implements IEventEmitter {
    addListener(event: string, listener: Function): EventEmitter;
    on(event: string, listener: Function): EventEmitter;
    once(event: string, listener: Function): EventEmitter;
    removeListener(event: string, listener: Function): EventEmitter;
    removeAllListeners(event?: string): EventEmitter;
    setMaxListeners(n: number): void;
    listeners(event: string): Function[];
    emit(event: string, ...args: any[]): boolean;
}"

CLASSMETHODS

METHODS

emit: event
	"2025-08-17 This does not seem te work yet, e.g. for event 'click' on a NwMenuItem.
	 Always returns false."
	^ Boolean fromJs: INLINE 'this.js.emit( event.js )'.
!
