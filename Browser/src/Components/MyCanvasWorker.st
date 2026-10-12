CLASS MyCanvasWorker EXTENDS Object MODULE MyBrowserApp CLASSVARS '' VARS ''

"Runs inside the worker thread started by OffscreenCanvasComponent.
 Started from the worker script: Browser/src/canvasWorker.ts
 Receives an OffscreenCanvas, draws on it, and replies with the RGBA pixel at the sample point."

METHODS

start
	DedicatedWorkerGlobalScope default
		onMessage: [ :event | self onMessage: event ].
!
onMessage: event
	| canvas context imageData |
	canvas := OffscreenCanvas fromJs: event data js.
	context := canvas getContext2d.
	OffscreenCanvasComponent draw: context.

	imageData := context getImageData: ( Rect origin: OffscreenCanvasComponent samplePoint extent: 1 @ 1 ).
	DedicatedWorkerGlobalScope default postMessage: ( imageData atPixel: 0 @ 0 ).
!
