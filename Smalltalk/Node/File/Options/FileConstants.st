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
	^ Integer fromJs: INLINE 'fsp$.constants.W_OK'.
!
executeOk
	^ Integer fromJs: INLINE 'fsp$.constants.X_OK'.
!

"Copying"

copyExclusive
	^ Integer fromJs: INLINE 'fsp$.constants.COPYFILE_EXCL'.
!
copyClone
	"Try to create a copy-on-write clone (reflink). Fall back to a normal copy if not supported."
	^ Integer fromJs: INLINE 'fsp$.constants.COPYFILE_FICLONE'.
!
copyCloneForce
	"Create a copy-on-write clone (reflink). Fail if not supported."
	^ Integer fromJs: INLINE 'fsp$.constants.COPYFILE_FICLONE_FORCE'.
!
