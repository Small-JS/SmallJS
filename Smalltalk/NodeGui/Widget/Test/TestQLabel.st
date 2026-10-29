CLASS TestQLabel EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

test
	| label |

	label := QLabel new.
	self assert: [ label jsClassName = 'QLabel' ].

	label setText: 'My Label'.
	self assert: [ label text = 'My Label' ].
	label clear.
	self assert: [ label text = '' ].

	label setNumInt: 42.
	self assert: [ label text = '42' ].
	label setNumDouble: 1.5.
	self assert: [ label text = '1.5' ].
!
testTextFormat
	| label |
	label := QLabel new.
	self assert: [ label textFormat = QLabel autoText ].
	label setTextFormat: QLabel richText.
	self assert: [ label textFormat = QLabel richText ].
	label setTextFormat: QLabel markdownText.
	self assert: [ label textFormat = QLabel markdownText ].

	self assert: [ label wordWrap not ].
	label setWordWrap: true.
	self assert: [ label wordWrap ].

	self assert: [ label openExternalLinks not ].
	label setOpenExternalLinks: true.
	self assert: [ label openExternalLinks ].
!
testLayout
	| label |
	label := QLabel new.
	label setAlignment: QLayout alignRight + QLayout alignTop.
	self assert: [ label alignment = ( QLayout alignRight + QLayout alignTop ) ].

	self assert: [ label indent = -1 ].
	label setIndent: 10.
	self assert: [ label indent = 10 ].
	label setMargin: 5.
	self assert: [ label margin = 5 ].

	self assert: [ label hasScaledContents not ].
	label setScaledContents: true.
	self assert: [ label hasScaledContents ].
!
testBuddy
	| label lineEdit |
	label := QLabel new setText: '&Name'.
	self assert: [ label buddy isNil ].
	lineEdit := QLineEdit new.
	label setBuddy: lineEdit.
	self assert: [ label buddy = lineEdit ].
!
testSelection
	| label |
	label := QLabel new setText: 'Hello World'.
	self assert: [ label textInteractionFlags = QLabel linksAccessibleByMouse ].
	self assert: [ label hasSelectedText not ].
	self assert: [ label selectionStart = -1 ].

	label setTextInteractionFlags: QLabel textSelectableByMouse + QLabel textSelectableByKeyboard.
	self assert: [ label textInteractionFlags = 3 ].
	label setSelection: 6 length: 5.
	self assert: [ label selectedText = 'World' ].
	self assert: [ label selectionStart = 6 ].
	self assert: [ label hasSelectedText ].
!
testMovie
	| label movie |
	label := QLabel new.
	self assert: [ label movie isNil ].
	movie := QMovie new: 'assets/heart.gif'.
	label setMovie: movie.
	self assert: [ label movie = movie ].
!
testEvents
	"The events are fired by the user clicking links only."
	| label |
	label := QLabel new setText: '<a href="https://smalljs.org">SmallJS</a>'.
	label onLinkActivate: [ :link | self assert: [ false ] ].
	label onLinkHover: [ :link | self assert: [ false ] ].
!
