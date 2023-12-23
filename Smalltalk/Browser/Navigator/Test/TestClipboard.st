CLASS TestClipboard EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| clipboard clipboardReadButton clipboardWriteButton |

	clipboard := Window default navigator clipboard.
	self assert: [ clipboard class = Clipboard ].

	clipboardReadButton := Document getElementById: 'clipboardReadButton' class: HtmlButtonElement.
	clipboardReadButton addEventListener: 'click' then: [ self onClipboardReadButton ].

	clipboardWriteButton := Document getElementById: 'clipboardWriteButton' class: HtmlButtonElement.
	clipboardWriteButton addEventListener: 'click' then: [ self onClipboardWriteButton ].

!
onClipboardReadButton
	| clipboardResultLabel |

	clipboardResultLabel := Document getElementById: 'clipboardResultLabel' class: HtmlLabelElement.

	Window default navigator clipboard readTextThen:
		[ :text | clipboardResultLabel textContent: text ].
!
onClipboardWriteButton
	| clipboardInput clipboardResultLabel |

	clipboardInput := Document getElementById: 'clipboardInput' class: HtmlInputElement.
	clipboardResultLabel := Document getElementById: 'clipboardResultLabel' class: HtmlLabelElement.

	Window default navigator clipboard writeText: clipboardInput value then:
		[ :text | clipboardResultLabel textContent: '[written]' ].
!
