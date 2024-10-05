CLASS QPixmap EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QPixmap } from "@nodegui/nodegui";'

CLASSMETHODS

new: fileName
	^ self fromJs: INLINE 'new QPixmap( fileName.js )'.
!

