CLASS QObject EXTENDS JsObject MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QObject } from "@nodegui/nodegui";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new QObject()'.
!

METHODS

addEventListener: signal then: block
	INLINE 'this.js.addEventListener( signal.js, () => block.$value() )'.
!

setObjectName: objectName
	INLINE 'this.js.setObjectName( objectName.js )'.
!
objectName
	^ String fromJs: INLINE 'this.js.objectName()'.
!
