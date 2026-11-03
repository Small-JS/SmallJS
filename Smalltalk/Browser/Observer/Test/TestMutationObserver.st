CLASS TestMutationObserver EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

"Helpers"

async waitForRecords: block
	"Evaluate block with a new MutationObserver, and answer the records it receives first.
	 The observer is disconnected afterwards."
	| observer callbackObserver receiving records |
	receiving := Promise new: [ :resolve :reject |
		observer := MutationObserver new: [ :mutationRecords :mutationObserver |
			callbackObserver := mutationObserver.
			records := mutationRecords.
			resolve value: nil ].
		block value: observer ].
	await receiving js.
	observer disconnect.
	self assert: [ callbackObserver = observer ].
	^ records.
!

"Tests"

testCreation
	| observer |
	self assertError: [ MutationObserver new ].
	observer := MutationObserver new: [ :records | ].
	self assert: [ observer class = MutationObserver ].
	self assert: [ observer jsClassName = 'MutationObserver' ].
	"Observing without any of childList, attributes or characterData throws a JS TypeError."
	self assert: [ ( [ observer observe: Document new body options: MutationObserverOptions new ]
		tryCatch: [ :error | error name ] ) = 'TypeError' ].
!
testOptions
	| options |
	options := MutationObserverOptions new
		childList: true; attributes: true; characterData: true; subtree: true;
		attributeOldValue: true; characterDataOldValue: true; attributeFilter: #( 'id' 'class' ).
	self assert: [ options childList ].
	self assert: [ options attributes ].
	self assert: [ options characterData ].
	self assert: [ options subtree ].
	self assert: [ options attributeOldValue ].
	self assert: [ options characterDataOldValue ].
	self assert: [ options attributeFilter = #( 'id' 'class' ) ].
!
async testChildList
	| div span text records record |
	div := Document new createElement: 'div'.
	span := Document new createElement: 'span'.
	text := Document new createTextNode: 'Hello'.
	div appendChild: span.
	records := await self waitForRecords: [ :observer |
		observer observe: div options: ( MutationObserverOptions new childList: true ).
		div appendChild: text.
		span remove ].
	self assert: [ records length = 2 ].
	record := records first.
	self assert: [ record class = MutationRecord ].
	self assert: [ record type = 'childList' ].
	self assert: [ record target = div ].
	self assert: [ record target class = HtmlDivElement ].
	self assert: [ record addedNodes = ( Array with: text ) ].
	self assert: [ record addedNodes first class = Text ].
	self assert: [ record removedNodes isEmpty ].
	self assert: [ record previousSibling = span ].
	self assert: [ record nextSibling isNil ].
	self assert: [ record attributeName isNil ].
	self assert: [ record oldValue isNil ].
	record := records last.
	self assert: [ record removedNodes = ( Array with: span ) ].
	self assert: [ record removedNodes first class = HtmlSpanElement ].
	self assert: [ record previousSibling isNil ].
	self assert: [ record nextSibling = text ].
!
async testAttributes
	| div records record |
	div := ( Document new createElement: 'div' ) id: 'old'.
	records := await self waitForRecords: [ :observer |
		observer observe: div options: ( MutationObserverOptions new attributeFilter: #( 'id' ); attributeOldValue: true ).
		div className: 'ignored'.
		div id: 'new' ].
	self assert: [ records length = 1 ].
	record := records first.
	self assert: [ record type = 'attributes' ].
	self assert: [ record target = div ].
	self assert: [ record attributeName = 'id' ].
	self assert: [ record attributeNamespace isNil ].
	self assert: [ record oldValue = 'old' ].
	self assert: [ record addedNodes isEmpty ].
!
async testCharacterData
	| div text records record |
	div := Document new createElement: 'div'.
	text := Document new createTextNode: 'old'.
	div appendChild: text.
	records := await self waitForRecords: [ :observer |
		observer observe: div options: ( MutationObserverOptions new subtree: true; characterDataOldValue: true ).
		text data: 'new' ].
	self assert: [ records length = 1 ].
	record := records first.
	self assert: [ record type = 'characterData' ].
	self assert: [ record target = text ].
	self assert: [ record target class = Text ].
	self assert: [ record oldValue = 'old' ].
!
testTakeRecords
	| div observer records |
	div := Document new createElement: 'div'.
	observer := MutationObserver new: [ :mutationRecords | self assert: [ false ] ].
	observer observe: div options: ( MutationObserverOptions new attributes: true ).
	div id: 'id1'.
	div id: 'id2'.
	"Taking the pending records synchronously prevents calling the block."
	records := observer takeRecords.
	self assert: [ records length = 2 ].
	self assert: [ records first class = MutationRecord ].
	self assert: [ records first attributeName = 'id' ].
	self assert: [ observer takeRecords isEmpty ].
	"After disconnect, changes are not reported."
	observer disconnect.
	div id: 'id3'.
	self assert: [ observer takeRecords isEmpty ].
!
