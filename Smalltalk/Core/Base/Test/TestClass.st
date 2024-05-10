CLASS TestClass EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	self assert: [ Class name = 'Class' ].
	self assert: [ Class toString = 'class Class' ].
	self assert: [ Class superclass = Object ].

	self assert: [ Class name = 'Class' ].

	self assert: [ Class methodNames includes: 'name' ].
	self assert: [ ( Class methodNames includes: 'xname' ) not ].
	self assert: [ Class classMethodNames includes: 'classes' ].
	self assert: [ Boolean methodNames includes: '|' ].
	self assert: [ Boolean methodNames includes: 'not' ].

	self assert: [ Boolean canUnderstand: 'not' ].
	self assert: [ Boolean canUnderstand: 'isNil' ].
	self assert: [ ( Boolean canUnderstand: 'XisNil' ) not ].
!
testCompiler
	| a_b |
	a_b := 3.
	self assert: [ a_b = 3 ].
!
_test_reservered_words
	| delete |
	delete := true.
	self assert: [ delete ].
!
