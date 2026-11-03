CLASS TestResizeObserver EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

"Helpers"

newDiv
	"Answer a new div of 100 x 50 pixels content, with 10 pixels padding and 1 pixel border,
	 appended to the body of the page, so it is rendered. Remove it after the test."
	| div |
	div := Document default createElement: 'div'.
	div setAttribute: 'style' value: 'width: 100px; height: 50px; padding: 10px; border: 1px solid; box-sizing: content-box'.
	Document default body appendChild: div.
	^ div.
!
async waitForEntries: observe
	"Evaluate block observe with a new ResizeObserver, and answer the entries it receives first.
	 The observer is disconnected afterwards."
	| observer callbackObserver receiving entries |
	receiving := Promise new: [ :resolve :reject |
		observer := ResizeObserver new: [ :resizeEntries :resizeObserver |
			callbackObserver := resizeObserver.
			entries := resizeEntries.
			resolve value: nil ].
		observe value: observer ].
	await receiving js.
	observer disconnect.
	self assert: [ callbackObserver = observer ].
	^ entries.
!

"Tests"

testCreation
	| observer |
	self assertError: [ ResizeObserver new ].
	observer := ResizeObserver new: [ :entries | ].
	self assert: [ observer class = ResizeObserver ].
	self assert: [ observer jsClassName = 'ResizeObserver' ].
	observer disconnect.
!
testOptions
	| options |
	options := ResizeObserverOptions new box: 'border-box'.
	self assert: [ options box = 'border-box' ].
!
async testObserve
	| div entries entry |
	div := self newDiv.
	entries := await self waitForEntries: [ :observer | observer observe: div ].
	div remove.
	self assert: [ entries length = 1 ].
	entry := entries first.
	self assert: [ entry class = ResizeObserverEntry ].
	self assert: [ entry target = div ].
	self assert: [ entry target class = HtmlDivElement ].
	self assert: [ entry contentRect = ( Rect origin: 10 @ 10 extent: 100 @ 50 ) ].
	self assert: [ entry contentBoxSize length = 1 ].
	self assert: [ entry contentBoxSize first class = ResizeObserverSize ].
	self assert: [ entry contentBoxSize first inlineSize = 100 ].
	self assert: [ entry contentBoxSize first blockSize = 50 ].
	self assert: [ entry borderBoxSize first inlineSize = 122 ].
	self assert: [ entry borderBoxSize first blockSize = 72 ].
	self assert: [ entry devicePixelContentBoxSize first inlineSize > 0 ].
!
async testResize
	"After the initial size, a size change is reported.
	 With box 'border-box', a padding change is a size change, although the content size is the same.
	 The size is changed after the block, because changing it in the block
	 makes the browser report a 'ResizeObserver loop' error."
	| div observer resizing sizes |
	div := self newDiv.
	sizes := Array new.
	resizing := Promise new: [ :resolve :reject |
		observer := ResizeObserver new: [ :entries |
			sizes add: entries first borderBoxSize first inlineSize.
			sizes length = 1 ifTrue: [ Timer timeout: 0 then: [
				div setAttribute: 'style' value: 'width: 100px; height: 50px; padding: 20px; border: 1px solid' ] ].
			sizes length = 2 ifTrue: [ resolve value: nil ] ].
		observer observe: div options: ( ResizeObserverOptions new box: 'border-box' ) ].
	await resizing js.
	observer disconnect.
	div remove.
	self assert: [ sizes = #( 122 142 ) ].
!
async testUnobserve
	"After unobserve, size changes of that target are not reported."
	| div1 div2 entries |
	div1 := self newDiv.
	div2 := self newDiv.
	entries := await self waitForEntries: [ :observer |
		observer observe: div1.
		observer observe: div2.
		observer unobserve: div1 ].
	div1 remove.
	div2 remove.
	self assert: [ entries length = 1 ].
	self assert: [ entries first target = div2 ].
!
