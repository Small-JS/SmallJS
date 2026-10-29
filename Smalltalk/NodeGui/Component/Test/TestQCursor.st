CLASS TestQCursor EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"The mouse of the user is not moved, so setPos: is not tested."

test
	| widget |
	self assert: [ QCursor new jsClassName = 'QCursor' ].
	widget := QWidget new.
	widget setCursor: ( QCursor new: QWidget pointingHandCursor ).
	widget setCursor: QWidget arrowCursor.
!
testPos
	self assert: [ QCursor pos class = QPoint ].
!
