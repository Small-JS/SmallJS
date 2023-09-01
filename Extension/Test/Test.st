CLASS MyTest EXTENDS JsObject MODULE Extension CLASSVARS 'classVar' VARS 'var1 var2'
	"This is a comment."

CLASSMETHODS

myClassMethod
	^ #( 1 3.14 'aaa' true false nil classVar $c ).
!

METHODS

method1
	var1 isNil ifTrue: [ ^ false ].
	^ String new.
!
++
	"Binary method."
	^ var1 + var2.
!
method2Arg1: aVar1 arg2: aVar2
	INLINE 'this.js = null'.
	var1 := aVar1.
	var2 := aVar2.
!
