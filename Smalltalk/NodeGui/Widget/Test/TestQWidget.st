CLASS TestQWidget EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| widget |

	widget := QWidget new.
	self assert: [ widget jsClassName = 'QWidget' ].

	widget setWindowTitle: 'My Window Title'.
	self assert: [ widget windowTitle = 'My Window Title' ].

	widget setStyleSheet: '#root { align-items: "center" }'.
	self assert: [ widget styleSheet startsWith: '#root' ].

	widget setWindowIcon: QIcon new.
	self assert: [ widget windowIcon jsClassName = 'QIcon' ].
!
