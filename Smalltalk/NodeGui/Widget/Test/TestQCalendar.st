CLASS TestQCalendar EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| calendar date count |
	calendar := QCalendar new.
	self assert: [ calendar jsClassName = 'QCalendarWidget' ].
	self assert: [ calendar selectedDate = QDate today ].
	count := 0.
	calendar onSelectionChange: [ count := count + 1 ].

	date := QDate year: 2024 month: 2 day: 29.
	calendar setSelectedDate: date.
	self assert: [ calendar selectedDate = date ].
	self assert: [ count = 1 ].
!
testRange
	| calendar |
	calendar := QCalendar new.
	calendar setMinimumDate: ( QDate year: 2024 month: 1 day: 1 ).
	calendar setMaximumDate: ( QDate year: 2024 month: 12 day: 31 ).
	self assert: [ calendar minimumDate = ( QDate year: 2024 month: 1 day: 1 ) ].
	self assert: [ calendar maximumDate = ( QDate year: 2024 month: 12 day: 31 ) ].

	"A selected date outside the range is limited to the range."
	calendar setSelectedDate: ( QDate year: 2023 month: 6 day: 1 ).
	self assert: [ calendar selectedDate = ( QDate year: 2024 month: 1 day: 1 ) ].
!
testAppearance
	| calendar |
	calendar := QCalendar new.
	calendar setFirstDayOfWeek: QDate sunday.
	self assert: [ calendar firstDayOfWeek = QDate sunday ].

	self assert: [ calendar isGridVisible not ].
	calendar setGridVisible: true.
	self assert: [ calendar isGridVisible ].
	self assert: [ calendar isNavigationBarVisible ].
	calendar setNavigationBarVisible: false.
	self assert: [ calendar isNavigationBarVisible not ].

	self assert: [ calendar horizontalHeaderFormat = QCalendar shortDayNames ].
	calendar setHorizontalHeaderFormat: QCalendar singleLetterDayNames.
	self assert: [ calendar horizontalHeaderFormat = QCalendar singleLetterDayNames ].
	self assert: [ calendar verticalHeaderFormat = QCalendar isoWeekNumbers ].
	calendar setVerticalHeaderFormat: QCalendar noVerticalHeader.
	self assert: [ calendar verticalHeaderFormat = QCalendar noVerticalHeader ].

	self assert: [ calendar selectionMode = QCalendar singleSelection ].
	calendar setSelectionMode: QCalendar noSelection.
	self assert: [ calendar selectionMode = QCalendar noSelection ].
	self assert: [ calendar isDateEditEnabled ].
	calendar setDateEditEnabled: false.
	self assert: [ calendar isDateEditEnabled not ].
!
testEvents
	"The other events are fired by user interaction only."
	| calendar |
	calendar := QCalendar new.
	calendar onClick: [ self assert: [ false ] ].
	calendar onActivate: [ self assert: [ false ] ].
	calendar onCurrentPageChange: [ self assert: [ false ] ].
!
