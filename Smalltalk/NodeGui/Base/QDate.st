CLASS QDate EXTENDS JsObject MODULE NodeGui CLASSVARS '' VARS ''

"A calendar date, without time and time zone. Months and days start at 1.
 Format strings use Qt date format characters, e.g. 'yyyy-MM-dd' or 'd MMMM yyyy'."

CLASSMETHODS

new
	"Answer a null date, that is invalid.
	 JS isNull() is not wrapped, because isNull is used by JsObject to test for a JS null."
	^ self fromJs: INLINE 'new nodegui$.QDate()'.
!
year: year month: month day: day
	"Answer an invalid date if the date does not exist."
	^ self fromJs: INLINE 'new nodegui$.QDate( year.js, month.js, day.js )'.
!
today
	^ self fromJs: INLINE 'nodegui$.QDate.currentDate()'.
!
fromString: string format: format
	"Answer an invalid date if string does not match format."
	^ self fromJs: INLINE 'nodegui$.QDate.fromString( string.js, format.js )'.
!
fromVariant: variant
	"Answer the date held by QVariant variant, e.g. from QObject property:."
	^ self fromJs: INLINE 'nodegui$.QDate.fromQVariant( variant.js )'.
!
isLeapYear: year
	^ Boolean fromJs: INLINE 'nodegui$.QDate.isLeapYear( year.js )'.
!

"Day of week enums, answered by dayOfWeek"

monday
	^ 1.
!
tuesday
	^ 2.
!
wednesday
	^ 3.
!
thursday
	^ 4.
!
friday
	^ 5.
!
saturday
	^ 6.
!
sunday
	^ 7.
!

METHODS

"Comparing"

= date
	"Dates are equal if they are the same day."
	^ ( date isKindOf: QDate ) and: [ ( self daysTo: date ) = 0 ].
!

"Accessing"

year
	^ Integer fromJs: INLINE 'this.js.year()'.
!
month
	^ Integer fromJs: INLINE 'this.js.month()'.
!
day
	^ Integer fromJs: INLINE 'this.js.day()'.
!
dayOfWeek
	"Answer a day of week enum, from 1 (monday) to 7 (sunday)."
	^ Integer fromJs: INLINE 'this.js.dayOfWeek()'.
!
dayOfYear
	^ Integer fromJs: INLINE 'this.js.dayOfYear()'.
!
daysInMonth
	^ Integer fromJs: INLINE 'this.js.daysInMonth()'.
!
daysInYear
	^ Integer fromJs: INLINE 'this.js.daysInYear()'.
!

"Testing"

isValid
	^ Boolean fromJs: INLINE 'this.js.isValid()'.
!

"Calculating"

addDays: days
	"Answer a new date. Days can be negative."
	^ QDate fromJs: INLINE 'this.js.addDays( days.js )'.
!
addMonths: months
	"Answer a new date. If the day does not exist in the new month, the last day of that month is used."
	^ QDate fromJs: INLINE 'this.js.addMonths( months.js )'.
!
addYears: years
	^ QDate fromJs: INLINE 'this.js.addYears( years.js )'.
!
daysTo: date
	"Answer the number of days from this date to date, negative if date is earlier."
	^ Integer fromJs: INLINE 'this.js.daysTo( date.js )'.
!

"Printing"

toString
	"Answer the date in ISO format, e.g. '2026-10-29'."
	^ self toString: 'yyyy-MM-dd'.
!
toString: format
	^ String fromJs: INLINE 'this.js.toString( format.js )'.
!
