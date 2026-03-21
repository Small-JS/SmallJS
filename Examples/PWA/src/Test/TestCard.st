CLASS TestCard EXTENDS Test MODULE TestDeckApp CLASSVARS '' VARS ''

async test
	| card card2 emptyCard |

	"Normal card"
	card := Card face: 'K'.
	self assert: [ card face = 'K' ].
	self assert: [ card turned not ].

	card face: 'Q'.
	self assert: [ card face = 'Q' ].

	card turned: true.
	self assert: [ card turned ].
	self assert: [ card display = 'Q' ].

	card turned: false.
	self assert: [ card display = card back ].

	card2 := card copy.
	self assert: [ card2 face = card face ].
	card2 face: 'A'.
	self assert: [ card2 face ~= card face ].

	"Empty card"
	emptyCard := Card empty.
	self assert: [ emptyCard face = 'X' ].
	self assert: [ emptyCard turned ].
!

