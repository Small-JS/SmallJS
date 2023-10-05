CLASS TestDate EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| date1 date1Utc date2 now |

	date1 := Date year: 2000 month: 2 day: 28 hours: 23 minutes: 58 seconds: 59.
	self assert: [ ( date1 year = 2000 ) & ( date1 month = 2 ) & ( date1 day = 28 ) ].
	self assert: [ ( date1 hours = 23 ) & ( date1 minutes = 58 ) & ( date1 seconds = 59 ) ].

	date2 := date1 copy.
	self assert: [ date1 = date2 ].
	date2 year: 2001.
	self assert: [ date1 ~= date2 ].

	date2 := Date new year: 1996; month: 10; day: 30; hours: 22; minutes: 21; seconds: 20; milliseconds: 123.
	self assert: [ ( date2 year = 1996 ) & ( date2 month = 10 ) & ( date2 day = 30 ) ].
	self assert: [ ( date2 hours = 22 ) & ( date2 minutes = 21 ) & ( date2 seconds = 20 ) & ( date2 milliseconds = 123 ) ].

	date2 utcYear: 1995; utcMonth: 9; utcDay: 15; utcHours: 14; utcMinutes: 13; utcSeconds: 12; utcMilliseconds: 999.
	self assert: [ ( date2 utcYear = 1995 ) & ( date2 utcMonth = 9 ) & ( date2 utcDay = 15 ) ].
	self assert: [ ( date2 utcHours = 14 ) & ( date2 utcMinutes = 13 ) & ( date2 utcSeconds = 12 ) & ( date2 utcMilliseconds = 999 ) ].

	self assert: [ ( date1 = date2 ) not ].
	self assert: [ ( Date fromMilliseconds: date1 toMilliseconds ) = date1 ].

	self assert: [ date1 = date1 ].
	self assert: [ date2 < date1 ].
	self assert: [ date2 <= date1 ].
	self assert: [ date1 > date2 ].
	self assert: [ date1 < Date new ].
	date1Utc := Date utcYear: 2000 month: 2 day: 28 hours: 23 minutes: 58 seconds: 59.
	self assert: [ date1 toMilliseconds - ( date1 timezoneOffset * 60 * 1000 ) = date1Utc toMilliseconds ].

	now := Date new.
	self assert: [ ( Date fromString: now toIsoString ) = now ].

	self assert: [ date2 toDateString = 'Sun Oct 15 1995' ].
	self assert: [ date2 toTimeString includes: ':12' ].
	self assert: [ date2 toUtcString = 'Sun, 15 Oct 1995 14:13:12 GMT' ].
	self assert: [ date2 toIsoString = '1995-10-15T14:13:12.999Z' ].
	self assert: [ date2 toJson = '1995-10-15T14:13:12.999Z' ].
	self assert: [ date2 toLocaleDateString includes: '15' ].
	self assert: [ date2 toLocaleTimeString includes: '13' ].
!
