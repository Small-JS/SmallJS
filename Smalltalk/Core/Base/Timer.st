CLASS Timer EXTENDS Object MODULE Core CLASSVARS '' VARS 'id'

METHODS

"Timeout"

timeout: timeout then: block
	id := Integer fromJs: INLINE 'setTimeout( block.js, timeout.js )'.
!
clearTimeout
	INLINE 'clearTimeout( this.id.js )'.
!

"Interval"

interval: interval then: block
	id := Integer fromJs: INLINE 'setInterval( block.js, interval.js )'.
!
clearInterval
	INLINE 'clearInterval( this.id.js )'.
!
