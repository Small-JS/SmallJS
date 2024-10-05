CLASS TestQApplication EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| qApplication |
	qApplication := QApplication instance.
	self assert: [ qApplication jsClassName = 'QApplication' ].
	self assert: [ qApplication testMode | true ].
!
