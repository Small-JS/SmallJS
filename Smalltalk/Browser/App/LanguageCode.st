CLASS LanguageCode EXTENDS Object MODULE Browser CLASSVARS '' VARS 'language country'
	"THis class encapsulates an ISO language codes in format '<language>[-<country>], e.g.: 'en-US'.
	 It has functionality for (partial) matching with other language codes."

CLASSMETHODS

fromCode: code
	^ self new fromCode: code.
!

METHODS

"Accessing"

language
	^ language.
!
country
	^ country.
!

"Assigning"

fromCode: code
	"Parse argument ISO language code into self."

	| dashPos |

	dashPos := code indexOf: '-'.
	language := dashPos > 0 ifTrue: [ ( code substring: 0 to: dashPos ) toLocaleLowerCase ] ifFalse: [ code ].
	country := dashPos >= 0 ifTrue: [ ( code substring: 0 to: dashPos ) toUpperCase ] ifFalse: [ nil ].
!

"Converting"

toString
	^ country isNil ifTrue: [ language ] ifFalse: [ language , '-', country ].
!

"Matching"

match: code
	"Return true if the argument code matches self, language and country."

	| match |
	match := LanguageCode fromCode: code.
	^ ( self language = match language ) & ( self country = match country ).
!
matchLanguage: code
	"Return true if the argument code language matches self."

	^ self language = ( LanguageCode fromCode: code ) language.
!
