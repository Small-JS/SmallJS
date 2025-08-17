CLASS Console EXTENDS Object MODULE Core CLASSVARS '' VARS ''

"This class encasulates the JS class: Console."

CLASSMETHODS

clear
	INLINE 'console.clear()'.
!

"Message types"

assert: boolean message: message
	INLINE 'console.assert( boolean.js, message.js )'.
!
debug: message
	INLINE 'console.debug( message.js )'.
!
error: message
	INLINE 'console.error( message.js )'.
!
info: message
	INLINE 'console.info( message.js )'.
!
log: message
	INLINE 'console.log( message.js )'.
!
warn: message
	INLINE 'console.warn( message.js )'.
!

"Counting"

count: label
	INLINE 'console.count( label.js )'.
!
countReset: label
	INLINE 'console.countReset( label.js )'.
!

"Object logging"

dir: object
	INLINE 'console.dir( object )'.
!
dirxml: object
	INLINE 'console.dirxml( object )'.
!
table: array
	INLINE 'console.table( array.js )'.
!
trace
	INLINE 'console.trace()'.
!

"Gouping (intending)"

group: label
	INLINE 'console.group( label.js )'.
!
groupCollapsed: label
	INLINE 'console.groupCollapsed( label.js )'.
!
groupEnd: label
	INLINE 'console.groupEnd( label.js )'.
!

"Time"

time: label
	INLINE 'console.time( label.js )'.
!
timeLog: label
	INLINE 'console.timeLog( label.js )'.
!
timeStamp: label
	INLINE 'console.timeStamp( label.js )'.
!
timeEnd: label
	INLINE 'console.timeEnd( label.js )'.
!
