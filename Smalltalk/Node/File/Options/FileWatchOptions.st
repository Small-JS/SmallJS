CLASS FileWatchOptions EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Options for: Fsp watch:options:iterate:."

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

persistent
	^ Boolean fromJs: INLINE 'this.js.persistent'.
!
persistent: persistent
	"If true (default), the process keeps running while watching."
	INLINE 'this.js.persistent = persistent.js'.
!
recursive
	^ Boolean fromJs: INLINE 'this.js.recursive'.
!
recursive: recursive
	"If true, also watch all subdirectories. Default: false."
	INLINE 'this.js.recursive = recursive.js'.
!
encoding
	^ String fromJs: INLINE 'this.js.encoding'.
!
encoding: encoding
	"Encoding of the reported file names. Default: 'utf8'."
	INLINE 'this.js.encoding = encoding.js'.
!
signal
	^ AbortSignal fromJs: INLINE 'this.js.signal'.
!
signal: abortSignal
	"Watching stops when this AbortSignal is aborted."
	INLINE 'this.js.signal = abortSignal.js'.
!
maxQueue
	^ Integer fromJs: INLINE 'this.js.maxQueue'.
!
maxQueue: maxQueue
	"Maximum number of events queued between iterations. Default: 2048."
	INLINE 'this.js.maxQueue = maxQueue.js'.
!
overflow
	^ String fromJs: INLINE 'this.js.overflow'.
!
overflow: overflow
	"What to do when the queue is full: 'ignore' (default) or 'throw'."
	INLINE 'this.js.overflow = overflow.js'.
!
