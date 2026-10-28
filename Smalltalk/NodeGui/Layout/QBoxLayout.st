CLASS QBoxLayout EXTENDS QLayout MODULE NodeGui CLASSVARS '' VARS ''

CLASSMETHODS

new: direction
	^ self fromJs: INLINE 'new nodegui$.QBoxLayout( direction.js )'.
!

METHODS

addWidget: widget stretch: stretch align: align
	INLINE 'this.js.addWidget( widget.js, stretch.js, align.js )'.
!

