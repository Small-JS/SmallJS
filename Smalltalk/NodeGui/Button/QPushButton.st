CLASS QPushButton EXTENDS QAbstractButton MODULE NodeGui CLASSVARS '' VARS ''

INLINE 'import { QPushButton } from "@nodegui/nodegui";'

CLASSMETHODS

new
	^ self fromJs: INLINE 'new QPushButton()'.
!

METHODS

click
	INLINE 'this.js.click()'.
!
onClick: block
	self addEventListener: 'clicked' then: [ block value ].
!
