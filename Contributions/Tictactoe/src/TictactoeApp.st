CLASS TictactoeApp EXTENDS BrowserApp MODULE TictactoeApp CLASSVARS ''
	VARS 'game cellElements boardTable statusSpan newGameButton'

start
	game := Tictactoe new.
	self bindElements.
	self createBoardTable.
	self update.
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	boardTable := Document getElementById: 'boardTable' class: HtmlTableElement.
	boardTable onClick: [ :event | self boardTableClicked: event ].

	statusSpan := Document getElementById: 'statusSpan' class: HtmlSpanElement.

	newGameButton := Document getElementById: 'newGameButton' class: HtmlButtonElement.
	newGameButton onClick: [ self newGame ].
!
createBoardTable
	"Create the 3x3 grid of cells in the board table and cache them,
	 row-major, so cellElements index matches a Tictactoe board index."

	| row |

	boardTable removeChildren.
	cellElements := Array new.
	0 to: 2 do: [ :y |
		row := boardTable insertRow: -1.
		0 to: 2 do: [ :x |
			cellElements add: row insertCell ] ].
!
update
	"Update board cells and status message in HTML page."

	0 to: 8 do: [ :index |
		| mark |
		mark := game at: index.
		( cellElements at: index ) textContent: ( mark isNil ifTrue: [ '' ] ifFalse: [ mark ] ) ].

	self updateStatus.
!
updateStatus
	game gameOver
		ifTrue: [
			game isDraw
				ifTrue: [ statusSpan textContent: 'Draw!' ]
				ifFalse: [
					statusSpan textContent: ( game winner = Tictactoe humanMark
						ifTrue: [ 'You win!' ]
						ifFalse: [ 'Computer wins!' ] ) ] ]
		ifFalse: [ statusSpan textContent: 'Your turn' ].
!
async boardTableClicked: event
	"Handle click on a board cell: place the human mark,
	 then let the computer respond after a short pause."

	| cell position index |

	game gameOver ifTrue: [ ^ nil ].

	cell := HtmlElement fromJsSubElement: event target js.
	cell class ~= HtmlTableCellElement ifTrue: [
		cell := cell parentElement ].
	position := Point x: cell cellIndex y: cell parentElement rowIndex.
	index := position y * 3 + position x.

	( game move: index mark: Tictactoe humanMark ) ifFalse: [ ^ nil ].
	self update.

	game gameOver ifTrue: [ ^ nil ].
	await self computerMove.
!
async computerMove
	"Let the computer play its move, after a short delay for realism."

	| index |

	statusSpan textContent: 'Computer is thinking...'.
	await Timer timeout: 500.

	index := game computerMoveFor: Tictactoe computerMark against: Tictactoe humanMark.
	game move: index mark: Tictactoe computerMark.
	self update.
!
newGame
	"Start a new game."

	game reset.
	self update.
!

"Accessing (used by tests)"

game
	^ game.
!
boardTable
	^ boardTable.
!
cellElements
	^ cellElements.
!
statusSpan
	^ statusSpan.
!
newGameButton
	^ newGameButton.
!
