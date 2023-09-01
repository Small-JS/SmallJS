CLASS TestText EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

METHODS

browserOnly
	^ true.
!
test
	| text paragraph |

	text := Text new: 'abcd'.
	self assert: [ text data = 'abcd' ].
	self assert: [ text assignedSlot = nil ].
	self assert: [ text wholeText = 'abcd' ].

	paragraph := Document default createElement: 'p'.
	text := Document default createTextNode: 'RedBlue'.
	paragraph appendChild: text.
	paragraph firstChild splitText: 4.
	self assert: [ paragraph firstChild data = 'Red' ].
	self assert: [ paragraph lastChild data = 'Blue' ].
!
