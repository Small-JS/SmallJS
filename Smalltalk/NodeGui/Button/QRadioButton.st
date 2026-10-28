CLASS QRadioButton EXTENDS QAbstractButton MODULE NodeGui CLASSVARS '' VARS ''

"A radio button with a text label.
 Radio buttons are checkable and auto exclusive by default:
 only one of the radio buttons with the same parent widget can be checked.
 Use a QButtonGroup to group them otherwise."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QRadioButton()'.
!
