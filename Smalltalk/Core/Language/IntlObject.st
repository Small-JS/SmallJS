CLASS IntlObject EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"Abstract superclass of the classes that encapsulate the JS Intl constructors
	 that take locales and options, like Intl.NumberFormat.
	 Subclasses implement the class method jsConstructor.
	 Locales is a String or an Array of Strings, like 'en-US'.
	 Options is a JsObject with the options of the JS constructor."

CLASSMETHODS

"Creating"

jsConstructor
	"Return a JsObject with the JS Intl constructor of this class."
	self error: 'IntlObject is an abstract class. Use one of its subclasses.'
!
new
	"Create an instance for the default locale of the system."
	| constructor |
	constructor := self jsConstructor.
	^ self fromJs: INLINE 'new constructor.js()'.
!
locales: locales
	| constructor |
	constructor := self jsConstructor.
	^ self fromJs: INLINE 'new constructor.js( locales.$toJs() )'.
!
locales: locales options: options
	| constructor |
	constructor := self jsConstructor.
	^ self fromJs: INLINE 'new constructor.js( locales.$toJs(), options.$toJs() )'.
!

"Testing"

supportedLocalesOf: locales
	"Return an Array with the locales that are supported without falling back to the default locale."
	| constructor |
	constructor := self jsConstructor.
	^ Array fromJsStrings: INLINE 'constructor.js.supportedLocalesOf( locales.$toJs() )'.
!

METHODS

resolvedOptions
	"Return a JsObject with the locale and the options used, including the defaults."
	^ JsObject fromJs: INLINE 'this.js.resolvedOptions()'.
!
