CLASS Counter EXTENDS Object MODULE Counter CLASSVARS '' VARS 'value'

constructor
	value := 0.
!
value
	^ value.
!
increase
	value := value + 1.
!
reset
	value := 0.
!
