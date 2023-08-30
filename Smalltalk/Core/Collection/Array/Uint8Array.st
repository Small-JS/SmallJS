CLASS Uint8Array EXTENDS TypedArray MODULE Core CLASSVARS '' VARS ''
	"Note: Other TypedArrays subclasses are not implemented yet because of lack of use,
		but can be made by simply copying this file and replacing the JS classname in de INLINE statements.
		E.g.: 'Uint8Array' becomes 'BigInt64Array'. Please also create appropriate unit tests."

CLASSMETHODS

new
	^ super new js: INLINE 'new Uint8Array()'.
!
new: length
	^ super new js: INLINE 'new Uint8Array( length.js )'.
!
buffer: arrayBuffer
	^ INLINE 'new Uint8Array( arrayBuffer.js )'
!
buffer: arrayBuffer offset: offset
	^ INLINE 'new Uint8Array( arrayBuffer.js, offset.js )'
!
buffer: arrayBuffer offset: offset length: length
	^ INLINE 'new Uint8Array( arrayBuffer.js, offset.js, length.js )'
!
bytesPerElement
	^ Integer fromJs: INLINE 'Uint8Array.BYTES$PER$ELEMENT'.
!
name
	^ String fromJs: INLINE 'Uint8Array.name'.
!
elementClass
	^ Integer.
!
