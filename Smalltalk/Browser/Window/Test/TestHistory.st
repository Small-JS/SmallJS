CLASS TestHistory EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Entries are pushed without a URL, so the URL of the test page does not change.
 Navigating is asynchronous, so the async test waits for the 'popstate' event of the window."

METHODS

test
	| history length |
	history := History default.
	self assert: [ history class = History ].
	self assert: [ history = Window default history ].
	self assert: [ history length > 0 ].

	self assert: [ history scrollRestoration = 'auto' ].
	history scrollRestoration: 'manual'.
	self assert: [ history scrollRestoration = 'manual' ].
	history scrollRestoration: 'auto'.

	length := history length.
	history pushState: 'pushed'.
	self assert: [ history length = ( length + 1 ) ].
	self assert: [ history state = 'pushed' ].

	history replaceState: 42.
	self assert: [ history length = ( length + 1 ) ].
	self assert: [ history state = 42 ].

	history replaceState: #( 1 'two' true ).
	self assert: [ history state class = Array ].
	self assert: [ history state length = 3 ].
	self assert: [ ( history state at: 1 ) = 'two' ].

	history replaceState: nil url: Window default location href.
	self assert: [ history state isNil ].
	self assert: [ history length = ( length + 1 ) ].

	history pushState: 'url' url: Window default location href.
	self assert: [ history length = ( length + 2 ) ].
	self assert: [ history state = 'url' ].
!
async testNavigate
	| history |
	history := History default.
	history pushState: 'first'.
	history pushState: 'second'.
	self assert: [ history state = 'second' ].

	history back.
	await self waitForPopState.
	self assert: [ history state = 'first' ].

	history forward.
	await self waitForPopState.
	self assert: [ history state = 'second' ].

	history go: -1.
	await self waitForPopState.
	self assert: [ history state = 'first' ].

	history go: 1.
	await self waitForPopState.
	self assert: [ history state = 'second' ].
!

"Helpers."

async waitForPopState
	"Wait until the window receives a 'popstate' event, with a timeout of 1 second."
	| window received block count |
	window := Window default.
	received := false.
	block := [ :event | received := true ].
	window addEventListener: 'popstate' then: block.
	count := 0.
	await [ received not and: [ count < 100 ] ] whileTrueAwait: async [
		await Timer timeout: 10.
		count := count + 1 ].
	window removeEventListener: 'popstate' then: block.
	self assert: [ received ].
!
