CLASS TestMediaList EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| media |
	media := CssStyleSheet new media.
	self assert: [ media class = MediaList ].
	self assert: [ media length = 0 ].
	self assert: [ media mediaText = '' ].
	self assert: [ media items isEmpty ].
	self assert: [ ( media item: 0 ) isNil ].

	media appendMedium: 'screen'.
	media appendMedium: 'print'.
	self assert: [ media length = 2 ].
	self assert: [ ( media item: 0 ) = 'screen' ].
	self assert: [ ( media item: 1 ) = 'print' ].
	self assert: [ ( media item: 2 ) isNil ].
	self assert: [ media items = #( 'screen' 'print' ) ].
	self assert: [ media mediaText = 'screen, print' ].
	self assert: [ media toString = 'screen, print' ].

	"Appending an existing medium does nothing."
	media appendMedium: 'screen'.
	self assert: [ media length = 2 ].

	media deleteMedium: 'screen'.
	self assert: [ media length = 1 ].
	self assert: [ ( media item: 0 ) = 'print' ].

	"Deleting a medium that is not present throws an error."
	self assertError: [ media deleteMedium: 'screen' ].

	media mediaText: 'screen and (min-width: 100px), print'.
	self assert: [ media length = 2 ].
	self assert: [ ( media item: 0 ) = 'screen and (min-width: 100px)' ].

	media mediaText: ''.
	self assert: [ media length = 0 ].
!
