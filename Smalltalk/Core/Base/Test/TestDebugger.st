CLASS TestDebugger EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''
	"This class contains some code set breakpoints in and step through,
	 to see if the debugger is working as desired."
test1
	^ 1 + 2.
!
test2
	| a b |

	a := 1.
	b := a + 2.

	"self log: 'Debugger finished'."
!
