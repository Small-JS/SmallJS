CLASS TextMetrics EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Width"

width
	^ Float fromJs: INLINE 'this.js.width'.
!

"Actual bounding box"

actualBoundingBoxLeft
	^ Float fromJs: INLINE 'this.js.actualBoundingBoxLeft'.
!
actualBoundingBoxRight
	^ Float fromJs: INLINE 'this.js.actualBoundingBoxRight'.
!
actualBoundingBoxAscent
	^ Float fromJs: INLINE 'this.js.actualBoundingBoxAscent'.
!
actualBoundingBoxDescent
	^ Float fromJs: INLINE 'this.js.actualBoundingBoxDescent'.
!

"Font bounding box"

fontBoundingBoxAscent
	^ Float fromJs: INLINE 'this.js.fontBoundingBoxAscent'.
!
fontBoundingBoxDescent
	^ Float fromJs: INLINE 'this.js.fontBoundingBoxDescent'.
!

"Baseline"

hangingBaseline
	^ Float fromJs: INLINE 'this.js.hangingBaseline'.
!
alphabeticBaseline
	^ Float fromJs: INLINE 'this.js.alphabeticBaseline'.
!
ideographicBaseline
	^ Float fromJs: INLINE 'this.js.ideographicBaseline'.
!
