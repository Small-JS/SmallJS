CLASS QMenu EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QMenu } from "@nodegui/nodegui";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new QMenu()'.
!

METHODS

setTitle: title
	INLINE 'this.js.setTitle( title.js )'.
!
title
	^ String fromJs: INLINE 'this.js.title()'.
!
menuAction
	^ QAction fromJs: INLINE 'this.js.menuAction()'.
!
