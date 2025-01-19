CLASS Buffer EXTENDS Uint8Array MODULE Node1 CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'Buffer.alloc( 0 )'.
!
new: length
	^ self fromJs: INLINE 'Buffer.alloc( length.js )'.
!
buffer: arrayBuffer
	^ INLINE 'new Buffer( arrayBuffer.js )'
!
buffer: arrayBuffer offset: offset
	^ INLINE 'new Buffer( arrayBuffer.js, offset.js )'
!
buffer: arrayBuffer offset: offset length: length
	^ INLINE 'new Buffer( arrayBuffer.js, offset.js, length.js )'
!
