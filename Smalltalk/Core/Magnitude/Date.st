CLASS Date EXTENDS Magnitude MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates a JS Date object in the variable 'date'."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Date()'.
!
now
	^ Integer fromJs: INLINE 'Date.now()'.
!
fromMilliseconds: milliseconds
	^ self fromJs: milliseconds js.
!
fromString: string
	^ self fromJs: INLINE 'new Date( string.js )'.
!
year: year month: month day: day
	^ self fromJs: INLINE 'new Date( year.js, month.js - 1, day.js )'.
!
year: year month: month day: day hours: hours minutes: minutes seconds: seconds
	^ self fromJs: INLINE 'new Date( year.js, month.js - 1, day.js, hours.js, minutes.js, seconds.js )'.
!
utcYear: year month: month day: day hours: hours minutes: minutes seconds: seconds
	^ self fromJs: INLINE 'new Date( Date.UTC( year.js, month.js - 1, day.js, hours.js, minutes.js, seconds.js ) )'.
!

METHODS

"Copying"

copy
	^ Date fromJs: INLINE 'new Date( this.js )'.
!

"Conversions"

toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
toDateString
	^ String fromJs: INLINE 'this.js.toDateString()'.
!
toLocaleDateString
	^ String fromJs: INLINE 'this.js.toLocaleDateString()'.
!
toTimeString
	^ String fromJs: INLINE 'this.js.toTimeString()'.
!
toLocaleTimeString
	^ String fromJs: INLINE 'this.js.toLocaleTimeString()'.
!
toIsoString
	^ String fromJs: INLINE 'this.js.toISOString()'.
!
toUtcString
	^ String fromJs: INLINE 'this.js.toUTCString()'.
!
toJson
	^ String fromJs: INLINE 'this.js.toJSON()'.
!
toMilliseconds
	^ Integer fromJs: INLINE 'this.js.getTime()'.
!

"Accessing local times"

year
	^ Integer fromJs: INLINE 'this.js.getFullYear()'.
!
year: year
	INLINE 'this.js.setFullYear( year.js )'.
!
month
	^ Integer fromJs: INLINE 'this.js.getMonth() + 1'.
!
month: month
	INLINE 'this.js.setMonth( month.js - 1 )'.
!
day
	^ Integer fromJs: INLINE 'this.js.getDate()'.
!
day: day
	INLINE 'this.js.setDate( day.js )'.
!
dayOfWeek
	^ Integer fromJs: INLINE 'this.js.getDay()'.
!
hours
	^ Integer fromJs: INLINE 'this.js.getHours()'.
!
hours: hours
	INLINE 'this.js.setHours( hours.js )'.
!
minutes
	^ Integer fromJs: INLINE 'this.js.getMinutes()'.
!
minutes: minutes
	INLINE 'this.js.setMinutes( minutes.js )'.
!
seconds
	^ Integer fromJs: INLINE 'this.js.getSeconds()'.
!
seconds: seconds
	INLINE 'this.js.setSeconds( seconds.js )'.
!
milliseconds
	^ Integer fromJs: INLINE 'this.js.getMilliseconds()'.
!
milliseconds: milliseconds
	INLINE 'this.js.setMilliseconds( milliseconds.js )'.
!

"Accessing UTC times"

utcYear
	^ Integer fromJs: INLINE 'this.js.getUTCFullYear()'.
!
utcMonth
	^ Integer fromJs: INLINE 'this.js.getMonth()'.
!
utcDay
	^ Integer fromJs: INLINE 'this.js.getUTCDate()'.
!
uctDayOfWeek
	^ Integer fromJs: INLINE 'this.js.getUTCDay()'.
!
utcHours
	^ Integer fromJs: INLINE 'this.js.getUTCHours()'.
!
utcMinutes
	^ Integer fromJs: INLINE 'this.js.getUTCMinutes()'.
!
utcSeconds
	^ Integer fromJs: INLINE 'this.js.getUTCSeconds()'.
!
utcMilliseconds
	^ Integer fromJs: INLINE 'this.js.getUTCMilliseconds()'.
!

utcYear: utcYear
	INLINE 'this.js.setUTCFullYear( utcYear.js )'.
!
utcMonth: utcMonth
	INLINE 'this.js.setUTCMonth( utcMonth.js )'.
!
utcDay: utcDay
	INLINE 'this.js.setUTCDate( utcDay.js )'.
!
utcHours: utcHours
	INLINE 'this.js.setUTCHours( utcHours.js )'.
!
utcMinutes: utcMinutes
	INLINE 'this.js.setUTCMinutes( utcMinutes.js )'.
!
utcSeconds: utcSeconds
	^ INLINE 'this.js.setUTCSeconds( utcSeconds.js )'.
!
utcMilliseconds: utcMilliseconds
	^ INLINE 'this.js.setUTCMilliseconds( utcMilliseconds.js )'.
!

"Comparisons"

= date
	^ Boolean fromJs: INLINE 'this.js.valueOf() == date.js.valueOf()'.
!
< date
	^ Boolean fromJs: INLINE 'this.js < date.js'.
!
<= date
	^ Boolean fromJs: INLINE 'this.js <= date.js'.
!

"Timezones"

timezoneOffset
	"Timezone offset in minutes."
	^ Integer fromJs: INLINE 'this.js.getTimezoneOffset()'.
!
dstOffset
	"Return Daylight Savings Time offset in minutes.
	 Returns negative values for DST times, to be compatible with timezoneOffset."
	^ self timezoneOffset - ( Date year: self year month: 0 day: 1 ) timezoneOffset.
!
timezoneDstOffset
	^ self timezoneOffset + self dstOffset.
!
