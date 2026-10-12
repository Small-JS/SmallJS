CLASS TestMediaQueryList EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| list |
	list := Window default matchMedia: 'screen'.
	self assert: [ list class = MediaQueryList ].
	self assert: [ list media = 'screen' ].
	self assert: [ list matches ].

	list := Window default matchMedia: 'print'.
	self assert: [ list media = 'print' ].
	self assert: [ list matches not ].

	list := Window default matchMedia: '(min-width: 1px)'.
	self assert: [ list media = '(min-width: 1px)' ].
	self assert: [ list matches ].

	list := Window default matchMedia: '(max-width: 1px)'.
	self assert: [ list matches not ].

	"An invalid query never matches, and is serialized as 'not all'."
	list := Window default matchMedia: 'invalid query!'.
	self assert: [ list media = 'not all' ].
	self assert: [ list matches not ].
!
testEvents
	"The change event can only be fired by actually changing the viewport or media,
	 so only test that listeners can be set and that dispatching works."
	| list received |
	list := Window default matchMedia: 'screen'.
	list onChange: [ :event | received := event ].
	list dispatchEvent: ( Event type: 'change' ).
	self assert: [ received type = 'change' ].

	received := nil.
	list := Window default matchMedia: 'screen'.
	list addEventListener: 'change' then: [ :event | received := event ].
	list dispatchEvent: ( Event type: 'change' ).
	self assert: [ received type = 'change' ].
!
