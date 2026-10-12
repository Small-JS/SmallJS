CLASS TestClipboard EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Note: Reading and writing the clipboard may require user permission and a focused document,
 so there are no automated unit tests for them.
 Functionality is tested interactively in MyBrowserApp.
 ClipboardItem is tested in TestClipboardItem."

METHODS

test
	| clipboard |
	clipboard := Window default navigator clipboard.
	self assert: [ clipboard class = Clipboard ].
	self assert: [ Clipboard default = clipboard ].
!
testEvents
	"Clipboard is an EventTarget."
	| clipboard received block |
	clipboard := Clipboard default.
	block := [ :event | received := event ].
	clipboard addEventListener: 'test' then: block.
	clipboard dispatchEvent: ( Event type: 'test' ).
	self assert: [ received type = 'test' ].
	clipboard removeEventListener: 'test' then: block.
!
