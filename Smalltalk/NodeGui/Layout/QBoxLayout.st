CLASS QBoxLayout EXTENDS QLayout MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QBoxLayout } from "@nodegui/nodegui";'

CLASSMETHODS

new: direction
	^ self fromJs: INLINE 'new QBoxLayout( direction.js )'.
!

METHODS

addWidget: widget stretch: stretch align: align
	INLINE 'this.js.addWidget( widget.js, stretch.js, align.js )'.
!

