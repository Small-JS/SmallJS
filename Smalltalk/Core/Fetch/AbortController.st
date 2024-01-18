CLASS AbortController EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new AbortController()'.
!

METHODS

"Properties"

signal
	^ AbortSignal fromJs: INLINE 'this.js.signal'.
!

"Methods"

abort
	INLINE 'this.js.abort()'.
!
