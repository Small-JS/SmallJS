CLASS ValidityState EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class: ValidityState."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new ValidityState()'.
!

METHODS

"Properties."

badInput
	^ Boolean fromJs: INLINE 'this.js.badInput'.
!
customError
	^ Boolean fromJs: INLINE 'this.js.customError'.
!
patternMismatch
	^ Boolean fromJs: INLINE 'this.js.patternMismatch'.
!
rangeOverflow
	^ Boolean fromJs: INLINE 'this.js.rangeOverflow'.
!
rangeUnderflow
	^ Boolean fromJs: INLINE 'this.js.rangeUnderflow'.
!
stepMismatch
	^ Boolean fromJs: INLINE 'this.js.stepMismatch'.
!
tooLong
	^ Boolean fromJs: INLINE 'this.js.tooLong'.
!
tooShort
	^ Boolean fromJs: INLINE 'this.js.tooShort'.
!
typeMismatch
	^ Boolean fromJs: INLINE 'this.js.typeMismatch'.
!
valid
	^ Boolean fromJs: INLINE 'this.js.valid'.
!
valueMissing
	^ Boolean fromJs: INLINE 'this.js.valueMissing'.
!
