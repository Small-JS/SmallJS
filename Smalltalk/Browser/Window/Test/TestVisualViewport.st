CLASS TestVisualViewport EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

METHODS

test
	| visualViewport |
	visualViewport := Window default visualViewport.
	self assert: [ visualViewport class = VisualViewport ].

	self assert: [ visualViewport offset >= ( 0 @ 0 ) ].
	self assert: [ visualViewport pageOffset >= ( 0 @ 0 ) ].
	self assert: [ visualViewport size >= ( 0 @ 0 ) ].
	self assert: [ visualViewport scale > 0 ].
!
testProperties
	"Test with a mock JS object, because the real values depend on scrolling and zooming."
	| visualViewport |
	visualViewport := VisualViewport fromJs: INLINE '( {
		offsetLeft: 1.5, offsetTop: 2.5, pageLeft: 3.5, pageTop: 4.5,
		width: 100.5, height: 50.25, scale: 2 } )'.
	self assert: [ visualViewport offset = ( 1.5 @ 2.5 ) ].
	self assert: [ visualViewport pageOffset = ( 3.5 @ 4.5 ) ].
	self assert: [ visualViewport size = ( 100.5 @ 50.25 ) ].
	self assert: [ visualViewport scale = 2 ].
!
