CLASS QLayout EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QLayout } from "@nodegui/nodegui";'

CLASSMETHODS

"Direction enums"

leftToRight
	^ 0.
!
rightToLeft
	^ 1.
!
topToBottom
	^ 2.
!
bottomToTop
	^ 3.
!

"Alignment enums"

alignLeft
	^ 1.
!
alignRight
	^ 2.
!
alignHCenter
	^ 4.
!
alignJustify
	^ 8.
!
alignTop
	^ 32.
!
alignBottom
	^ 64.
!
alignVCenter
	^ 128.
!
alignBaseline
	^ 256.
!
alignCenter
	^ 132.
!

METHODS

count
	^ Integer fromJs: INLINE 'this.js.count()'.
!
