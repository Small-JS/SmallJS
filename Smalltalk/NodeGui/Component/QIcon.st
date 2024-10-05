CLASS QIcon EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QIcon } from "@nodegui/nodegui";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new QIcon()'.
!
new: fileName
	^ self fromJs: INLINE 'new QIcon( fileName.js )'.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name()'.
!
