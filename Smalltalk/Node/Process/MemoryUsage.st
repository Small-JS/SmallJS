CLASS MemoryUsage EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

rss
	^ Integer fromJs: INLINE 'this.js.rss'.
!
heapTotal
	^ Integer fromJs: INLINE 'this.js.heapTotal'.
!
heapUsed
	^ Integer fromJs: INLINE 'this.js.heapUsed'.
!
external
	^ Integer fromJs: INLINE 'this.js.external'.
!
arrayBuffers
	^ Integer fromJs: INLINE 'this.js.arrayBuffers'.
!
