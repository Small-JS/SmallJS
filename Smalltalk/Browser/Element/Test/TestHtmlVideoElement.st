CLASS TestHtmlVideoElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| video |
	video := Document default createElement: 'video'.
	self assert: [ video class = HtmlVideoElement ].
	self assert: [ video isKindOf: HtmlMediaElement ].

	self assert: [ video size = ( 0 @ 0 ) ].
	video size: ( 320 @ 240 ).
	self assert: [ video size = ( 320 @ 240 ) ].
	self assert: [ ( video getAttribute: 'width' ) = '320' ].

	"No video loaded."
	self assert: [ video videoSize = ( 0 @ 0 ) ].

	self assert: [ video poster = '' ].
	video poster: 'Missing.png'.
	self assert: [ video poster endsWith: 'Missing.png' ].

	self assert: [ video playsInline not ].
	video playsInline: true.
	self assert: [ video playsInline ].
!
