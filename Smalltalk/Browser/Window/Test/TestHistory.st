CLASS TestHistory EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Adding entries to the real session history would prevent the test page from closing itself
 after the tests, because scripts may only close windows with a single history entry.
 This also holds for entries added in an iframe, and popups require user consent.
 So the real history is only tested with methods that do not add entries,
 and the methods that add or navigate entries are tested with a mock JS history object."

METHODS

test
	| history |
	history := History default.
	self assert: [ history class = History ].
	self assert: [ history = Window default history ].
	self assert: [ history length > 0 ].

	self assert: [ history scrollRestoration = 'auto' ].
	history scrollRestoration: 'manual'.
	self assert: [ history scrollRestoration = 'manual' ].
	history scrollRestoration: 'auto'.
!
testReplaceState
	"Replacing the state of the current entry does not add entries."
	| history length state href |
	history := History default.
	length := history length.
	state := history state.
	href := Window default location href.

	history replaceState: 'replaced'.
	self assert: [ history state = 'replaced' ].

	history replaceState: 42.
	self assert: [ history state = 42 ].

	history replaceState: #( 1 'two' true ).
	self assert: [ history state class = Array ].
	self assert: [ history state length = 3 ].
	self assert: [ ( history state at: 1 ) = 'two' ].

	history replaceState: 'url' url: href.
	self assert: [ history state = 'url' ].
	self assert: [ Window default location href = href ].

	history replaceState: nil.
	self assert: [ history state isNil ].
	self assert: [ history length = length ].

	"Restore the original state."
	history replaceState: state url: href.
!
testPushState
	| history |
	history := self mockHistory.
	self assert: [ history length = 1 ].
	self assert: [ history state isNil ].

	history pushState: 'first'.
	self assert: [ history length = 2 ].
	self assert: [ history state = 'first' ].
	self assert: [ Boolean fromJs: INLINE 'history.js.lastUrl === undefined' ].

	history pushState: #( 1 'two' ) url: 'page.html'.
	self assert: [ history length = 3 ].
	self assert: [ ( history state at: 1 ) = 'two' ].
	self assert: [ ( String fromJs: INLINE 'history.js.lastUrl' ) = 'page.html' ].

	history replaceState: 'replaced' url: 'other.html'.
	self assert: [ history length = 3 ].
	self assert: [ history state = 'replaced' ].
	self assert: [ ( String fromJs: INLINE 'history.js.lastUrl' ) = 'other.html' ].
!
testNavigate
	| history |
	history := self mockHistory.
	history pushState: 'first'.
	history pushState: 'second'.
	self assert: [ history state = 'second' ].

	history back.
	self assert: [ history state = 'first' ].
	history forward.
	self assert: [ history state = 'second' ].
	history go: -2.
	self assert: [ history state isNil ].
	history go: 1.
	self assert: [ history state = 'first' ].
	self assert: [ history length = 3 ].

	"Pushing removes the entries after the current one."
	history pushState: 'third'.
	self assert: [ history length = 3 ].
	history forward.
	self assert: [ history state = 'third' ].
!

"Helpers."

mockHistory
	"Return a History on a mock JS object that implements a session history in memory.
	 It stores the URL passed by the last push or replace in: lastUrl."
	^ History fromJs: INLINE '{
		entries: [ null ], index: 0, scrollRestoration: "auto",
		get length() { return this.entries.length; },
		get state() { return this.entries[ this.index ]; },
		pushState( state, unused, url ) {
			this.entries.splice( this.index + 1 );
			this.entries.push( state ); this.index++; this.lastUrl = url; },
		replaceState( state, unused, url ) { this.entries[ this.index ] = state; this.lastUrl = url; },
		go( delta ) {
			const index = this.index + ( delta ?? 0 );
			if( index >= 0 && index < this.entries.length ) this.index = index; },
		back() { this.go( -1 ); },
		forward() { this.go( 1 ); } }'.
!
