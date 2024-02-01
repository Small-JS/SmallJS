CLASS CounterApp EXTENDS BrowserApp MODULE CounterApp CLASSVARS ''
	VARS 'counter counterLabel incrementButton resetButton'

start
	counter := Counter new.
	self bindElements.
	self update.

	self testMode ifTrue: [
		TestCounterApp new test: self ].
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	counterLabel := Document getElementById: 'counterLabel' class: HtmlLabelElement.

	incrementButton := Document getElementById: 'incrementButton' class: HtmlButtonElement.
	incrementButton onClick: [ self increment ].

	resetButton := Document getElementById: 'resetButton' class: HtmlButtonElement.
	resetButton onClick: [ self reset ].
!
update
	"Update counter in HTML page."

	counterLabel textContent: counter value toString.
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

counterLabel
	^ counterLabel.
!
incrementButton
	^ incrementButton.
!
resetButton
	^ resetButton.
!
