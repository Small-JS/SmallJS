CLASS Counter EXTENDS Object MODULE CounterApp CLASSVARS '' VARS 'value'

constructor
	value := 0.
!
value
	^ value.
!
increment
	value := value + 1.
!
reset
	value := 0.
!
