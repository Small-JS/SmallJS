CLASS TestCompiler EXTENDS Test MODULE TestCore CLASSVARS 'c1'
	VARS 'v1
	v2'

	"This class tests some compiler parsing features"

CLASSMETHODS

testClass
	self assert: [ c1 isNil ].
!

METHODS

test
	self assert: [ c1 = v1 ].
	self assert: [ v1 = v2 ].
	self assert: [ 1+2=3 ].
	self assert: [ self A: 1 b: 2 ].
!
A:a b:b
	^ true.
!
testClassExtension
	"These will succeed if ObjectExtension.st was successfully compiled."
	self assert: [ Object extensionClassMethod = 'extensionClassMethod' ].
	self assert: [ Object new extensionMethod = 'extensionMethod' ].
!
testBreakpoints
	"This method can be used to test different types of SmallJS code.
	To test, set breakpoints on all code lines below.

	Breakpoints should be possible on:
	- Lines with a single constant (e.g: a Class name to force import)
	- Assignments.
	- Unary, binary and keyword method calls.
	- Within blocks!"

	| string num block |

	42.
	String.
	string := 'aaa'.
	string := 'ABC' toLowerCase.
	string := 'ab', 'cd'.
	string := 'def' substring: 1.

	true ifTrue: [
		self assert: [ string = 'ef'] ].

	block :=
		[ self assert: [ string = 'ef'] ].
	block value.
!
