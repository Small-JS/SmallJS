CLASS TestHtmlImageElement EXTENDS Test MODULE TestDom CLASSVARS '' VARS ''

test
	| document image |

	document := Document default.
	image := document getElementById: 'resultImage'.
	self assert: [ image class = HtmlImageElement ].

	image complete
		ifTrue: [ self onComplete: image ]
		ifFalse: [ image addEventListener: 'load' then: [ self onComplete: image ] ].
!
onComplete: image
	| exptectedNaturalSize |

	self assert: [ image alt = 'SmallJS logo' ].
	image alt: 'New alt text'.
	self assert: [ image alt = 'New alt text' ].
	image alt: 'SmallJS logo'.

	self assert: [ image currentSrc includes: 'SmallJS' ].

	self assert: [ image crossOrigin = nil ].
	image crossOrigin: 'anonymous'.
	self assert: [ image crossOrigin = 'anonymous' ].
	image crossOrigin: nil.


	self assert: [ image decoding = 'auto' ].
	image decoding: 'sync'.
	self assert: [ image decoding = 'sync' ].
	image decoding: 'auto'.

	self assert: [ image size = ( 50 @ 50 ) ].
	image size: ( 100 @ 75 ).
	self assert: [ image size = ( 100 @ 75 ) ].
	image size: ( 50 @ 50 ).

	"Chromium browsers return zero natural witdth and height for some reason."
	exptectedNaturalSize := Window isChromium ifTrue: [ ( 0 @ 0 ) ] ifFalse: [ ( 800 @ 800 ) ].
	self assert: [ image naturalSize = exptectedNaturalSize ].

	self assert: [ image isMap not ].
	image isMap: true.
	self assert: [ image isMap ].
	image isMap: false.

	"Note: Chromium browsers set this property to 'auto' by default."
	self assert: [ image loading = 'eager' ].
	image loading: 'lazy'.
	self assert: [ image loading = 'lazy' ].
	image loading: 'eager'.

	self assert: [ image sizes = '' ].

	self assert: [ image src endsWith: 'SmallJS.png' ].
	image src: 'Missing.jpg'.
	self assert: [ image src endsWith: 'Missing.jpg' ].
	image src: 'SmallJS.png'.

	self assert: [ image srcSet = 'SmallJS2.png 2x' ].
	image srcSet: 'SmallJS2.png 4x'.
	self assert: [ image srcSet = 'SmallJS2.png 4x' ].
	image srcSet: 'SmallJS2.png 2x'.

	self assert: [ image useMap = '' ].

	image decodeThen: [ self assert: [ true ] ]
		catch: [ :error | self error: 'Image decode failed' ].

!
