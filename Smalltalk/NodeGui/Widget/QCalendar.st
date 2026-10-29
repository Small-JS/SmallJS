CLASS QCalendar EXTENDS QWidget MODULE NodeGui CLASSVARS '' VARS ''

"Shows a month calendar, to select a date. By default today is selected. The JS and Qt class is QCalendarWidget.
 NodeGui has no JS methods for the dates, so those are Qt properties."

CLASSMETHODS

new
	^ self fromJs: INLINE 'new nodegui$.QCalendarWidget()'.
!

"Horizontal header format enums"

noHorizontalHeader
	^ 0.
!
singleLetterDayNames
	^ 1.
!
shortDayNames
	"The default."
	^ 2.
!
longDayNames
	^ 3.
!

"Vertical header format enums"

noVerticalHeader
	^ 0.
!
isoWeekNumbers
	"The default."
	^ 1.
!

"Selection mode enums"

noSelection
	^ 0.
!
singleSelection
	"The default."
	^ 1.
!

METHODS

"Dates"

setSelectedDate: date
	"Date outside the minimum and maximum date is ignored."
	INLINE 'this.js.setProperty( "selectedDate", date.js.native )'.
!
selectedDate
	^ QDate fromVariant: ( self property: 'selectedDate' ).
!
setMinimumDate: date
	INLINE 'this.js.setProperty( "minimumDate", date.js.native )'.
!
minimumDate
	^ QDate fromVariant: ( self property: 'minimumDate' ).
!
setMaximumDate: date
	INLINE 'this.js.setProperty( "maximumDate", date.js.native )'.
!
maximumDate
	^ QDate fromVariant: ( self property: 'maximumDate' ).
!

"Appearance"

setFirstDayOfWeek: dayOfWeek
	"Use the QDate day of week enums."
	INLINE 'this.js.setFirstDayOfWeek( dayOfWeek.js )'.
!
firstDayOfWeek
	^ Integer fromJs: INLINE 'this.js.firstDayOfWeek()'.
!
setGridVisible: visible
	INLINE 'this.js.setGridVisible( visible.js )'.
!
isGridVisible
	^ Boolean fromJs: INLINE 'this.js.isGridVisible()'.
!
setNavigationBarVisible: visible
	"The navigation bar has buttons to show other months and years."
	INLINE 'this.js.setNavigationBarVisible( visible.js )'.
!
isNavigationBarVisible
	^ Boolean fromJs: INLINE 'this.js.isNavigationBarVisible()'.
!
setHorizontalHeaderFormat: format
	"Use the horizontal header format enums."
	INLINE 'this.js.setHorizontalHeaderFormat( format.js )'.
!
horizontalHeaderFormat
	^ Integer fromJs: INLINE 'this.js.horizontalHeaderFormat()'.
!
setVerticalHeaderFormat: format
	"Use the vertical header format enums."
	INLINE 'this.js.setVerticalHeaderFormat( format.js )'.
!
verticalHeaderFormat
	^ Integer fromJs: INLINE 'this.js.verticalHeaderFormat()'.
!
setSelectionMode: selectionMode
	"Use the selection mode enums."
	INLINE 'this.js.setSelectionMode( selectionMode.js )'.
!
selectionMode
	^ Integer fromJs: INLINE 'this.js.selectionMode()'.
!
setDateEditEnabled: enabled
	"If enabled, the user can type a date with the keyboard."
	INLINE 'this.js.setDateEditEnabled( enabled.js )'.
!
isDateEditEnabled
	^ Boolean fromJs: INLINE 'this.js.isDateEditEnabled()'.
!

"Events"

onSelectionChange: block
	"Block is called when the selected date changes, also when set by code."
	self addEventListener: 'selectionChanged' then: [ block value ].
!
onClick: block
	"Block is called when the user clicks a date."
	self addEventListener: 'clicked' then: [ block value ].
!
onActivate: block
	"Block is called when the user double-clicks a date or presses Return."
	self addEventListener: 'activated' then: [ block value ].
!
onCurrentPageChange: block
	"Block is called when the user shows another month."
	self addEventListener: 'currentPageChanged' then: [ block value ].
!
