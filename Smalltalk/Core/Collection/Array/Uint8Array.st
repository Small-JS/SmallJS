CLASS Uint8Array EXTENDS TypedArray MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

"Creation"

new
	^ self fromJs: INLINE 'new Uint8Array()'.
!
new: length
	^ self fromJs: INLINE 'new Uint8Array( length.js )'.
!
buffer: arrayBuffer
	^ self fromJs: INLINE 'new Uint8Array( arrayBuffer.js )'
!
buffer: arrayBuffer offset: offset
	^ self fromJs: INLINE 'new Uint8Array( arrayBuffer.js, offset.js )'
!
buffer: arrayBuffer offset: offset length: length
	^ self fromJs: INLINE 'new Uint8Array( arrayBuffer.js, offset.js, length.js )'
!
encodeFromString: string
	^ self fromJs: INLINE 'new TextEncoder().encode( string.js )'.
!
fromHex: string
	^ Uint8Array fromJs: INLINE 'Uint8Array.fromHex( string.js )'.
!

"Properties"

bytesPerElement
	^ Integer fromJs: INLINE 'Uint8Array.BYTES$PER$ELEMENT'.
!
name
	^ String fromJs: INLINE 'Uint8Array.name'.
!
elementClass
	^ Integer.
!

METHODS

"Conversion"

decodeToString
	^ String fromJs: INLINE 'new TextDecoder().decode( this.js )'.
!
toHex
	^ String fromJs: INLINE 'this.js.toHex()'.
!
