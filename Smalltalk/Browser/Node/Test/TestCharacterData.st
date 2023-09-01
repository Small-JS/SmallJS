CLASS TestCharacterData EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''
	"Note: CharacterData is an abstract class.
		We will test using instances of the Text subsclass."

METHODS

browserOnly
	^ true.
!
testProperties
	| text |

	text := Document default createTextNode: 'My Text'.
	self assert: [ text data = 'My Text' ].
	text data: text data, '!'.
	self assert: [ text data = 'My Text!' ].
	self assert: [ text length = 8 ].
	self assert: [ text nextElementSibling = nil ].
	self assert: [ text previousElementSibling = nil ].
!
testNodeMethods
	| paragraph text |

	paragraph := ( Document default createElement: 'p' ) textContent: 'My Paragraph'.
	text := paragraph firstChild.
	text before: '>'.
	self assert: [ paragraph firstChild data = '>' ].
	text after: '<'.
	self assert: [ paragraph lastChild data = '<' ].
	self assert: [ paragraph childNodes length = 3 ].

	paragraph lastChild replaceWith: '<!'.
	self assert: [ paragraph lastChild data = '<!' ].
!
testDataMethods
	| text |

	text := Text new data: 'ab'.

	text appendData: 'cd'.
	self assert: [ text data = 'abcd' ].

	text deleteDataAt: 2 count: 2.
	self assert: [ text data = 'ad' ].

	text insertDataAt: 2 with: '12'.
	self assert: [ text data = 'a12d' ].

	text replaceDataAt: 2 count: 2 with: '345'.
	self assert: [ text data = 'a345d' ].

	self assert: [ ( text substringDataAt: 2 count: 3 ) = '345' ].
!
