"This file is used to visually check syntax coloring of SmallJS *.st files.
 It is not meant to be compiled or run."

CLASS MyTest EXTENDS JsObject MODULE ExtensionTest CLASSVARS 'classVar' VARS 'var1 var2'
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
++ var
	"Binary method."
	| locVar |
	locVar := var + var.
	^ self + locVar.
!
method2Arg1: aVar1 arg2: aVar2
	INLINE 'this.js = null'.
	var1 := aVar1.
	var2 := aVar2.
!
