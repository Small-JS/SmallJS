CLASS Intl EXTENDS Object MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS namespace object Intl, for internationalization.
	 Its static methods are implemented as class methods.
	 Its static properties are JS constructors. They are implemented as class methods
	 that return the ST classes that encapsulate them, like: Intl numberFormat returns IntlNumberFormat."

CLASSMETHODS

new
	self error: 'Intl is a namespace that cannot be instantiated. Use its class methods.'
!
getCanonicalLocales: locales
	"Return an Array with the canonical names of locales, without duplicates.
	 Locales is a String or an Array of Strings, e.g.: 'EN-us' becomes 'en-US'.
	 Throws a RangeError if a locale is invalid."
	^ Array fromJsStrings: INLINE 'Intl.getCanonicalLocales( locales.$toJs() )'.
!
supportedValuesOf: key
	"Return a sorted Array with the values that the browser supports for key.
	 Key is one of: 'calendar', 'collation', 'currency', 'numberingSystem', 'timeZone', 'unit'.
	 Throws a RangeError if key is not supported."
	^ Array fromJsStrings: INLINE 'Intl.supportedValuesOf( key.js )'.
!

"Constructors"

collator
	^ IntlCollator.
!
dateTimeFormat
	^ IntlDateTimeFormat.
!
displayNames
	^ IntlDisplayNames.
!
durationFormat
	^ IntlDurationFormat.
!
listFormat
	^ IntlListFormat.
!
locale
	^ IntlLocale.
!
numberFormat
	^ IntlNumberFormat.
!
pluralRules
	^ IntlPluralRules.
!
relativeTimeFormat
	^ IntlRelativeTimeFormat.
!
segmenter
	^ IntlSegmenter.
!
