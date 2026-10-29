CLASS TestQDate EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| date |
	date := QDate new.
	self assert: [ date jsClassName = 'QDate' ].
	self assert: [ date isValid not ].

	date := QDate year: 2024 month: 2 day: 29.
	self assert: [ date isValid ].
	self assert: [ date year = 2024 ].
	self assert: [ date month = 2 ].
	self assert: [ date day = 29 ].
	self assert: [ date dayOfWeek = QDate thursday ].
	self assert: [ date dayOfYear = 60 ].
	self assert: [ date daysInMonth = 29 ].
	self assert: [ date daysInYear = 366 ].

	"A date that does not exist is invalid."
	self assert: [ ( QDate year: 2023 month: 2 day: 29 ) isValid not ].
!
testToday
	self assert: [ QDate today isValid ].
	self assert: [ QDate today = QDate today ].
!
testLeapYear
	self assert: [ QDate isLeapYear: 2024 ].
	self assert: [ ( QDate isLeapYear: 2023 ) not ].
	self assert: [ ( QDate isLeapYear: 1900 ) not ].
	self assert: [ QDate isLeapYear: 2000 ].
!
testCalculating
	| date |
	date := QDate year: 2024 month: 1 day: 31.
	self assert: [ ( date addDays: 1 ) = ( QDate year: 2024 month: 2 day: 1 ) ].
	self assert: [ ( date addDays: -31 ) = ( QDate year: 2023 month: 12 day: 31 ) ].
	"The last day of the month is used, if the day does not exist."
	self assert: [ ( date addMonths: 1 ) = ( QDate year: 2024 month: 2 day: 29 ) ].
	self assert: [ ( date addYears: 1 ) = ( QDate year: 2025 month: 1 day: 31 ) ].
	self assert: [ ( date daysTo: ( QDate year: 2024 month: 3 day: 1 ) ) = 30 ].
	self assert: [ ( date daysTo: ( QDate year: 2024 month: 1 day: 1 ) ) = -30 ].
	"The receiver is not changed."
	self assert: [ date = ( QDate year: 2024 month: 1 day: 31 ) ].
!
testComparing
	self assert: [ ( QDate year: 2024 month: 2 day: 29 ) = ( QDate year: 2024 month: 2 day: 29 ) ].
	self assert: [ ( QDate year: 2024 month: 2 day: 29 ) ~= ( QDate year: 2024 month: 3 day: 1 ) ].
	self assert: [ ( QDate year: 2024 month: 2 day: 29 ) ~= 2024 ].
!
testString
	| date |
	date := QDate year: 2024 month: 2 day: 9.
	self assert: [ date toString = '2024-02-09' ].
	self assert: [ ( date toString: 'd/M/yy' ) = '9/2/24' ].
	self assert: [ ( QDate fromString: '9/2/2024' format: 'd/M/yyyy' ) = date ].
	self assert: [ ( QDate fromString: 'no date' format: 'd/M/yyyy' ) isValid not ].
!
