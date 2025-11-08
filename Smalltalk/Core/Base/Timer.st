CLASS Timer EXTENDS Object MODULE Core CLASSVARS '' VARS 'id'

CLASSMETHODS

timeout: timeout then: block
	^ self new timeout: timeout then: block.
!
async timeout: timeout
	^ await self new timeout: timeout
!
interval: interval then: block
	^ self new interval: interval then: block.
!

METHODS

"Timeout"

timeout: timeout then: block
	id := Integer fromJs: INLINE 'setTimeout( block.js, timeout.js )'.
!
async timeout: timeout
	"Promise version of timeout.
	 This enables awaiting small delays (sleep).
	 This function rettuns JS undefined, so that cannot be used in ST."

	"Set id to ST Integer 0 to facilitate assignment in JS"
	id := 0.
	INLINE 'return new Promise(
		resolve => ( this.id.js = setTimeout( resolve, timeout.js ) ) )'.
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

"Accessing"

id
	^ id.
!
