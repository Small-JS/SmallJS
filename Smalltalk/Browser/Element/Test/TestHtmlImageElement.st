CLASS TestHtmlImageElement EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

test
	| image exptectedNaturalSize |
	image := Document default createElement: 'img'.
	self assert: [ image class = HtmlImageElement ].

	self assert: [ image alt = '' ].
	image alt: 'New alt text'.
	self assert: [ image alt = 'New alt text' ].

	self assert: [ image currentSrc = '' ].

	self assert: [ image crossOrigin isNil ].
	image crossOrigin: 'anonymous'.
	self assert: [ image crossOrigin = 'anonymous' ].

	self assert: [ image decoding = 'auto' ].
	image decoding: 'sync'.
	self assert: [ image decoding = 'sync' ].

	self assert: [ image size = ( 0 @ 0 ) ].
	image size: ( 100 @ 75 ).
	self assert: [ image size = ( 100 @ 75 ) ].

	self assert: [ image naturalSize = ( 0 @ 0 ) ].

	self assert: [ image isMap not ].
	image isMap: true.
	self assert: [ image isMap ].

	"Firefox defaults to 'eager'"
	self assert: [ #( 'auto' 'eager' ) includes: image loading ].
	image loading: 'lazy'.
	self assert: [ image loading = 'lazy' ].

	self assert: [ image sizes = '' ].

	self assert: [ image src = '' ].
	image src: 'Missing.jpg'.
	self assert: [ image src endsWith: 'Missing.jpg' ].

	self assert: [ image srcSet = '' ].
	image srcSet: 'SmallJS2.png 4x'.
	self assert: [ image srcSet = 'SmallJS2.png 4x' ].

	self assert: [ image useMap = '' ].
!
