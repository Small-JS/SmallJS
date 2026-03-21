CLASS EmojiMemoryApp EXTENDS BrowserApp MODULE EmojiMemoryApp CLASSVARS ''
	VARS 'size deck lastCard lastCell revertPending turns left
		startButton columnsInput rowsInput
		deckRow deckTable winTemplate
		turnsRow turnsInput leftInput'

async start
	self bindElements.
	size := 4 @ 3.
	self updateSize.
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	startButton := Document getElementById: 'startButton' class: HtmlButtonElement.
	startButton onClick: [ self startGame ].

	columnsInput := Document getElementById: 'columnsInput' class: HtmlInputElement.
	rowsInput := Document getElementById: 'rowsInput' class: HtmlInputElement.

	deckRow := Document getElementById: 'deckRow' class: HtmlTableRowElement.
	deckTable := Document getElementById: 'deckTable' class: HtmlTableElement.
	deckTable onClick: [ :event | self onDeckTableClicked: event ].
	winTemplate := Document getElementById: 'winTemplate' class: HtmlTemplateElement.

	turnsRow := Document getElementById: 'turnsRow' class: HtmlTableRowElement.
	turnsInput := Document getElementById: 'turnsInput' class: HtmlInputElement.
	leftInput := Document getElementById: 'leftInput' class: HtmlInputElement.
!
updateSize
	columnsInput value: size x toString.
	rowsInput value: size y toString.
!
async startGame
	size x: ( ( columnsInput value toInteger max: 2 ) min: 9 ).
	size y: ( ( rowsInput value toInteger max: 2 ) min: 9 ).
	self updateSize.

	deck := await Deck new initialize: size.
	self createDeckTable.

	turns := 0.
	self updateTurnsInput.
	left := deck length.
	self updateLeftInput.

	revertPending := false.
!
createDeckTable
	| row cell card |

	deckTable removeChildren.
	0 to: deck size y - 1 do: [ :y  |
		row := deckTable insertRow: -1.
		0 to: deck size x - 1 do: [ :x |
			card := deck cardAt: x @ y.
			row insertCell textContent: card display ] ].
!
async onDeckTableClicked: event
	"Turn clicked card if it was not done already."
	| cell point card |

	revertPending ifTrue: [ ^ nil ].
	left = 0 ifTrue: [ ^ nil ].

	"Get table cell and point clicked on."
	cell := HtmlElement fromJsSubElement: event target js.
	cell class ~= HtmlTableCellElement ifTrue: [
		cell := cell parentElement ].
	point := Point x: cell cellIndex y: cell parentElement rowIndex.

	"Turn card if unturned and display face."
	card := deck cardAt: point.
	card turned ifTrue: [ ^ nil ].
	card turned: true.
	cell replaceChildren: card display.

	turns := turns + 1.
	self updateTurnsInput.

	left := left - 1.
	self updateLeftInput.
	left = 0 ifTrue: [ ^ self win ].

	"If turned does not match last card,
	unturn them both after a small pause."

	"No last card"
	lastCard ifNil: [
		lastCard := card. lastCell := cell ^ nil ].

	"Matching last card"
	card face = lastCard face ifTrue: [
		lastCard := nil. lastCell := nil. ^ nil ].

	"Different last card, unturn both after pause."
	revertPending := true.
	await Timer timeout: 2000.
	revertPending := false.
	card turned: false.
	cell replaceChildren: card display.
	lastCard turned: false.
	lastCell replaceChildren: lastCard display.
	lastCard := nil.
	left := left + 2.
	self updateLeftInput.
!
updateTurnsInput
	turnsInput value: turns toString.
!
updateLeftInput
	leftInput value: left toString.
!
win
	deckTable replaceChildren: (
		winTemplate content cloneNode: true ).
!

"Accessing GUI - Used by tests"

startButton
	^ startButton.
!
columnsInput
	^ columnsInput.
!
rowsInput
	^ rowsInput.
!
deckTable
	^ deckTable.
!
turnsInput
	^ turnsInput.
!
leftInput
	^ leftInput.
!

"Accessing model - Used by tests"

size
	^ size.
!
deck
	^ deck.
!
turns
	^ turns.
!
left
	^ left.
!
