CLASS CounterApp EXTENDS BrowserApp MODULE CounterApp CLASSVARS ''
	VARS 'counter'

start
	counter := Counter new.
!
increment
	"Increment the counter.
	Updating the view is handled by React."
	counter increment.
!
reset
	"Reset the counter.
	Updating the view is handled by React."
	counter reset.
!

"Accessing"

counter
	^ counter.
!
