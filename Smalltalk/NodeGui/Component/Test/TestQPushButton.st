CLASS TestQPixmap EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| pixmap |
	pixmap := QPixmap new: 'missing.png'.

	self assert: [ pixmap class = QPixmap ].
!
