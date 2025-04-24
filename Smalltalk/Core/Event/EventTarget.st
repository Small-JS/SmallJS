CLASS EventTarget EXTENDS JsObject MODULE Core CLASSVARS '' VARS 'eventIds'
	"Implements JS EventTarget abstract class.
	 Variable value holds the JS object associated ST objects of subsclasses,
	 so is unrelated to EventTargert functionality."

METHODS

= eventTarget
	"ST event targets, nodes and elements are considered value-equeal
	 if they refer to the same JS value."
	^ Boolean fromJs: INLINE 'this.js == eventTarget.js'.
!
eventIds
	"Lazy instantiation, only when using events on this object."
	eventIds isNil ifTrue: [
		eventIds := Array new ].
	^ eventIds.
!
addEventListener: type then: block
	"Block should have 1 argument: the ST Event."
	| jsBlock |
	jsBlock := [ :jsEvent | block value: ( Event fromJsSubEvent: jsEvent ) ].
	INLINE 'this.js.addEventListener( type.js, jsBlock.js )'.
	self eventIds add: ( EventId fromType: type block: block jsBlock: jsBlock ).
!
removeEventListener: type then: block
	| eventId |
	eventIds length -1 to: 0 by: -1 do: [ :index |
		eventId := eventIds at: index.
		( eventId type = type ) & ( eventId block = block ) ifTrue: [
			INLINE 'this.js.removeEventListener( eventId.type.js, eventId.jsBlock.js )'.
			eventIds removeAt: index. ] ].
!
dispatchEvent: event
	^ Boolean fromJs: INLINE 'this.js.dispatchEvent( event.js )'.
!
