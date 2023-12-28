CLASS Language EXTENDS Object MODULE DOM CLASSVARS '' VARS 'current supported translations'
	"Manages the displayed language for the user.
	 It works by replacing text in HTML elements using their id's.
	 The translated languages are loaded JSON files with an array of <id>, <text>.
	 The JSON file should be named '<language>.json' and placed in the './Language' directory.
	 The preferred language is detected through 'Window navigator language'.
 	 HTML can retain static text in the default language, for readability and testing."

CLASSMETHODS

supported: aSupported
	"Create a new langauge object with an array of supported language id's by this site.
	 The first language is used as the default language."
	^ self new supported: aSupported.
!

METHODS

"Accessing"

current
	^ current.
!
currentIndex
	"Return index of current language in supported languages."
	^ supported indexOf: current.
!
supported
	^ supported.
!
supported: aSupported
	supported := aSupported.
!
translations
	^ translations.
!

"Loading"

load: code
	"Load argument language code into the current HTML."

	| fileName |

	current := self matchCode: code.
	fileName := 'Language/', current, '.json'.
	Fetch object: fileName
		then: [ :object | self onLoad: object ]
		catch: [ :error | self log: 'Failed to load language: ', fileName, ': ', error message ].
!
matchCode: matchCode
	"Match the argument language ID to the closest language supported.
	 The code should be in the ISO format '<language>[-<country>], e.g. 'en-US'.
	 The country is optional and the fallback is first supported equal language from another country."

	| best matchLanguageCode |

	supported isNil ifTrue: [ self error: 'No suported languages' ].

	matchLanguageCode := LanguageCode fromCode: matchCode.
	supported do: [ :code |
		( matchLanguageCode match: code ) ifTrue: [ ^ code ].  "Exact match"
		( matchLanguageCode matchLanguage: code ) ifTrue: [
			best notNil ifTrue: [ best := code ] ] ].  "First coutry match"

	^ best notNil ifTrue: [ best ] ifFalse: [ supported first  ].  "Default match"
!
onLoad: aTranslations
	"Load the argument translations into the HTML page."

	| element translation |

	translations := aTranslations.
	translations entries do: [ :entry |
		element := Document getElementById: ( entry at: 0 ).
		element notNil ifTrue: [
			self setTranslationOn: element to: ( entry at: 1 ) ] ].
!
setTranslationOn: element to: translation
	element textContent: translation.
!
