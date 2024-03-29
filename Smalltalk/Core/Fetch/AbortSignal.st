CLASS AbortSignal EXTENDS EventTarget MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self formJs: INLINE 'new AbortSignal()'.
!
abort
	^ AbortSignal fromJs: INLINE 'AbortSignal.abort()'.
!
any: abortSignals
	^ AbortSignal fromJs: INLINE 'AbortSignal.any( abortSignals.$toJs() )'.
!
timeout: time
	^ AbortSignal fromJs: INLINE 'AbortSignal.timeout( time.js )'.
!

METHODS

"Properties"

aborted
	^ Boolean fromJs: INLINE 'this.js.aborted'.
!
reason
	^ String fromJs: INLINE 'this.js.reason'.
!

"Methods"

throwIfAborted
	INLINE 'this.js.throwIfAborted()'.
!
