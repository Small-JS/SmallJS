CLASS Buffer EXTENDS Uint8Array MODULE Node1 CLASSVARS '' VARS ''

"TODO: Add more (all?) Nodes.js methods"

CLASSMETHODS

new
	^ self fromJs: INLINE 'Buffer.alloc( 0 )'.
!
new: length
	^ self fromJs: INLINE 'new Buffer.alloc( length.js )'.
!
buffer: arrayBuffer
	^ self fromJs: INLINE 'new Buffer( arrayBuffer.js )'.
!
buffer: arrayBuffer offset: offset
	^ self fromJs: INLINE 'new Buffer( arrayBuffer.js, offset.js )'.
!
buffer: arrayBuffer offset: offset length: length
	^ self fromJs: INLINE 'new Buffer( arrayBuffer.js, offset.js, length.js )'.
!
from: source
	"Source class can be: Array, ArrayBuffer, Buffer, String"
	^ self fromJs: INLINE 'Buffer.from( source.js )'.
!

METHODS

"Conversion"

toString
	^ String fromJs: INLINE 'this.js.toString()'.
!
