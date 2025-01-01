CLASS EventEmitter EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Events"

postMessage: value
	INLINE 'this.js.postMessage( value.js )'.
!
emit: event
	^ Boolean fromJs: INLINE 'this.js.emit( event.js )'.
!
emit: event value: value
	^ Boolean fromJs: INLINE 'this.js.emit( event.js, value.js )'.
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
prependListener: event then: block
	self prependListener: event class: JsObject then: block
!
prependListener: event class: aClass then: block
	INLINE 'this.js.prependListener( event.js, ( message ) => block.$value$( aClass.$fromJs$( message ) ) )'.
!

"Listeners - Once"

once: event then: block
	self once: event class: JsObject then: block
!
once: event class: aClass then: block
	INLINE 'this.js.once( event.js, ( message ) => block.$value$( aClass.$fromJs$( message ) ) )'.
!
prependOnceListener: event then: block
	self prependOnceListener: event class: JsObject then: block
!
prependOnceListener: event class: aClass then: block
	INLINE 'this.js.prependOnceListener( event.js, ( message ) => block.$value$( aClass.$fromJs$( message ) ) )'.
!

"Listeners - Removing"

removeListener: event
	INLINE 'this.js.removeListener( event.js )'.
!
off: event
	self removeListener: event
!
