CLASS Float16Array EXTENDS TypedArray MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ super new js: INLINE 'new Float16Array()'.
!
new: length
	^ super new js: INLINE 'new Float16Array( length.js )'.
!
buffer: arrayBuffer
	^ INLINE 'new Float16Array( arrayBuffer.js )'
!
buffer: arrayBuffer offset: offset
	^ INLINE 'new Float16Array( arrayBuffer.js, offset.js )'
!
buffer: arrayBuffer offset: offset length: length
	^ INLINE 'new Float16Array( arrayBuffer.js, offset.js, length.js )'
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
