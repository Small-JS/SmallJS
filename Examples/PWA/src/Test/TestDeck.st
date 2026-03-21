CLASS TestDeck EXTENDS Test MODULE TestDeckApp CLASSVARS '' VARS ''

async test
	| size deck card emptyCard x |

	"Uneven size, so empty card will be added."
	size := 5 @ 3.
	deck := await Deck initialize: size.
	self assert: [ deck allCardFaces length > 100 ].
	self assert: [ deck size = size ].
	self assert: [ deck length = 14 ].
	self assert: [ deck cards length = 15 ].

	"Check a normal card"
	card := deck cardAt: 3 @ 1.
	self assert: [ card face length > 1 ].
	self assert: [ card turned not ].

	"The last card should be empty."
	emptyCard := deck cardAt: 4 @ 2.
	self assert: [ emptyCard face = 'X' ].
	self assert: [ emptyCard turned ].
!
