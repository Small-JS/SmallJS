CLASS TestIntersectionObserver EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"The tests use a scrolling root div, so they do not depend on the size of the browser viewport."

METHODS

"Helpers"

newRoot
	"Answer a new root div of 100 x 100 pixels that scrolls its content,
	 appended to the body of the page, so it is rendered, with a child div of 100 x 50 pixels at the top
	 and one below it, outside the visible area. Remove it after the test."
	| root |
	root := Document default createElement: 'div'.
	root setAttribute: 'style' value: 'width: 100px; height: 100px; overflow: scroll; scrollbar-width: none'.
	root innerHtml: '<div id="visible" style="height: 50px"></div>',
		'<div style="height: 200px"></div><div id="hidden" style="height: 50px"></div>'.
	Document default body appendChild: root.
	^ root.
!
async waitForEntries: observe options: options
	"Evaluate block observe with a new IntersectionObserver, and answer the entries it receives first.
	 The observer is disconnected afterwards."
	| observer callbackObserver receiving entries |
	receiving := Promise new: [ :resolve :reject |
		observer := IntersectionObserver
			new: [ :intersectionEntries :intersectionObserver |
				callbackObserver := intersectionObserver.
				entries := intersectionEntries.
				resolve value: nil ]
			options: options.
		observe value: observer ].
	await receiving js.
	observer disconnect.
	self assert: [ callbackObserver = observer ].
	^ entries.
!

"Tests"

testCreation
	| observer root options |
	self assertError: [ IntersectionObserver new ].
	observer := IntersectionObserver new: [ :entries | ].
	self assert: [ observer class = IntersectionObserver ].
	self assert: [ observer jsClassName = 'IntersectionObserver' ].
	self assert: [ observer root isNil ].
	self assert: [ observer rootMargin = '0px 0px 0px 0px' ].
	self assert: [ observer thresholds = #( 0 ) ].
	observer disconnect.

	root := Document new createElement: 'div'.
	options := IntersectionObserverOptions new root: root; rootMargin: '10px 20%'; threshold: #( 1 0.5 ).
	observer := IntersectionObserver new: [ :entries | ] options: options.
	self assert: [ observer root = root ].
	self assert: [ observer root class = HtmlDivElement ].
	self assert: [ observer rootMargin = '10px 20% 10px 20%' ].
	self assert: [ observer thresholds = #( 0.5 1 ) ].
	observer disconnect.

	"Invalid options throw a JS DOMException or RangeError, not an Error."
	options := IntersectionObserverOptions new rootMargin: 'x'.
	self assert: [ ( [ IntersectionObserver new: [ :entries | ] options: options ]
		tryCatch: [ :error | error name ] ) = 'SyntaxError' ].
	options := IntersectionObserverOptions new threshold: 2.
	self assert: [ ( [ IntersectionObserver new: [ :entries | ] options: options ]
		tryCatch: [ :error | error name ] ) = 'RangeError' ].
!
testOptions
	| root options |
	root := Document new createElement: 'div'.
	options := IntersectionObserverOptions new root: root; rootMargin: '10px'; threshold: 0.5.
	self assert: [ options root = root ].
	self assert: [ options rootMargin = '10px' ].
	self assert: [ options threshold = 0.5 ].
	options threshold: #( 0 1 ).
	self assert: [ options threshold = #( 0 1 ) ].
!
async testObserve
	| root visible hidden options entries entry |
	root := self newRoot.
	visible := root querySelector: '#visible'.
	hidden := root querySelector: '#hidden'.
	options := IntersectionObserverOptions new root: root.
	entries := await self
		waitForEntries: [ :observer | observer observe: visible; observe: hidden ]
		options: options.
	root remove.
	self assert: [ entries length = 2 ].

	entry := entries first.
	self assert: [ entry class = IntersectionObserverEntry ].
	self assert: [ entry target = visible ].
	self assert: [ entry target class = HtmlDivElement ].
	self assert: [ entry isIntersecting ].
	self assert: [ entry intersectionRatio = 1 ].
	"The Rects are of the time of the change. Only compare their extents,
	 because the positions change when other tests change the page."
	self assert: [ entry boundingClientRect extent = ( 100 @ 50 ) ].
	self assert: [ entry intersectionRect = entry boundingClientRect ].
	self assert: [ entry rootBounds extent = ( 100 @ 100 ) ].
	self assert: [ entry time > 0 ].

	entry := entries last.
	self assert: [ entry target = hidden ].
	self assert: [ entry isIntersecting not ].
	self assert: [ entry intersectionRatio = 0 ].
	self assert: [ entry intersectionRect extent = ( 0 @ 0 ) ].
!
async testRootMargin
	"Growing the root box with rootMargin makes the hidden child intersect."
	| root hidden options entries |
	root := self newRoot.
	hidden := root querySelector: '#hidden'.
	options := IntersectionObserverOptions new root: root; rootMargin: '0px 0px 200px 0px'.
	entries := await self
		waitForEntries: [ :observer | observer observe: hidden ]
		options: options.
	root remove.
	self assert: [ entries first isIntersecting ].
	self assert: [ entries first intersectionRatio = 1 ].
!
testTakeRecords
	| root options observer records |
	root := self newRoot.
	options := IntersectionObserverOptions new root: root.
	observer := IntersectionObserver new: [ :entries | ] options: options.
	observer observe: ( root querySelector: '#visible' ).
	"Some browsers, like Chrome, already compute the initial entry here, others only when rendering."
	records := observer takeRecords.
	self assert: [ records length <= 1 ].
	self assert: [ records every: [ :entry | entry class = IntersectionObserverEntry ] ].
	"Taken records are removed."
	self assert: [ observer takeRecords isEmpty ].
	observer unobserve: ( root querySelector: '#visible' ).
	observer disconnect.
	root remove.
!
