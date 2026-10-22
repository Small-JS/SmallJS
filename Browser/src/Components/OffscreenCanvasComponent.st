CLASS OffscreenCanvasComponent EXTENDS Component MODULE MyBrowserApp CLASSVARS ''
	VARS 'mainCanvas workerCanvas worker workerPixel'

"The same image is drawn on two OffscreenCanvases:
 - In the main thread, then transferred as ImageBitmap to the left canvas.
 - In a worker (MyCanvasWorker), with control transferred from the right canvas."

CLASSMETHODS

"Drawing"

draw: context
	"Draw the test image on the context. Also called from MyCanvasWorker."
	context fillStyle: 'white'.
	context fillRect: ( Rect origin: 0 @ 0 extent: context canvas size ).

	"Blue square left."
	context fillStyle: 'blue'.
	context fillRect: ( Rect origin: 10 @ 10 extent: 40 @ 40 ).

	"Orange circle right."
	context fillStyle: 'orange'.
	context beginPath.
	context arc: 85 @ 30 radius: 20 startAngle: 0 endAngle: Float pi * 2 counterclockwise: false.
	context fill.

	"Blue outline text over the circle."
	context strokeStyle: 'blue'.
	context font: '12px sans-serif'.
	context strokeText: 'Off' at: 75 @ 35.
!
samplePoint
	"Point inside the blue square, used for testing."
	^ 30 @ 30.
!

METHODS

"Initialization"

htmlPath
	^ 'Components/OffscreenCanvasComponent.html'.
!
async start
	self bindElements.
	self drawInMainThread.
	await self drawInWorker.
!
bindElements
	mainCanvas := Document getElementById: 'offscreenMainCanvas' class: HtmlCanvasElement.
	workerCanvas := Document getElementById: 'offscreenWorkerCanvas' class: HtmlCanvasElement.
!

"Accessing"

mainCanvas
	^ mainCanvas.
!
workerPixel
	"RGBA pixel at the sample point, read back by the worker after drawing.
	 Set when start has finished."
	^ workerPixel.
!

"Drawing"

drawInMainThread
	| offscreenCanvas imageBitmap |
	offscreenCanvas := OffscreenCanvas new: mainCanvas size.
	self class draw: offscreenCanvas getContext2d.
	imageBitmap := offscreenCanvas transferToImageBitmap.
	mainCanvas getContext2d drawImage: imageBitmap dest: 0 @ 0.
	imageBitmap close.
!
async drawInWorker
	"Draw in the worker and wait for its reply."
	| offscreenCanvas replied |
	offscreenCanvas := workerCanvas transferControlToOffscreen.
	worker := Worker new: 'Script/canvasWorker.js' options: ( WorkerOptions new type: 'module' ).
	replied := Promise new: [ :resolve :reject |
		worker onMessage: [ :event |
			workerPixel := Object fromJs: event data js.
			resolve value: nil ] ].
	worker postMessage: offscreenCanvas transfer: ( Array with: offscreenCanvas ).
	INLINE 'await replied.js'.
!
