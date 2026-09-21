CLASS TestTictactoeApp EXTENDS Object MODULE TestTictactoeApp CLASSVARS '' VARS 'tictactoeApp'

"Test TictactoeApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	tictactoeApp := TictactoeApp new start.

	"Run sync and async tests of all imported Test* classes and log results."
	await TestTictactoe all.
	await self testGui.
!
async testGui
	await self testCellClick.
	await self testOccupiedCellClick.
	await self testNewGame.

	await self stop.
!
async testCellClick
	"Click an empty cell and check the human mark is shown,
	 then that the computer responds with its own mark."

	| cell occupiedCount |

	cell := tictactoeApp cellElements at: 0.
	self assert: [ cell textContent = '' ].

	cell click.
	self assert: [ cell textContent = Tictactoe humanMark ].
	self assert: [ tictactoeApp statusSpan textContent = 'Computer is thinking...' ].

	await Timer timeout: 1000.

	occupiedCount := ( tictactoeApp cellElements filter: [ :element | element textContent ~= '' ] ) length.
	self assert: [ occupiedCount = 2 ].
	self assert: [ tictactoeApp statusSpan textContent = 'Your turn' ].
!
async testOccupiedCellClick
	"Clicking an already occupied cell must not change its mark."

	| cell mark |

	cell := tictactoeApp cellElements at: 0.
	mark := cell textContent.

	cell click.
	await Timer timeout: 200.
	self assert: [ cell textContent = mark ].
!
async testNewGame
	"Starting a new game clears the board and resets the status."

	tictactoeApp newGameButton click.
	await Timer timeout: 200.

	self assert: [ tictactoeApp cellElements every: [ :element | element textContent = '' ] ].
	self assert: [ tictactoeApp statusSpan textContent = 'Your turn' ].
!
async stop
	await Timer timeout: 1000 then: [
		tictactoeApp stop ].
!
