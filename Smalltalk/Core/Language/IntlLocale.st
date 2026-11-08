CLASS IntlLocale EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.Locale.
	 It holds a language tag, like 'en-US', and its parts.
	 Parts not set in the tag or the options are nil."

CLASSMETHODS

"Creating"

tag: tag
	"Throws a RangeError if tag is invalid."
	^ self fromJs: INLINE 'new Intl.Locale( tag.js )'.
!
tag: tag options: options
	"Options is a JsObject with properties that override the parts of tag, like 'region'."
	^ self fromJs: INLINE 'new Intl.Locale( tag.js, options.$toJs() )'.
!

METHODS

"Accessing"

baseName
	"The tag without extensions, like: 'en-Latn-US'."
	^ String fromJs: INLINE 'this.js.baseName'.
!
language
	^ String fromJs: INLINE 'this.js.language'.
!
script
	^ String fromJs: INLINE 'this.js.script'.
!
region
	^ String fromJs: INLINE 'this.js.region'.
!
calendar
	^ String fromJs: INLINE 'this.js.calendar'.
!
caseFirst
	^ String fromJs: INLINE 'this.js.caseFirst'.
!
collation
	^ String fromJs: INLINE 'this.js.collation'.
!
hourCycle
	^ String fromJs: INLINE 'this.js.hourCycle'.
!
numberingSystem
	^ String fromJs: INLINE 'this.js.numberingSystem'.
!
numeric
	^ Boolean fromJs: INLINE 'this.js.numeric'.
!

"Converting"

maximize
	"Return a new IntlLocale with the most likely script and region added, like: 'en' becomes 'en-Latn-US'."
	^ IntlLocale fromJs: INLINE 'this.js.maximize()'.
!
minimize
	"Return a new IntlLocale without the parts that maximize would add."
	^ IntlLocale fromJs: INLINE 'this.js.minimize()'.
!
toString
	"Return the full tag, including extensions."
	^ String fromJs: INLINE 'this.js.toString()'.
!
