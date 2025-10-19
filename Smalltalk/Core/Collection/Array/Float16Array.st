CLASS Float16Array EXTENDS TypedArray MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Float16Array()'.
!
new: length
	^ self fromJs: INLINE 'new Float16Array( length.js )'.
!
buffer: arrayBuffer
	^ self fromJs: INLINE 'new Float16Array( arrayBuffer.js )'
!
buffer: arrayBuffer offset: offset
	^ self fromJs: INLINE 'new Float16Array( arrayBuffer.js, offset.js )'
!
buffer: arrayBuffer offset: offset length: length
	^ self fromJs: INLINE 'new Float16Array( arrayBuffer.js, offset.js, length.js )'
!
bytesPerElement
	^ Integer fromJs: INLINE 'Float16Array.BYTES$PER$ELEMENT'.
!
name
	^ String fromJs: INLINE 'Float16Array.name'.
!
elementClass
	^ Float.
!
