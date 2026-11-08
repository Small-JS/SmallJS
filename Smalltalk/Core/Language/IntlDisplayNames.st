CLASS IntlDisplayNames EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.DisplayNames.
	 It translates the names of languages, regions, scripts and currencies.
	 Options must contain the property 'type', like 'language' or 'region'."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.DisplayNames'.
!

METHODS

of: code
	"Return the display name of code, like: 'NL' becomes 'Netherlands' for type 'region'.
	 Return nil if there is no name and the option 'fallback' is 'none'."
	^ String fromJs: INLINE 'this.js.of( code.js )'.
!
