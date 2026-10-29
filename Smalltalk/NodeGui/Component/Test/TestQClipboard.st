CLASS TestQClipboard EXTENDS Test MODULE TestNodeGui CLASSVARS '' VARS ''

"The tests restore the text on the clipboard of the user.
 An image on the clipboard is not restored, because it would be replaced by text."

test
	| clipboard oldText |
	clipboard := QApplication clipboard.
	self assert: [ clipboard jsClassName = 'QClipboard' ].
	self assert: [ QApplication clipboard = clipboard ].
	oldText := clipboard text.

	clipboard setText: 'SmallJS clipboard test'.
	self assert: [ clipboard text = 'SmallJS clipboard test' ].
	clipboard setText: oldText.
	self assert: [ clipboard text = oldText ].
!
testPixmap
	| clipboard oldText |
	clipboard := QApplication clipboard.
	oldText := clipboard text.

	clipboard setPixmap: ( QPixmap fromImage: ( QImage width: 4 height: 3 ) ).
	self assert: [ clipboard pixmap size = ( QSize width: 4 height: 3 ) ].
	clipboard setText: oldText.
!
