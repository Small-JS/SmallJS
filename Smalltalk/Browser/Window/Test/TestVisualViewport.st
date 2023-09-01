CLASS TestVisualViewport EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

METHODS

browserOnly
	^ true.
!
test
	| visualViewport |
	visualViewport := Window default visualViewport.
	self assert: [ visualViewport class = VisualViewport ].

	self assert: [ visualViewport offset >= ( 0 @ 0 ) ].
	self assert: [ visualViewport pageOffset >= ( 0 @ 0 ) ].
	self assert: [ visualViewport size >= ( 0 @ 0 ) ].
	self assert: [ visualViewport scale > 0 ].
!
