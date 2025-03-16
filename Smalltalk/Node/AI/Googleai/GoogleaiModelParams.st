CLASS GoogleaiModelParams EXTENDS JsObject MODULE Ai CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

model
	^ String fromJs: INLINE 'this.js.model'.
!
model: model
	INLINE 'this.js.model = model.js'.
!
