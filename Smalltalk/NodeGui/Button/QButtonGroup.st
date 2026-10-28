CLASS QButtonGroup EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS 'buttons'

"Groups checkable buttons, e.g. QRadioButtons, independent of their parent widget.
 By default the group is exclusive: only one of its buttons can be checked.
 JS buttons(), checkedButton() and button() answer native objects, that cannot be used,
 so this object keeps the buttons added to it in variable buttons."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QButtonGroup()'.
!

METHODS

"Buttons"

buttons
	"Answer a copy of the buttons added to this group."
	buttons isNil ifTrue: [ buttons := Array new ].
	^ buttons copy.
!
addButton: button
	"Add button with an automatically assigned negative id."
	self addButton: button id: -1.
!
addButton: button id: id
	"Add button with id. If id is -1, a negative id is assigned automatically."
	( self buttons includes: button ) ifFalse: [
		buttons add: button ].
	INLINE 'this.js.addButton( button.js, id.js )'.
!
removeButton: button
	| index |
	index := self buttons indexOf: button.
	index >= 0 ifTrue: [ buttons removeAt: index ].
	INLINE 'this.js.removeButton( button.js )'.
!
setId: button id: id
	INLINE 'this.js.setId( button.js, id.js )'.
!
id: button
	"Answer the id of button, or -1 if it is not in this group."
	^ Integer fromJs: INLINE 'this.js.id( button.js )'.
!
button: id
	"Answer the button with id, or nil if there is none."
	^ self buttons find: [ :button | ( self id: button ) = id ].
!

"Checking"

checkedId
	"Answer the id of the checked button, or -1 if none is checked."
	^ Integer fromJs: INLINE 'this.js.checkedId()'.
!
checkedButton
	"Answer the checked button, or nil if none is checked."
	^ self buttons find: [ :button | button isChecked ].
!
setExclusive: exclusive
	INLINE 'this.js.setExclusive( exclusive.js )'.
!
exclusive
	^ Boolean fromJs: INLINE 'this.js.exclusive()'.
!

"Events"

onIdClick: block
	"Block is called with the id of the button clicked."
	INLINE 'this.js.addEventListener( "idClicked", id => block.$value$( stInteger$class.$fromJs$( id ) ) )'.
!
