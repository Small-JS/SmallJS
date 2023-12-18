CLASS TestClipboard EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| clipboard clipboardReadButton clipboardWriteButton |

	clipboard := Window default navigator clipboard.
	self assert: [ clipboard class = Clipboard ].

	clipboardReadButton := Document getElementById: 'clipboardReadButton'.
	self assert: [ clipboardReadButton class = HtmlButtonElement ].
	clipboardReadButton addEventListener: 'click' then: [ self onClipboardReadButton ].

	clipboardWriteButton := Document getElementById: 'clipboardWriteButton'.
	self assert: [ clipboardWriteButton class = HtmlButtonElement ].
	clipboardWriteButton addEventListener: 'click' then: [ self onClipboardWriteButton ].

!
onClipboardReadButton
	| clipboardResultLabel |

	clipboardResultLabel := Document getElementById: 'clipboardResultLabel'.
	self assert: [ clipboardResultLabel class = HtmlLabelElement ].

	Window default navigator clipboard readTextThen:
		[ :text | clipboardResultLabel textContent: text ].
!
onClipboardWriteButton
	| clipboardInput clipboardResultLabel |

	clipboardInput := Document getElementById: 'clipboardInput'.
	self assert: [ clipboardInput class = HtmlInputElement ].

	clipboardResultLabel := Document getElementById: 'clipboardResultLabel'.
	self assert: [ clipboardResultLabel class = HtmlLabelElement ].

	Window default navigator clipboard writeText: clipboardInput value then:
		[ :text | clipboardResultLabel textContent: '[written]' ].
!
