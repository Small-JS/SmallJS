CLASS Console EXTENDS Object MODULE Core CLASSVARS '' VARS ''

"This class encasulates the JS class: Console."

CLASSMETHODS

clear
	INLINE 'console.clear()'.
!

"Message types"

assert: boolean value: value
	INLINE 'console.assert( boolean.js, value.$toString().js )'.
!
debug: value
	INLINE 'console.debug( value.$toString().js )'.
!
error: value
	INLINE 'console.error( value.$toString().js )'.
!
info: value
	INLINE 'console.info( value.$toString().js )'.
!
log: value
	INLINE 'console.log( value.$toString().js )'.
!
warn: value
	INLINE 'console.warn( value.$toString().js )'.
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
