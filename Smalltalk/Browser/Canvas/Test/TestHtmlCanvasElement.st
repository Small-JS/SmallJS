CLASS TestHtmlCanvasElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| canvas context url offscreenCanvas |
	canvas := Document default createElement: 'canvas'.
	self assert: [ canvas class = HtmlCanvasElement ].

	self assert: [ canvas width = 300 ].
	canvas width: 200.
	self assert: [ canvas width = 200 ].

	self assert: [ canvas height = 150 ].
	canvas height: 100.
	self assert: [ canvas height = 100 ].

	self assert: [ canvas size = ( 200 @ 100 ) ].
	canvas size: ( 100 @ 50 ).
	self assert: [ canvas size = ( 100 @ 50 ) ].

	context := canvas getContext: '2d'.
	self assert: [ context class = CanvasRenderingContext2d ].

	canvas toBlobType: 'image/png' quality: 1.0
		then: [ :blob | self onToBlob: blob ].

	url := canvas toDataUrlType: 'image/png' quality: 1.0.
	self assert: [ url startsWith: 'data:image/png;' ].

	"Must create fresh canvas to test method transferControlToOffscreen."
	canvas := Document default createElement: 'canvas'.
	self assert: [ canvas class = HtmlCanvasElement ].
	offscreenCanvas := canvas transferControlToOffscreen.
	self assert: [ offscreenCanvas class = OffscreenCanvas ].
!
onToBlob: blob
	"Note: Different browsers encode differently."
	self assert: [ blob size > 100 ].
	self assert: [ blob type = 'image/png' ].
!
