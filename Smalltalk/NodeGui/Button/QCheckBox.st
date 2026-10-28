CLASS QCheckBox EXTENDS QAbstractButton MODULE NodeGui CLASSVARS '' VARS ''

"A check box with a text label.
 Signals: those of QAbstractButton and 'stateChanged'."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QCheckBox()'.
!

"Check state enums"

unchecked
	^ 0.
!
partiallyChecked
	"Only used by tristate check boxes."
	^ 1.
!
checked
	^ 2.
!

METHODS

"Events"

onStateChange: block
	self addEventListener: 'stateChanged' then: [ block value ].
!

"Check state"

setTristate: tristate
	"A tristate check box can also be partially checked."
	INLINE 'this.js.setTristate( tristate.js )'.
!
isTristate
	^ Boolean fromJs: INLINE 'this.js.isTristate()'.
!
setCheckState: state
	"State is a check state enum, e.g. QCheckBox checked."
	INLINE 'this.js.setCheckState( state.js )'.
!
checkState
	^ Integer fromJs: INLINE 'this.js.checkState()'.
!
