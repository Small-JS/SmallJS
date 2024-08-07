CLASS TestScreen EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| screen |
	screen := Window default screen.

	self assert: [ screen class = Screen ].

	self assert: [ screen availTop >= 0 ].
	self assert: [ screen availLeft >= 0 ].

	self assert: [ screen height > 0 ].
	self assert: [ screen width > 0 ].

	self assert: [ screen availHeight > 0 ].
	self assert: [ screen availWidth > 0 ].

	self assert: [ screen colorDepth > 0 ].
	self assert: [ screen pixelDepth > 0 ].

	self assert: [ screen orientation class = ScreenOrientation ].
!
