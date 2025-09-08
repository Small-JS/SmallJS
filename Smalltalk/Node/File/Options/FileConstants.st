CLASS FileConstants EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

"Access "

fileOk
	^ Integer fromJs: INLINE 'fsp$.constants.F_OK'.
!
readOk
	^ Integer fromJs: INLINE 'fsp$.constants.R_OK'.
!
writeOk
	^ Integer fromJs: INLINE 'fsp$.constants.R_OK'.
!
executeOk
	^ Integer fromJs: INLINE 'fsp$.constants.X_OK'.
!

"Copying"

copyExclusive
	^ Integer fromJs: INLINE 'fsp$.constants.COPYFILE_EXCL'.
!
copyLink
	^ Integer fromJs: INLINE 'fsp$.constants.COPYFILE_FICLONE'.
!
copyLinkForce
	^ Integer fromJs: INLINE 'fsp$.constants.COPYFILE_FICLONE_FORCE'.
!
