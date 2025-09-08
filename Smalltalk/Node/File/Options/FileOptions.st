CLASS FileOptions EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

encoding
	^ String fromJs: INLINE 'this.js.encoding'.
!
encoding: encoding
	INLINE 'this.js.encoding = encoding.js'.
!
autoClose
	^ Boolean fromJs: INLINE 'this.js.autoClose'.
!
autoClose: autoClose
	INLINE 'this.js.autoClose = autoClose.js'.
!
emitClose
	^ Boolean fromJs: INLINE 'this.js.emitClose'.
!
emitClose: emitClose
	INLINE 'this.js.emitClose = emitClose.js'.
!
start
	^ Integer fromJs: INLINE 'this.js.start'.
!
start: start
	INLINE 'this.js.start = start.js'.
!
end
	^ Integer fromJs: INLINE 'this.js.end'.
!
end: end
	INLINE 'this.js.end = end.js'.
!
highWaterMark
	^ Integer fromJs: INLINE 'this.js.highWaterMark'.
!
highWaterMark: highWaterMark
	INLINE 'this.js.highWaterMark = highWaterMark.js'.
!
signal
	^ AbortSignal fromJs: INLINE 'this.js.signal'.
!
signal: signal
	INLINE 'this.js.signal = signal.js'.
!
