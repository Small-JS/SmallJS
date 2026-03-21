CLASS TestEmojiMemoryApp EXTENDS BrowserApp MODULE TestEmojiMemoryApp CLASSVARS ''
	VARS 'emojiMemoryApp'

"Test EmojiMemoryApp units and GUI.
 This class is not a subclass of Test so is not called automatically with Test all."

async start
	"Run sync and async tests of all imported Test* classes and log results."
	await TestDeck all.
	await self testGui.
	await self stop.
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

	emojiMemoryApp startButton click.
	await Timer timeout: 1000.

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

	cell click.
	await Timer timeout: 1000.
	self assert: [ cell textContent = emojiMemoryApp deck cards first face ].

	self assert: [ emojiMemoryApp turnsInput value toInteger = 1 ].
	self assert: [ emojiMemoryApp leftInput value toInteger = 11 ].
!
async end
	await Timer timeout: 1000.
	emojiMemoryApp stop.
!
