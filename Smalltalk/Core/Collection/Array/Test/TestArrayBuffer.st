CLASS TestArrayBuffer EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

test
	| arrayBuffer |
	arrayBuffer := ArrayBuffer new: 8.

	self assert: [ arrayBuffer class = ArrayBuffer ].
	self assert: [ arrayBuffer byteLength = 8 ].
!
