CLASS TestLocation EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

testProperties
	| location |
	location := Document default location.

	self assert: [ location class = Location ].

	self assert: [ location href includes: location origin ].
	self assert: [ location href includes: location protocol ].
	self assert: [ location origin includes: location host ].
	self assert: [ location host includes: location hostname ].

	self assert: [ location pathname startsWith: '/' ].
	self assert: [ location search = '' or: [ location search startsWith: '?' ] ].
!
testMethods
	| location |
	location := Document default location.

	"These methods are too disruptive to be tested here:
		assign: , replace: , reload ."

	self assert: [ location href = location toString ].

!
