CLASS TestContextAttributes EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| context contextAttributes |
	context := ( Document default createElement: 'canvas' ) getContext2d.
	contextAttributes := context getContextAttributes.
	self assert: [ contextAttributes class = ContextAttributes ].

	self assert: [ contextAttributes alpha ].
	self assert: [ contextAttributes colorSpace = 'srgb' ].
	self assert: [ contextAttributes desynchronized not ].
	self assert: [ contextAttributes willReadFrequently not ].
!
