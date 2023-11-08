CLASS CounterApp EXTENDS Object MODULE Counter CLASSVARS ''
	VARS 'counter counterLabel increaseButton resetButton'

start
	self test.
	counter := Counter new.
	self bindElements.
	self update.
!
test
	TestCounter all.
!
bindElements
	"Bind HTML elements to vars, set defaults, set event listeners."

	counterLabel := Document default getElementById: 'counterLabel'.
	self assert: [ counterLabel class = HtmlLabelElement ].

	increaseButton := Document default getElementById: 'incrementButton'.
	self assert: [ increaseButton class = HtmlButtonElement ].
	increaseButton addEventListener: 'click' then: [ self increase ].

	resetButton := Document default getElementById: 'resetButton'.
	self assert: [ resetButton class = HtmlButtonElement ].
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
