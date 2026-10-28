CLASS QPixmap EXTENDS QComponent MODULE NodeGui CLASSVARS '' VARS ''

CLASSMETHODS

new: fileName
	^ self fromJs: INLINE 'new nodegui$.QPixmap( fileName.js )'.
!

