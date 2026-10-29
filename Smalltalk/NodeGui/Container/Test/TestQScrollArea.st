CLASS TestQScrollArea EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| scrollArea label |
	scrollArea := QScrollArea new.
	self assert: [ scrollArea jsClassName = 'QScrollArea' ].
	self assert: [ scrollArea widget isNil ].
	self assert: [ scrollArea widgetResizable not ].

	label := QLabel new.
	scrollArea setWidget: label.
	self assert: [ scrollArea widget = label ].

	scrollArea setWidgetResizable: true.
	self assert: [ scrollArea widgetResizable ].
	scrollArea setAlignment: QLayout alignCenter.
	self assert: [ scrollArea alignment = QLayout alignCenter ].
	scrollArea ensureVisible: 0 y: 0.
	scrollArea ensureWidgetVisible: label.

	self assert: [ scrollArea takeWidget = label ].
	self assert: [ scrollArea widget isNil ].
	self assert: [ scrollArea takeWidget isNil ].
!
