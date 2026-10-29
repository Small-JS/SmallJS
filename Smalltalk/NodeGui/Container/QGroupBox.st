CLASS QGroupBox EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"A frame with a title, around the widgets of its layout.
 A checkable group box has a check box in its title, that enables or disables its widgets."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QGroupBox()'.
!

METHODS

setTitle: title
	INLINE 'this.js.setTitle( title.js )'.
!
title
	^ String fromJs: INLINE 'this.js.title()'.
!
setAlignment: alignment
	"Alignment of the title, use the QLayout alignment enums."
	INLINE 'this.js.setAlignment( alignment.js )'.
!
alignment
	^ Integer fromJs: INLINE 'this.js.alignment()'.
!
setFlat: flat
	"A flat group box only draws the top part of its frame."
	INLINE 'this.js.setFlat( flat.js )'.
!
isFlat
	^ Boolean fromJs: INLINE 'this.js.isFlat()'.
!

"Checking"

setCheckable: checkable
	INLINE 'this.js.setCheckable( checkable.js )'.
!
isCheckable
	^ Boolean fromJs: INLINE 'this.js.isCheckable()'.
!
setChecked: checked
	"Only has effect if the group box is checkable."
	INLINE 'this.js.setChecked( checked.js )'.
!
isChecked
	^ Boolean fromJs: INLINE 'this.js.isChecked()'.
!

"Events"

onClick: block
	"Block is called when the user clicks the check box in the title."
	self addEventListener: 'clicked' then: [ block value ].
!
onToggle: block
	"Block is called when the checked state changes, also when set by code."
	self addEventListener: 'toggled' then: [ block value ].
!
