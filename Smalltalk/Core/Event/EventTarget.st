CLASS EventTarget EXTENDS JsObject MODULE Core CLASSVARS '' VARS 'eventIds'
	"Implements JS EventTarget abstract class.
	 Variable eventIds holds the ST listener blocks with their JS wrapper functions,
	 so they can be removed again."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new EventTarget()'.
!

METHODS

= eventTarget
	"ST event targets, nodes and elements are considered value-equal
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
	"Block should have 1 argument: the ST Event.
	 As in JS, adding the same block again for the same type does nothing."
	| jsBlock |
	( self findEventId: type block: block ) notNil ifTrue: [ ^ self ].
	jsBlock := [ :jsEvent | block value: ( Event fromJsSubEvent: jsEvent ) ].
	INLINE 'this.js.addEventListener( type.js, jsBlock.js )'.
	self eventIds add: ( EventId fromType: type block: block jsBlock: jsBlock ).
!
removeEventListener: type then: block
	| eventId |
	self eventIds length -1 to: 0 by: -1 do: [ :index |
		eventId := eventIds at: index.
		( eventId type = type ) & ( eventId block = block ) ifTrue: [
			INLINE 'this.js.removeEventListener( eventId.type.js, eventId.jsBlock.js )'.
			eventIds removeAt: index. ] ].
!
findEventId: type block: block
	"Private: Answer the EventId for type and block, or nil if not found."
	^ self eventIds find: [ :eventId | ( eventId type = type ) & ( eventId block = block ) ].
!
dispatchEvent: event
	^ Boolean fromJs: INLINE 'this.js.dispatchEvent( event.js )'.
!
