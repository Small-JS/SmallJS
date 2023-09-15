CLASS TestClipboard EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| clipboard clipboardReadButton clipboardWriteButton |

	clipboard := Window default navigator clipboard.
	self assert: [ clipboard class = Clipboard ].

	clipboardReadButton := Document default getElementById: 'clipboardReadButton'.
	self assert: [ clipboardReadButton class = HtmlButtonElement ].
	clipboardReadButton addEventListener: 'click' then: [ self onClipboardReadButton ].

	clipboardWriteButton := Document default getElementById: 'clipboardWriteButton'.
	self assert: [ clipboardWriteButton class = HtmlButtonElement ].
	clipboardWriteButton addEventListener: 'click' then: [ self onClipboardWriteButton ].

!
onClipboardReadButton
	| clipboardResultLabel |

	clipboardResultLabel := Document default getElementById: 'clipboardResultLabel'.
	self assert: [ clipboardResultLabel class = HtmlLabelElement ].

	Window default navigator clipboard readTextThen:
		[ :text | clipboardResultLabel textContent: text ].
!
onClipboardWriteButton
	| clipboardInput clipboardResultLabel |

	clipboardInput := Document default getElementById: 'clipboardInput'.
	self assert: [ clipboardInput class = HtmlInputElement ].

	clipboardResultLabel := Document default getElementById: 'clipboardResultLabel'.
	self assert: [ clipboardResultLabel class = HtmlLabelElement ].

	Window default navigator clipboard writeText: clipboardInput value then:
		[ :text | clipboardResultLabel textContent: '[written]' ].
!
