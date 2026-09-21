CLASS TestTictactoe EXTENDS Test MODULE TestTictactoeApp CLASSVARS '' VARS ''

testWin
	| game |

	game := Tictactoe new.
	self assert: [ game gameOver not ].
	self assert: [ game winner isNil ].

	"Human wins the top row: 0 1 2."
	game move: 0 mark: Tictactoe humanMark.
	self assert: [ ( game at: 0 ) = Tictactoe humanMark ].
	game move: 3 mark: Tictactoe computerMark.
	game move: 1 mark: Tictactoe humanMark.
	game move: 4 mark: Tictactoe computerMark.
	game move: 2 mark: Tictactoe humanMark.

	self assert: [ game gameOver ].
	self assert: [ game winner = Tictactoe humanMark ].
	self assert: [ game isDraw not ].

	"Once the game is over, further moves are rejected."
	self assert: [ ( game move: 5 mark: Tictactoe computerMark ) not ].
!
testInvalidMove
	| game |

	game := Tictactoe new.
	game move: 0 mark: Tictactoe humanMark.

	"Cell 0 is already taken."
	self assert: [ ( game move: 0 mark: Tictactoe computerMark ) not ].
	self assert: [ ( game at: 0 ) = Tictactoe humanMark ].
!
testDraw
	| game |

	"X O X
	 X O O
	 O X X   -> full board, no line, a draw."
	game := Tictactoe new.
	game move: 0 mark: Tictactoe humanMark.
	game move: 1 mark: Tictactoe computerMark.
	game move: 2 mark: Tictactoe humanMark.
	game move: 3 mark: Tictactoe humanMark.
	game move: 4 mark: Tictactoe computerMark.
	game move: 5 mark: Tictactoe computerMark.
	game move: 6 mark: Tictactoe computerMark.
	game move: 7 mark: Tictactoe humanMark.
	game move: 8 mark: Tictactoe humanMark.

	self assert: [ game gameOver ].
	self assert: [ game winner isNil ].
	self assert: [ game isDraw ].
!
testComputerWinsWhenPossible
	| game move |

	"Computer already has two in a row (3 4), so it should win by playing 5."
	game := Tictactoe new.
	game move: 3 mark: Tictactoe computerMark.
	game move: 0 mark: Tictactoe humanMark.
	game move: 4 mark: Tictactoe computerMark.
	game move: 1 mark: Tictactoe humanMark.

	move := game computerMoveFor: Tictactoe computerMark against: Tictactoe humanMark.
	self assert: [ move = 5 ].
!
testComputerBlocksHuman
	| game move |

	"Human has two in a row (0 1), so the computer should block at 2."
	game := Tictactoe new.
	game move: 0 mark: Tictactoe humanMark.
	game move: 8 mark: Tictactoe computerMark.
	game move: 1 mark: Tictactoe humanMark.

	move := game computerMoveFor: Tictactoe computerMark against: Tictactoe humanMark.
	self assert: [ move = 2 ].
!
testComputerTakesCenter
	| game move |

	game := Tictactoe new.
	game move: 0 mark: Tictactoe humanMark.

	move := game computerMoveFor: Tictactoe computerMark against: Tictactoe humanMark.
	self assert: [ move = 4 ].
!
