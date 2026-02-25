CLASS CanvasComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'canvas'

"Initialization"

htmlPath
	^ 'Components/CanvasComponent.html'.
!
async start
	self bindElements.
	self draw.
	await self drawImage.
	self drawPaths.
!
bindElements
	canvas := Document getElementById: 'canvas' class: HtmlCanvasElement.
!

"Accessing"

canvas
	^ canvas.
!

"Drawing"

draw
	| context gradient imageData colorBlue imageBitmap path matrix |
	context := canvas getContext2d.
	context reset.
	context fillStyle: 'white'.
	context fillRect: ( Rect origin: 0 @ 0 extent: canvas size ).

	context strokeStyle: 'blue'.
	context fillStyle: 'blue'.
	context lineWidth: 2.

	"Bezier curve, top of head."
	context beginPath.
	context moveTo: 20 @ 20.
	context bezierCurveTo: 30 @ 10 to: 50 @ 10 end: 60 @ 20.
	context stroke.

	"Quarter circle, lower right chin of face"
	context beginPath.
	context arc: 40 @ 60 radius: 20 startAngle: 0 endAngle: Float pi / 2 counterclockwise: false.
	context stroke.

	"Quarter circle, lower left chin of face"
	context arcTo: 20 @ 80 to: 20 @ 60 radius: 20.
	context stroke.

	"Radial gradient, left eye."
	gradient := context createRadialGradientFrom: 30 @ 30 radius: 5 to: 30 @ 30 radius: 10.
	gradient addColorStop: 0 color: 'blue'.
	gradient addColorStop: 1 color: 'orange'.
	context fillStyle: gradient.
	context fillRect: ( Rect origin: 20 @ 20 extent: 20 @ 20 ).

	"Copy image of previous blue square with orange circle to right eye."
	imageData := context getImageData: ( Rect origin: 20 @ 20 extent: 20 @ 20 ).
	context putImageData: imageData dest: 40 @ 20.

	"Copy top-right quadrant of previous image to lower-left."
	context putImageData: imageData dest: -10 @ 80 sourceRect: ( Rect origin: 10 @ 0 extent: 10 @ 10 ).

	"Triangle top-middle-right, nose of face."
	context beginPath.
	context moveTo: 40 @ 45.
	context lineTo: 50 @ 55.
	context lineTo: 30 @ 55.
	context closePath.
	context stroke.

	"Linear gradient rectangle blue to orange, mouth of face."
	gradient := context createLinearGradientFrom: 30 @ 60 to: 50 @ 70.
	gradient addColorStop: 0 color: 'blue'.
	gradient addColorStop: 1 color: 'orange'.
	context fillStyle: gradient.
	context fillRect: ( Rect origin: 30 @ 60 extent: 20 @ 10 ).

	"ImageData: Create small blue rectangle top-middle"
	imageData := context createImageData: 20 @ 10.
	colorBlue := #( 0 0 255 255 ).
	0 to: imageData width - 1 do: [ :x |
		0 to: imageData height - 1 do: [ :y |
			imageData atPixel: x @ y put: colorBlue ] ].
	context putImageData: imageData dest: 80 @ 10.

	"Transparent rectangle below-top-middle"
	context clearRect: ( Rect origin: 80 @ 30 extent: 20 @ 10 ).
	context stroke.

	"Circle in lower-right, with clipped square in middle-middle."
	context beginPath.
	context arc: 90 @ 60 radius: 10 startAngle: 0 endAngle: Float pi * 2 counterclockwise: false.
	context save.		"Save context before clipping."
	context clip.
	context fillStyle: 'orange'.
	context fillRect: ( Rect origin: 80 @ 50 extent: 10 @ 10 ).
	context stroke.
	context restore.	"Undo clipping."

	"Ellipse in top next column"
	context beginPath.
	context ellipse: 150 @ 20 radii: 10 @ 5  rotation: Float pi / 4 * 3 startAngle: 0 endAngle: Float pi * 2 counterclockwise: false.
	context stroke.

	"Rectangle filled with orange"
	context fillStyle: 'orange'.
	context beginPath.
	context rect: ( Rect origin: 140 @ 35 extent: 20 @ 10 ).
	context fill.

	"Filled traingle path."
	path := Path2d new.
	path moveTo: 140 @ 45.
	path lineTo: 150 @ 45.
	path lineTo: 140 @ 55.
	path closePath.
	context fillStyle: 'blue'.
	context fillPath: path.

	"Draw text and once with width limit."
	context font: '12px sans-serif'.
	context fillText: 'Hi' at: 140 @ 70.
	context fillText: 'Hi' at: 140 @ 80 maxWidth: 8.

	"Draw *outline* text and once with width limit."
	context lineWidth: 1.
	context strokeText: 'Hi' at: 154 @ 70.
	context strokeText: 'Hi' at: 154 @ 80 maxWidth: 8.

	"Quadratic Bezier curve in next column top."
	context beginPath.
	context moveTo: 170 @ 20.
	context quadraticCurveTo: 190 @ 0 end: 190 @ 20.
	context stroke.

	"Rectangle with rounded corners, below previous."
	context beginPath.
	context roundRect: ( Rect origin: 170 @ 30 extent: 20 @ 10 ) radius: 5.
	context stroke.

	"Rectangle with differently rounded corners, below previous."
	context beginPath.
	context roundRect: ( Rect origin: 170 @ 50 extent: 20 @ 10 ) radii: #( 0 4 8 12 ).
	context stroke.

	"Rectangle at top-left, rotated 45 degrees clockwise."
	context rotate: Float pi / 4.
	context fillRect: ( Rect origin: 0 @ 0 extent: 20 @ 10 ).
	context resetTransform.

	"Rectangle left-center scaled from square 1 x 1 to rectangle 15 x 10"
	context scale: 15 @ 10.
	context fillRect: ( Rect origin: 0 @ 4 extent: 1 @ 1 ).
	context resetTransform.

	"Draw small rectangle middle-bottom,
	 that is a transposed and transformed square with x * 2."
	matrix := DomMatrix init: #( 2 0 0 1 0 0 ).
	context setTransform: matrix.
	context fillRect: ( Rect origin: 40 @ 85 extent: 10 @ 5 ).

	"Additional transform, using same matrix values,
	 so now x * 4 is drawn in right-bottom."
	context transform: matrix.
	context fillRect: ( Rect origin: 40 @ 85 extent: 10 @ 5 ).
	context resetTransform.

	"Draw blue square at left-middle-bottom
	 Of which x coordinate is translated (transposed) by +40."
	context translate: 40 @ 0.
	context fillRect: ( Rect origin: 0 @ 85 extent: 5 @ 5 ).
	context resetTransform.

	"Dashed line in middle-right-bottom"
	context beginPath.
	context moveTo: 110 @ 82.
	context setLineDash: #( 4 2 ).
	context lineWidth: 4.
	context lineTo: 130 @ 82.
	context stroke.
	context setLineDash: #().
	context lineWidth: 1.

	"Rectangle in right colum lower, with line width of 2."
	context lineWidth: 2.
	context strokeRect: ( Rect origin: 170 @ 70 extent: 20 @ 10 ).
	context lineWidth: 1.
!
async drawImage
	| context imageData colorBlue colorWhite color imageBitmap pattern |
	context := canvas getContext2d.

	"ImageData - Create small blue square middle-lower"
	colorBlue := #( 0 0 255 255 ).
	colorWhite := #( 255 255 255 255 ).
	imageData := context createImageData: 10 @ 10.
	0 to: imageData width - 1 do: [ :x |
		0 to: imageData height - 1 do: [ :y |
			"Paint edges of square blue, rest white."
			color := ( x = 0 ) | ( x = 9 ) | ( y = 0 ) | ( y = 9 )
				ifTrue: [ colorBlue ] ifFalse: [ colorWhite ].
			imageData atPixel: x @ y put: color ] ].

	imageBitmap := await ImageBitmap create: imageData.

	"Draw image right top: regular, cut-out, scaled."
	context drawImage: imageBitmap dest: 110 @ 10.
	context drawImage: imageBitmap
		sourceRect: ( Rect origin: 5 @ 0 extent: 10 @ 10 )
		destRect: ( Rect origin: 125 @ 10 extent: 10 @ 10 ).
	context drawImage: imageBitmap destRect: ( Rect origin: 110 @ 25 extent: 20 @ 20 ).

	"Draw pattern of image 2 x 2."
	pattern := context createPattern: imageBitmap repetition: 'repeat'.
	context fillStyle: pattern.
	context fillRect: ( Rect origin: 110 @ 50 extent: 20 @ 20 ).

	imageBitmap close.
!
drawPaths
	| context path path2 matrix
		imageData pattern gradient attributes lineDash textMetrics contextAttributes |

	context := canvas getContext2d.
	self assert: [ context class = CanvasRenderingContext2d ].
	context strokeStyle: 'blue'.

	"Draw horizontal and vertical line
	 that is the addition of 2 paths."
	path := Path2d new.
	path moveTo: 200 @ 10.
	path lineTo: 220 @ 10.

	path2 := Path2d new.
	path2 moveTo: 220 @ 10.
	path2 lineTo: 220 @ 20.

	path addPath: path2.
	context strokePath: path.

	"Draw horizontal and vertical line
	 that is a transposed and transformed square with y * 2.
	 This expands the previous shape to a recangle"

	path := Path2d new.
	path moveTo: 220 @ 20.
	path lineTo: 200 @ 20.

	path2 := Path2d new.
	path2 moveTo: 200 @ 10.
	path2 lineTo: 200 @ 5.

	matrix := DomMatrix init: #( 1 0 0 2 0 0 ).
	path addPath: path2 transform: matrix.
	context strokePath: path.

	"Pointed down triangle below rectangle using closePath."
	path := Path2d new.
	path moveTo: 200 @ 30.
	path lineTo: 220 @ 30.
	path lineTo: 210 @ 40.
	path closePath.
	context strokePath: path.

	"Rectangle with rounded corners below previous."
	path := Path2d new.
	path roundRect: ( Rect origin: 200 @ 50 extent: 20 @ 10 ) radius: 5.
	context strokePath: path.

	"Rectangle with differently rounded corners below previous."
	path := Path2d new.
	path roundRect: ( Rect origin: 200 @ 70 extent: 20 @ 10 ) radii: #( 12 4 8 0 ).
	context strokePath: path.

	"Circle half counterclockwise, top of next column."
	path := Path2d new.
	path arc: 240 @ 20 radius: 10 startAngle: 0 endAngle: Float pi counterclockwise: true.
	context strokePath: path.

	"Rounded hook, below previous."
	path := Path2d new.
	path moveTo: 230 @ 30.
	path arcTo: 250 @ 30 to: 250 @ 50 radius: 10.
	context strokePath: path.

	"Bezier curve, below previous."
	path := Path2d new.
	path moveTo: 230 @ 50.
	path bezierCurveTo: 240 @ 60 to: 245 @ 60 end: 250 @ 50.
	context strokePath: path.

	"Ellipse halved and rotated, below previous."
	path := Path2d new.
	path ellipse: 240 @ 70 radii: 10 @ 5  rotation: Float pi / 4 * 3 startAngle: Float pi * 0.5 endAngle: Float pi * 1.5 counterclockwise: true.
	context strokePath: path.

	"Quadratic curve "
	path := Path2d new.
	path moveTo: 230 @ 90.
	path quadraticCurveTo: 235 @ 80 end: 250 @ 90.
	context strokePath: path.
!
