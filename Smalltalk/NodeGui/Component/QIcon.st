CLASS QIcon EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QIcon()'.
!
new: fileName
	^ self fromJs: INLINE 'new nodegui$.QIcon( fileName.js )'.
!

METHODS

name
	^ String fromJs: INLINE 'this.js.name()'.
!
