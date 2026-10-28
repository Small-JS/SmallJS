CLASS QObject EXTENDS JsObject MODULE NodeGui CLASSVARS '' VARS 'eventIds'
	"Variable eventIds holds the ST listener blocks with their JS wrapper functions,
	 so they can be removed again."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QObject()'.
!

"Timer type enums"

preciseTimer
	^ 0.
!
coarseTimer
	^ 1.
!
veryCoarseTimer
	^ 2.
!

METHODS

"Events"

eventIds
	"Lazy instantiation, only when using events on this object."
	eventIds isNil ifTrue: [
		eventIds := Array new ].
	^ eventIds.
!
addEventListener: signal then: block
	"Block should have no arguments.
	 Adding the same block again for the same signal does nothing."
	| jsBlock |
	( self findEventId: signal block: block ) notNil ifTrue: [ ^ self ].
	jsBlock := [ block value ].
	INLINE 'this.js.addEventListener( signal.js, jsBlock.js )'.
	self eventIds add: ( EventId fromType: signal block: block jsBlock: jsBlock ).
!
removeEventListener: signal then: block
	| eventId |
	self eventIds length - 1 to: 0 by: -1 do: [ :index |
		eventId := eventIds at: index.
		( eventId type = signal ) & ( eventId block = block ) ifTrue: [
			INLINE 'this.js.removeEventListener( eventId.type.js, eventId.jsBlock.js )'.
			eventIds removeAt: index ] ].
!
findEventId: signal block: block
	"Private: Answer the EventId for signal and block, or nil if not found."
	^ self eventIds find: [ :eventId | ( eventId type = signal ) & ( eventId block = block ) ].
!

"Identification"

id
	"Answer a number identifying the C++ object, unique during its lifetime."
	^ Integer fromJs: INLINE 'this.js._id()'.
!
setObjectName: objectName
	INLINE 'this.js.setObjectName( objectName.js )'.
!
objectName
	^ String fromJs: INLINE 'this.js.objectName()'.
!
inherits: className
	"Answer true if this object is an instance of the Qt class className, or of a subclass of it."
	^ Boolean fromJs: INLINE 'this.js.inherits( className.js )'.
!

"Properties"

setProperty: name value: value
	"Value can be a String, Number, Boolean, Array of Strings, or a NodeGui value like QSize.
	 Answer true if name is a declared Qt property, false if a dynamic property was set.
	 JS setProperty() does not unwrap NodeGui values, so pass their native object."
	| jsValue |
	jsValue := INLINE 'value.$toJs()'.
	^ Boolean fromJs: INLINE 'this.js.setProperty( name.js, jsValue?.native ?? jsValue )'.
!
property: name
	^ QVariant fromJs: INLINE 'this.js.property( name.js )'.
!

"Object tree"

setParent: parent
	"Parent can be nil to remove the parent."
	parent isNil
		ifTrue: [ INLINE 'this.js.setParent( null )' ]
		ifFalse: [ INLINE 'this.js.setParent( parent.js )' ].
!
parent
	"Answer nil if there is no parent."
	^ QObject fromJs: INLINE 'this.js.parent()'.
!
children
	^ Array fromJs: INLINE 'this.js.children()' elementClass: QObject.
!

"Timers"

startTimer: interval
	"Start a timer firing 'Timer' events every interval milliseconds.
	 Answer the timer id, or 0 if the timer could not be started."
	^ Integer fromJs: INLINE 'this.js.startTimer( interval.js )'.
!
startTimer: interval type: timerType
	^ Integer fromJs: INLINE 'this.js.startTimer( interval.js, timerType.js )'.
!
killTimer: timerId
	INLINE 'this.js.killTimer( timerId.js )'.
!

"Deleting"

delete
	"Delete the C++ object immediately. Do not use this object afterwards."
	INLINE 'this.js.delete()'.
!
deleteLater
	"Delete the C++ object when control returns to the Qt event loop."
	INLINE 'this.js.deleteLater()'.
!

"Debugging"

dumpObjectTree
	"Print the tree of child objects to the Qt debug output."
	INLINE 'this.js.dumpObjectTree()'.
!
dumpObjectInfo
	"Print signal connections of this object to the Qt debug output."
	INLINE 'this.js.dumpObjectInfo()'.
!
