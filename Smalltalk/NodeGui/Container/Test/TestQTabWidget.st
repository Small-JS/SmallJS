CLASS TestQTabWidget EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| tabs page1 page2 page3 |
	tabs := QTabWidget new.
	self assert: [ tabs jsClassName = 'QTabWidget' ].
	self assert: [ tabs count = 0 ].
	self assert: [ tabs currentIndex = -1 ].

	page1 := QLabel new.
	page2 := QLabel new.
	page3 := QLabel new.
	self assert: [ ( tabs addTab: page1 label: 'One' ) = 0 ].
	self assert: [ ( tabs addTab: page3 icon: QIcon new label: 'Three' ) = 1 ].
	self assert: [ ( tabs insertTab: page2 at: 1 label: 'Two' ) = 1 ].
	self assert: [ tabs count = 3 ].
	self assert: [ ( tabs indexOf: page3 ) = 2 ].
	self assert: [ ( tabs widget: 1 ) = page2 ].
	self assert: [ ( tabs widget: 3 ) isNil ].
	self assert: [ tabs currentIndex = 0 ].

	tabs setTabText: 'First' at: 0.
	tabs setTabIcon: QIcon new at: 0.
	tabs setTabPosition: QTabWidget south.
	tabs setTabsClosable: true.

	"Removing the last tab works too."
	tabs removeTab: 2.
	tabs removeTab: 0.
	self assert: [ tabs count = 1 ].
	self assert: [ ( tabs widget: 0 ) = page2 ].
	self assert: [ ( tabs indexOf: page1 ) = -1 ].
!
testCurrent
	| tabs count |
	tabs := QTabWidget new.
	tabs addTab: QLabel new label: 'One'.
	tabs addTab: QLabel new label: 'Two'.
	count := 0.
	tabs onCurrentChange: [ count := count + 1 ].

	tabs setCurrentIndex: 1.
	self assert: [ tabs currentIndex = 1 ].
	self assert: [ count = 1 ].
!
