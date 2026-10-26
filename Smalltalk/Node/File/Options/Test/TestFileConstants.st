CLASS TestFileConstants EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

testAccess
	"Values are the same on all platforms."
	self assert: [ FileConstants fileOk = 0 ].
	self assert: [ FileConstants readOk = 4 ].
	self assert: [ FileConstants writeOk = 2 ].
	self assert: [ FileConstants executeOk = 1 ].
!
testCopy
	self assert: [ FileConstants copyExclusive >= 0 ].
	self assert: [ FileConstants copyClone >= 0 ].
	self assert: [ FileConstants copyCloneForce >= 0 ].
!
