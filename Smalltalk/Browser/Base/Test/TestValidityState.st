CLASS TestValidityState EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| validityState |
	validityState := ( Document new createElement: 'fieldSet' ) validity.
	self assert: [ validityState class = ValidityState ].

	self assert: [ validityState badInput not ].
	self assert: [ validityState customError not ].
	self assert: [ validityState patternMismatch not ].
	self assert: [ validityState rangeOverflow not ].
	self assert: [ validityState rangeUnderflow not ].
	self assert: [ validityState stepMismatch not ].
	self assert: [ validityState tooLong not ].
	self assert: [ validityState tooShort not ].
	self assert: [ validityState typeMismatch not ].
	self assert: [ validityState valueMissing not ].

	self assert: [ validityState valid ].
!
