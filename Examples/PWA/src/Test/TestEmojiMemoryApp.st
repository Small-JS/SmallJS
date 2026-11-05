CLASS TestEmojiMemoryApp EXTENDS BrowserApp MODULE TestEmojiMemoryApp CLASSVARS ''
	VARS 'emojiMemoryApp'

"Test EmojiMemoryApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	"Run sync and async tests of all imported Test* classes and log results.
	Then run the GUI tests and close the window if all tests succeed."
	await TestDeck all.
	await self testGui.
	await self testClickOutsideCells.
	await self testMatch.
	await self testRestartAfterTurn.
	await self testRestartDuringRevert.
	self stop.
!
async testGui
	"Check game defaults, start new game, check that top-left card cell is unturned,
	click on that card, check if it is turned."

	| rows cells cell |

	"Create game and check defaults."
	emojiMemoryApp := await EmojiMemoryApp new start.
	await Timer timeout: 1000.

	self assert: [ emojiMemoryApp columnsInput value toInteger = 4 ].
	self assert: [ emojiMemoryApp rowsInput value toInteger = 3 ].

	"Start game and check top-left card."

	await self startGame.

	rows := emojiMemoryApp deckTable rows.
	self assert: [ rows length = 3 ].
	cells := rows first cells.
	self assert: [ cells length = 4 ].
	cell := cells first.
	self assert: [ cell class = HtmlTableCellElement ].
	self assert: [ cell textContent = '🂠' ].

	self assert: [ emojiMemoryApp turnsInput value toInteger = 0 ].
	self assert: [ emojiMemoryApp leftInput value toInteger = 12 ].

	"Click on top-left card and check updates."

	await self clickCardAt: 0.
	self assert: [ cell textContent = emojiMemoryApp deck cards first face ].

	self assert: [ emojiMemoryApp turnsInput value toInteger = 1 ].
	self assert: [ emojiMemoryApp leftInput value toInteger = 11 ].
!
async testClickOutsideCells
	"Clicking on the table itself, outside of the cells, must not turn a card."

	await self startGame.
	emojiMemoryApp deckTable click.
	await Timer timeout: 100.
	self assert: [ emojiMemoryApp turnsInput value toInteger = 0 ].
	self assert: [ emojiMemoryApp leftInput value toInteger = 12 ].
!
async testMatch
	"Click on a matching pair of cards. Both must stay turned."

	await self startGame.
	await self clickCardAt: 0.
	await self clickCardAt: self matchIndex.
	self assert: [ ( emojiMemoryApp deck cards at: 0 ) turned ].
	self assert: [ ( emojiMemoryApp deck cards at: self matchIndex ) turned ].
	self assert: [ emojiMemoryApp turnsInput value toInteger = 2 ].
	self assert: [ emojiMemoryApp leftInput value toInteger = 10 ].
!
async testRestartAfterTurn
	"Turn one card, then start a new game.
	The turned card of the previous game must not be matched in the new game."

	await self startGame.
	await self clickCardAt: 0.
	await self startGame.
	await self clickCardAt: 0.
	await self clickCardAt: self matchIndex.
	self assert: [ emojiMemoryApp turnsInput value toInteger = 2 ].
	self assert: [ emojiMemoryApp leftInput value toInteger = 10 ].
!
async testRestartDuringRevert
	"Turn two different cards, then start a new game during the revert pause.
	The revert of the previous game must not affect the new game."

	await self startGame.
	await self clickCardAt: 0.
	await self clickCardAt: self mismatchIndex.
	await self startGame.
	await Timer timeout: 2000.
	self assert: [ emojiMemoryApp turnsInput value toInteger = 0 ].
	self assert: [ emojiMemoryApp leftInput value toInteger = 12 ].
!

"Helpers"

async startGame
	emojiMemoryApp startButton click.
	await Timer timeout: 500.
!
async clickCardAt: index
	"Click on the cell of the card at index in the deck cards."
	| columns row |

	columns := emojiMemoryApp deck size x.
	row := emojiMemoryApp deckTable rows at: index // columns.
	( row cells at: index \\ columns ) click.
	await Timer timeout: 500.
!
matchIndex
	"Index of the card that matches the first card."
	| face |

	face := emojiMemoryApp deck cards first face.
	^ emojiMemoryApp deck cards findLastIndex: [ :card | card face = face ].
!
mismatchIndex
	"Index of a card that does not match the first card."
	| face |

	face := emojiMemoryApp deck cards first face.
	^ emojiMemoryApp deck cards findIndex: [ :card | card face ~= face ].
!
