CLASS TestQKeySequence EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| keySequence |
	keySequence := QKeySequence new.
	self assert: [ keySequence jsClassName = 'QKeySequence' ].
	self assert: [ keySequence isEmpty ].
	self assert: [ keySequence count = 0 ].
	self assert: [ keySequence toString = '' ].

	keySequence := QKeySequence new: 'Ctrl+S'.
	self assert: [ keySequence isEmpty not ].
	self assert: [ keySequence count = 1 ].
	self assert: [ keySequence toString = 'Ctrl+S' ].

	keySequence := QKeySequence new: 'Ctrl+K, Ctrl+C'.
	self assert: [ keySequence count = 2 ].
	self assert: [ keySequence toString = 'Ctrl+K, Ctrl+C' ].
!
testToString
	| keySequence |
	keySequence := QKeySequence new: 'ctrl+shift+s'.
	"Portable text is normalized."
	self assert: [ keySequence toString = 'Ctrl+Shift+S' ].
	self assert: [ ( keySequence toString: QKeySequence portableText ) = 'Ctrl+Shift+S' ].
	"Native text differs per platform, e.g. on macOS."
	self assert: [ ( keySequence toString: QKeySequence nativeText ) isEmpty not ].
!
testComparing
	self assert: [ ( QKeySequence new: 'Ctrl+S' ) = ( QKeySequence new: 'Ctrl+S' ) ].
	self assert: [ ( QKeySequence new: 'Ctrl+S' ) = ( QKeySequence new: 'ctrl+s' ) ].
	self assert: [ ( QKeySequence new: 'Ctrl+S' ) ~= ( QKeySequence new: 'Ctrl+O' ) ].
	self assert: [ ( QKeySequence new: 'Ctrl+S' ) ~= 'Ctrl+S' ].
!
testMatches
	| keySequence |
	keySequence := QKeySequence new: 'Ctrl+K'.
	self assert: [ ( keySequence matches: ( QKeySequence new: 'Ctrl+K' ) ) = QKeySequence exactMatch ].
	"The argument starts with the receiver."
	self assert: [ ( keySequence matches: ( QKeySequence new: 'Ctrl+K, Ctrl+C' ) ) = QKeySequence partialMatch ].
	self assert: [ ( ( QKeySequence new: 'Ctrl+K, Ctrl+C' ) matches: keySequence ) = QKeySequence noMatch ].
	self assert: [ ( keySequence matches: ( QKeySequence new: 'Ctrl+S' ) ) = QKeySequence noMatch ].
!
testFromVariant
	| action keySequence |
	action := QAction new.
	action setProperty: 'shortcut' value: ( QKeySequence new: 'Ctrl+Q' ).
	keySequence := QKeySequence fromVariant: ( action property: 'shortcut' ).
	self assert: [ keySequence = ( QKeySequence new: 'Ctrl+Q' ) ].
!
