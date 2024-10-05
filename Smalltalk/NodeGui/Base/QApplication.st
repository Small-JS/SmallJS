CLASS QApplication EXTENDS QObject MODULE NodeGui CLASSVARS '' VARS ''

"The instances will always refer to the JS singleton QApplication object."

INLINE 'import { QApplication } from "@nodegui/nodegui";'

CLASSMETHODS

new
	^ self instance.
!
instance
	^ self fromJs: INLINE 'QApplication.instance()'.
!

METHODS

quit
	INLINE 'this.js.quit()'.
!

"Testing"

testMode
	^ Process argv includes: '-test'.
!
