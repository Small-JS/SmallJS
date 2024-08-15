CLASS TestCanvasRenderingContext2d EXTENDS Test MODULE TestBrowser CLASSVARS '' VARS ''

"Also tests: CanvasGradient"

testProperties
	| canvas context  |

	canvas := Document default createElement: 'canvas'.
	self assert: [ canvas class = HtmlCanvasElement ].

	context := canvas getContext2d.
	self assert: [ context class = CanvasRenderingContext2d ].

	self assert: [ context canvas = canvas ].

	self assert: [ #( 'ltr' 'inherit' ) includes: context direction  ].
	context direction: 'rtl'.
	self assert: [ context direction = 'rtl' ].

	self assert: [ context fillStyle = '#000000' ].
	context fillStyle: '#808182'.
	self assert: [ context fillStyle = '#808182' ].

	self assert: [ context font = '10px sans-serif' ].
	context font: '48px serif'.
	self assert: [ context font = '48px serif' ].

	self assert: [ context fontKerning = 'auto' ].
	context fontKerning: 'normal'.
	self assert: [ context fontKerning = 'normal' ].

	self assert: [ context fontStretch = 'normal' ].
	context fontStretch: 'expanded'.
	self assert: [ context fontStretch = 'expanded' ].

	self assert: [ context globalAlpha = 1.0 ].
	context globalAlpha: 0.5.
	self assert: [ context globalAlpha = 0.5 ].

	self assert: [ context globalCompositeOperation = 'source-over' ].
	context globalCompositeOperation: 'source-in'.
	self assert: [ context globalCompositeOperation = 'source-in' ].

	self assert: [ context imageSmoothingEnabled ].
	context imageSmoothingEnabled: false.
	self assert: [ context imageSmoothingEnabled not ].

	self assert: [ context letterSpacing = '0px' ].
	context letterSpacing: '2px'.
	self assert: [ context letterSpacing = '2px' ].

	self assert: [ context lineCap = 'butt' ].
	context lineCap: 'round'.
	self assert: [ context lineCap = 'round' ].

	self assert: [ context lineDashOffset = 0 ].
	context lineDashOffset: 4.
	self assert: [ context lineDashOffset = 4 ].

	self assert: [ context lineJoin = 'miter' ].
	context lineJoin: 'round'.
	self assert: [ context lineJoin = 'round' ].

	self assert: [ context lineWidth = 1 ].
	context lineWidth: 2.
	self assert: [ context lineWidth = 2 ].

	self assert: [ context shadowBlur = 0 ].
	context shadowBlur: 15.
	self assert: [ context shadowBlur = 15 ].

	self assert: [ context shadowColor = 'rgba(0, 0, 0, 0)' ].
	context shadowColor: 'red'.
	self assert: [ context shadowColor = '#ff0000' ].

	self assert: [ context shadowOffset = ( 0 @ 0 ) ].
	context shadowOffset: ( 1 @ 2 ).
	self assert: [ context shadowOffset = ( 1 @ 2 ) ].

	self assert: [ context strokeStyle = '#000000' ].
	context strokeStyle: '#123456'.
	self assert: [ context strokeStyle = '#123456' ].

	self assert: [ context textAlign = 'start' ].
	context textAlign: 'center'.
	self assert: [ context textAlign = 'center' ].

	self assert: [ context textBaseline = 'alphabetic' ].
	context textBaseline: 'top'.
	self assert: [ context textBaseline = 'top' ].

	self assert: [ context textRendering = 'auto' ].
	context textRendering: 'optimizeSpeed'.
	self assert: [ context textRendering = 'optimizeSpeed' ].

	self assert: [ context wordSpacing = '0px' ].
	context wordSpacing: '3px'.
	self assert: [ context wordSpacing = '3px' ].
!
testMethods
	"Note:
	 Only methods that return a result are tested here.
	 Methods that draw on the canvas are tested visually in CanvasComponent."

	| canvas context imageData pattern gradient attributes lineDash matrix textMetrics contextAttributes |

	canvas := Document default createElement: 'canvas'.
	self assert: [ canvas class = HtmlCanvasElement ].

	context := canvas getContext2d.
	self assert: [ context class = CanvasRenderingContext2d ].

	imageData := context getImageData: ( Rect origin: ( 20 @ 10 ) extent: ( 40 @ 30 ) ).
	self assert: [ imageData class = ImageData ].

	imageData := context createImageData: ( 20 @ 10 ).
	self assert: [ imageData class = ImageData ].

	pattern := context createPattern: canvas repetition: 'repeat'.
	self assert: [ pattern class = CanvasPattern ].

	gradient := context createLinearGradientFrom: ( 10 @ 20 ) to: ( 30 @ 40 ).
	self assert: [ gradient class = CanvasGradient ].
	gradient addColorStop: 0.5 color: 'green'.

	gradient := context createRadialGradientFrom: ( 10 @ 20 ) radius: 5 to: ( 30 @ 40 ) radius: 15.
	self assert: [ gradient class = CanvasGradient ].

	attributes := context getContextAttributes.
	self assert: [ attributes class = ContextAttributes ].

	attributes := context getContextAttributes.
	self assert: [ attributes class = ContextAttributes ].

	lineDash := context getLineDash.
	self assert: [ lineDash = #( ) ].

	matrix := context getTransform.
	self assert: [ matrix isIdentity ].

	self assert: [ context isContextLost not ].
	self assert: [ ( context isPointInPath: ( 10 @ 0 ) ) not ].
	self assert: [ ( context isPointInStroke: ( 10 @ 0 ) ) not ].

	textMetrics := context measureText: 'Hello world'.
	self assert: [ textMetrics class = TextMetrics ].

	contextAttributes := context getContextAttributes.
	self assert: [ contextAttributes class = ContextAttributes ].
!
