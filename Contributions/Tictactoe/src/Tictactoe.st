CLASS Tictactoe EXTENDS Object MODULE TictactoeApp CLASSVARS '' VARS 'cells winner gameOver'

"Var cells is a 9 element array (index 0-8, row-major) holding
 Tictactoe humanMark, Tictactoe computerMark or nil per board cell."

CLASSMETHODS

humanMark
	^ 'X'.
!
computerMark
	^ 'O'.
!

METHODS

constructor
	self reset.
!
reset
	"Clear the board and start a new game."

	cells := Array new: 9.
	winner := nil.
	gameOver := false.
!

"Accessing"

at: index
	^ cells at: index.
!
winner
	^ winner.
!
gameOver
	^ gameOver.
!
isDraw
	^ gameOver & winner isNil.
!

"Playing"

move: index mark: mark
	"Place mark at index if the move is valid.
	 Return true if the move was made, false otherwise."

	( self isValidMove: index ) ifFalse: [ ^ false ].

	cells at: index put: mark.
	winner := self lineWinner.
	gameOver := winner notNil | self isFull.
	^ true.
!
isValidMove: index
	^ gameOver not & ( ( cells at: index ) isNil ).
!
computerMoveFor: mark against: opponentMark
	"Determine the best move index for mark, by searching all possible games to
	 the end with minimax, so the computer always plays optimally: it wins when
	 a forced win exists and otherwise never loses."

	| bestScore bestMove score |

	bestScore := -999.
	bestMove := nil.
	0 to: 8 do: [ :index |
		( cells at: index ) isNil ifTrue: [
			cells at: index put: mark.
			score := self minimaxFor: mark against: opponentMark maximizing: false depth: 1 alpha: -999 beta: 999.
			cells at: index put: nil.

			score > bestScore ifTrue: [
				bestScore := score.
				bestMove := index ] ] ].

	^ bestMove.
!

"Private"

winningLines
	^ #(
		#( 0 1 2 ) #( 3 4 5 ) #( 6 7 8 )
		#( 0 3 6 ) #( 1 4 7 ) #( 2 5 8 )
		#( 0 4 8 ) #( 2 4 6 ) ).
!
isFull
	^ ( cells findIndex: [ :cell | cell isNil ] ) = -1.
!
lineWinner
	"Return the mark that completed a line, or nil."

	| winningLine |

	winningLine := self winningLines find: [ :line |
		( cells at: ( line at: 0 ) ) notNil
			& ( ( cells at: ( line at: 0 ) ) = ( cells at: ( line at: 1 ) ) )
			& ( ( cells at: ( line at: 1 ) ) = ( cells at: ( line at: 2 ) ) ) ].

	^ winningLine isNil
		ifTrue: [ nil ]
		ifFalse: [ cells at: ( winningLine at: 0 ) ].
!
minimaxFor: mark against: opponentMark maximizing: maximizing depth: depth alpha: alpha beta: beta
	"Recursively score the current board for mark, assuming optimal play by both sides.
	 A quick win for mark scores high, a quick win for opponentMark scores low,
	 a completed board with no winner (a draw) scores 0.
	 Alpha-beta pruning skips branches that cannot change the outcome, since plain
	 minimax on the first move of a game (the full 9 cell search) is noticeably slow."

	| winner player bestScore score currentAlpha currentBeta |

	winner := self lineWinner.
	winner = mark ifTrue: [ ^ 10 - depth ].
	winner = opponentMark ifTrue: [ ^ depth - 10 ].
	self isFull ifTrue: [ ^ 0 ].

	player := maximizing ifTrue: [ mark ] ifFalse: [ opponentMark ].
	bestScore := maximizing ifTrue: [ -999 ] ifFalse: [ 999 ].
	currentAlpha := alpha.
	currentBeta := beta.

	0 to: 8 do: [ :index |
		( ( cells at: index ) isNil & ( currentAlpha < currentBeta ) ) ifTrue: [
			cells at: index put: player.
			score := self minimaxFor: mark against: opponentMark
				maximizing: maximizing not depth: depth + 1 alpha: currentAlpha beta: currentBeta.
			cells at: index put: nil.

			maximizing
				ifTrue: [
					bestScore := bestScore max: score.
					currentAlpha := currentAlpha max: bestScore ]
				ifFalse: [
					bestScore := bestScore min: score.
					currentBeta := currentBeta min: bestScore ] ] ].

	^ bestScore.
!
