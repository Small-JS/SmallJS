CLASS CounterApp EXTENDS Object MODULE Counter CLASSVARS ''
	VARS 'counter counterLabel increaseButton resetButton'

start
	counter := Counter new.
	self bindElements.
	self update.
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	counterLabel := Document default getElementById: 'counterLabel'.

	increaseButton := Document default getElementById: 'incrementButton'.
	increaseButton addEventListener: 'click' then: [ self increase ].

	resetButton := Document default getElementById: 'resetButton'.
	resetButton addEventListener: 'click' then: [ self reset ].
!
update
	"Update counter in HTML page."

	counterLabel textContent: counter value toString.
!
increase
	"Increase the counter and update the view."

	counter increase.
	self update.
!
reset
	"Increase the counter and update the view."

	counter reset.
	self update.
!
