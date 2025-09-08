CLASS TestFileConstants EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

testAccess
	self assert: [ FileConstants fileOk >= 0 ].
	self assert: [ FileConstants readOk >= 0 ].
	self assert: [ FileConstants writeOk >= 0 ].
	self assert: [ FileConstants executeOk >= 0 ].
!
testCopy
	self assert: [ FileConstants copyExclusive >= 0 ].
	self assert: [ FileConstants copyLink >= 0 ].
	self assert: [ FileConstants copyLinkForce >= 0 ].
!
