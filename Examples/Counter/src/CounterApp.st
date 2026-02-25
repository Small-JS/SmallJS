CLASS CounterApp EXTENDS BrowserApp MODULE CounterApp CLASSVARS ''
	VARS 'counter counterSpan incrementButton resetButton'

start
	counter := Counter new.
	self bindElements.
	self update.
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	counterSpan := Document getElementById: 'counterSpan' class: HtmlSpanElement.

	incrementButton := Document getElementById: 'incrementButton' class: HtmlButtonElement.
	incrementButton onClick: [ self increment ].

	resetButton := Document getElementById: 'resetButton' class: HtmlButtonElement.
	resetButton onClick: [ self reset ].
!
update
	"Update counter in HTML page."

	counterSpan textContent: counter value toString.
!
increment
	"Increase the counter and update the view."

	counter increment.
	self update.
!
reset
	"Increase the counter and update the view."

	counter reset.
	self update.
!

"Accessing (used by tests)"

counterSpan
	^ counterSpan.
!
incrementButton
	^ incrementButton.
!
resetButton
	^ resetButton.
!
