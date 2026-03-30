CLASS EventEmitter EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Must use NW.js compatible import."
INLINE 'const events$ = await import( "node:events" );'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new events$.EventEmitter()'.
!

METHODS

"Events"

emit: event
	^ Boolean fromJs: INLINE 'this.js.emit( event.js )'.
!
emit: event value: value
	^ Boolean fromJs: INLINE 'this.js.emit( event.js, value.js )'.
!
eventNames
	^ Array fromJsStrings: INLINE 'this.js.eventNames()'.
!
maxListeners
	^ Integer fromJs: INLINE 'this.js.getMaxListeners()'.
!
maxListeners: maxListeners
	Integer fromJs: INLINE 'this.js.setMaxListeners( maxListeners.js )'.
!
listenerCount: event
	^ Integer fromJs: INLINE 'this.js.listenerCount( event.js )'.
!
listeners: event
	^ Array fromJs: INLINE 'this.js.listeners( event.js )'
		elementConverter: [ :jsFunction | Block fromJs: jsFunction ].
!

"Listeners - Adding"

on: event then: block
	self addListener: event then: block.
!
on: event class: aClass then: block
	self addListener: event class: aClass then: block
!
addListener: event then: block
	self addListener: event class: JsObject then: block
!
addListener: event class: aClass then: block
	INLINE 'this.js.on( event.js, ( message ) => block.$value$( aClass.$fromJs$( message ) ) )'.
!
once: event then: block
	self once: event class: JsObject then: block
!
once: event class: aClass then: block
	INLINE 'this.js.once( event.js, ( message ) => block.$value$( aClass.$fromJs$( message ) ) )'.
!

"Listeners - Removing"

removeAllListeners: event
	INLINE 'this.js.removeAllListeners( event.js )'.
!

"Note 1:
NodeJS EventEmitter.prepend* methods are not implemented.
One should not depend on the order of events fired.

Note 2:
Removing individual event listeners is not implemented,
because ST blocks to not keep the function names constant,
to be used as IDs."
