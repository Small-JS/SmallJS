CLASS TestQFlexLayout EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| widget layout label1 label2 |
	widget := QWidget new.
	layout := QFlexLayout new.
	self assert: [ layout class = QFlexLayout ].
	self assert: [ layout inherits: 'QLayout' ].
	widget setLayout: layout.

	"Widgets added to the layout become children of the widget of the layout."
	label1 := QLabel new.
	label2 := QLabel new.
	layout addWidget: label1.
	layout insertWidget: label2 before: label1.
	self assert: [ label1 parent = widget ].
	self assert: [ label2 parent = widget ].

	layout removeWidget: label1.
	layout removeWidget: label2.
!
