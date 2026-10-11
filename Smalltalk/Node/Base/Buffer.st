CLASS Buffer EXTENDS Uint8Array MODULE Node1 CLASSVARS '' VARS ''

"Implements Node.js class Buffer and the functions of module: node:buffer.
 Encodings are Strings like: 'utf8', 'utf16le', 'latin1', 'ascii', 'base64', 'base64url', 'hex'.
 Note: Classes Blob and File of module node:buffer are the same as in Core."

INLINE 'const buffer$ = await import( "node:buffer" );'

CLASSMETHODS

"Creation"

new
	^ self fromJs: INLINE 'Buffer.alloc( 0 )'.
!
new: length
	^ self fromJs: INLINE 'Buffer.alloc( length.js )'.
!
new: length fill: value
	"Value can be: Integer, String or Buffer."
	^ self fromJs: INLINE 'Buffer.alloc( length.js, value.js )'.
!
new: length fill: string encoding: encoding
	^ self fromJs: INLINE 'Buffer.alloc( length.js, string.js, encoding.js )'.
!
allocUnsafe: length
	"Faster, but the contents are not initialized and may contain old data."
	^ self fromJs: INLINE 'Buffer.allocUnsafe( length.js )'.
!
allocUnsafeSlow: length
	"Like allocUnsafe:, but not from the shared memory pool."
	^ self fromJs: INLINE 'Buffer.allocUnsafeSlow( length.js )'.
!
buffer: arrayBuffer
	"Shares memory with arrayBuffer."
	^ self fromJs: INLINE 'Buffer.from( arrayBuffer.js )'.
!
buffer: arrayBuffer offset: offset
	^ self fromJs: INLINE 'Buffer.from( arrayBuffer.js, offset.js )'.
!
buffer: arrayBuffer offset: offset length: length
	^ self fromJs: INLINE 'Buffer.from( arrayBuffer.js, offset.js, length.js )'.
!
from: source
	"Source class can be: Array (of Integers), ArrayBuffer, Buffer, Uint8Array, String (UTF-8).
	 Copies the source, except for ArrayBuffer."
	^ self fromJs: INLINE 'Buffer.from( source.$toJs() )'.
!
from: string encoding: encoding
	^ self fromJs: INLINE 'Buffer.from( string.js, encoding.js )'.
!
concat: buffers
	"Buffers is an Array of Buffers or Uint8Arrays."
	^ self fromJs: INLINE 'Buffer.concat( buffers.$toJs() )'.
!
concat: buffers length: totalLength
	^ self fromJs: INLINE 'Buffer.concat( buffers.$toJs(), totalLength.js )'.
!
copyBytesFrom: typedArray
	"Copy the bytes of any TypedArray."
	^ self fromJs: INLINE 'Buffer.copyBytesFrom( typedArray.js )'.
!
copyBytesFrom: typedArray offset: offset
	"Offset and length are in elements, not bytes."
	^ self fromJs: INLINE 'Buffer.copyBytesFrom( typedArray.js, offset.js )'.
!
copyBytesFrom: typedArray offset: offset length: length
	^ self fromJs: INLINE 'Buffer.copyBytesFrom( typedArray.js, offset.js, length.js )'.
!

"Testing"

isBuffer: object
	^ Boolean fromJs: INLINE 'Buffer.isBuffer( object.js )'.
!
isEncoding: encoding
	^ Boolean fromJs: INLINE 'Buffer.isEncoding( encoding.js )'.
!
isUtf8: input
	"Input can be: Buffer, TypedArray or ArrayBuffer."
	^ Boolean fromJs: INLINE 'buffer$.isUtf8( input.js )'.
!
isAscii: input
	^ Boolean fromJs: INLINE 'buffer$.isAscii( input.js )'.
!

"Comparing"

compare: buffer1 with: buffer2
	"Return -1, 0 or 1. Suitable for sorting."
	^ Integer fromJs: INLINE 'Buffer.compare( buffer1.js, buffer2.js )'.
!

"Conversion"

byteLength: string
	"The number of bytes of the UTF-8 encoded string."
	^ Integer fromJs: INLINE 'Buffer.byteLength( string.js )'.
!
byteLength: string encoding: encoding
	^ Integer fromJs: INLINE 'Buffer.byteLength( string.js, encoding.js )'.
!
transcode: source from: fromEncoding to: toEncoding
	^ self fromJs: INLINE 'buffer$.transcode( source.js, fromEncoding.js, toEncoding.js )'.
!
atob: string
	"Legacy: decode a base64 string to a latin1 string. Prefer: from:encoding: 'base64'."
	^ String fromJs: INLINE 'buffer$.atob( string.js )'.
!
btoa: string
	"Legacy: encode a latin1 string to a base64 string. Prefer: toString: 'base64'."
	^ String fromJs: INLINE 'buffer$.btoa( string.js )'.
!
resolveObjectURL: id
	"Return the Blob registered with URL.createObjectURL(), or nil."
	^ Blob fromJs: INLINE 'buffer$.resolveObjectURL( id.js )'.
!

"Properties"

poolSize
	^ Integer fromJs: INLINE 'Buffer.poolSize'.
!
poolSize: size
	INLINE 'Buffer.poolSize = size.js'.
!
maxLength
	"The largest size allowed for a single Buffer."
	^ Integer fromJs: INLINE 'buffer$.constants.MAX_LENGTH'.
!
maxStringLength
	"The largest length allowed for a single String."
	^ Integer fromJs: INLINE 'buffer$.constants.MAX_STRING_LENGTH'.
!
inspectMaxBytes
	^ Integer fromJs: INLINE 'buffer$.INSPECT_MAX_BYTES'.
!

METHODS

"Conversion"

toString
	"Decode as UTF-8."
	^ String fromJs: INLINE 'this.js.toString()'.
!
toString: encoding
	^ String fromJs: INLINE 'this.js.toString( encoding.js )'.
!
toString: encoding start: start end: end
	^ String fromJs: INLINE 'this.js.toString( encoding.js, start.js, end.js )'.
!
toJsonObject
	"Return a JsObject with keys: type ('Buffer') and data (Array of bytes)."
	^ JsObject fromJs: INLINE 'this.js.toJSON()'.
!

"Copying"

copy
	"Overridden, because Buffer.prototype.slice shares memory."
	^ self class fromJs: INLINE 'Buffer.from( this.js )'.
!
slice: start
	"Return a copy, like other arrays do. Use subarray: to share memory."
	^ self class fromJs: INLINE 'Buffer.from( Uint8Array.prototype.slice.call( this.js, start.js ) )'.
!
slice: start to: end
	^ self class fromJs: INLINE 'Buffer.from( Uint8Array.prototype.slice.call( this.js, start.js, end.js ) )'.
!
copyTo: target
	"Copy bytes into target Buffer or Uint8Array. Return the number of bytes copied."
	^ Integer fromJs: INLINE 'this.js.copy( target.js )'.
!
copyTo: target targetStart: targetStart
	^ Integer fromJs: INLINE 'this.js.copy( target.js, targetStart.js )'.
!
copyTo: target targetStart: targetStart sourceStart: sourceStart sourceEnd: sourceEnd
	^ Integer fromJs: INLINE 'this.js.copy( target.js, targetStart.js, sourceStart.js, sourceEnd.js )'.
!

"Comparing"

equals: buffer
	"True if buffer has the same bytes. Buffer can also be an Uint8Array."
	^ Boolean fromJs: INLINE 'this.js.equals( buffer.js )'.
!
compare: target
	"Return -1, 0 or 1."
	^ Integer fromJs: INLINE 'this.js.compare( target.js )'.
!
compare: target targetStart: targetStart targetEnd: targetEnd sourceStart: sourceStart sourceEnd: sourceEnd
	^ Integer fromJs: INLINE 'this.js.compare( target.js, targetStart.js, targetEnd.js, sourceStart.js, sourceEnd.js )'.
!

"Searching
 Value can be: Integer (byte), String or Buffer."

indexOf: value offset: offset
	^ Integer fromJs: INLINE 'this.js.indexOf( value.js, offset.js )'.
!
indexOf: value offset: offset encoding: encoding
	^ Integer fromJs: INLINE 'this.js.indexOf( value.js, offset.js, encoding.js )'.
!
lastIndexOf: value offset: offset
	^ Integer fromJs: INLINE 'this.js.lastIndexOf( value.js, offset.js )'.
!
lastIndexOf: value offset: offset encoding: encoding
	^ Integer fromJs: INLINE 'this.js.lastIndexOf( value.js, offset.js, encoding.js )'.
!
includes: value offset: offset
	^ Boolean fromJs: INLINE 'this.js.includes( value.js, offset.js )'.
!
includes: value offset: offset encoding: encoding
	^ Boolean fromJs: INLINE 'this.js.includes( value.js, offset.js, encoding.js )'.
!

"Modifying"

fill: value
	"Value can be: Integer, String or Buffer."
	INLINE 'this.js.fill( value.js )'.
!
fill: string encoding: encoding
	INLINE 'this.js.fill( string.js, encoding.js )'.
!
fill: value start: start end: end encoding: encoding
	INLINE 'this.js.fill( value.js, start.js, end.js, encoding.js )'.
!
write: string
	"Write the UTF-8 encoded string at offset 0. Return the number of bytes written."
	^ Integer fromJs: INLINE 'this.js.write( string.js )'.
!
write: string encoding: encoding
	^ Integer fromJs: INLINE 'this.js.write( string.js, encoding.js )'.
!
write: string offset: offset
	^ Integer fromJs: INLINE 'this.js.write( string.js, offset.js )'.
!
write: string offset: offset length: length
	^ Integer fromJs: INLINE 'this.js.write( string.js, offset.js, length.js )'.
!
write: string offset: offset length: length encoding: encoding
	^ Integer fromJs: INLINE 'this.js.write( string.js, offset.js, length.js, encoding.js )'.
!
swap16
	"Swap the byte order in place, per 2 bytes. Length must be a multiple of 2."
	INLINE 'this.js.swap16()'.
!
swap32
	INLINE 'this.js.swap32()'.
!
swap64
	INLINE 'this.js.swap64()'.
!

"Reading numbers
 BE is big-endian, LE is little-endian. Offset is in bytes."

readInt8: offset
	^ Integer fromJs: INLINE 'this.js.readInt8( offset.js )'.
!
readUInt8: offset
	^ Integer fromJs: INLINE 'this.js.readUInt8( offset.js )'.
!
readInt16BE: offset
	^ Integer fromJs: INLINE 'this.js.readInt16BE( offset.js )'.
!
readInt16LE: offset
	^ Integer fromJs: INLINE 'this.js.readInt16LE( offset.js )'.
!
readUInt16BE: offset
	^ Integer fromJs: INLINE 'this.js.readUInt16BE( offset.js )'.
!
readUInt16LE: offset
	^ Integer fromJs: INLINE 'this.js.readUInt16LE( offset.js )'.
!
readInt32BE: offset
	^ Integer fromJs: INLINE 'this.js.readInt32BE( offset.js )'.
!
readInt32LE: offset
	^ Integer fromJs: INLINE 'this.js.readInt32LE( offset.js )'.
!
readUInt32BE: offset
	^ Integer fromJs: INLINE 'this.js.readUInt32BE( offset.js )'.
!
readUInt32LE: offset
	^ Integer fromJs: INLINE 'this.js.readUInt32LE( offset.js )'.
!
readIntBE: offset byteLength: byteLength
	"ByteLength can be 1 to 6."
	^ Integer fromJs: INLINE 'this.js.readIntBE( offset.js, byteLength.js )'.
!
readIntLE: offset byteLength: byteLength
	^ Integer fromJs: INLINE 'this.js.readIntLE( offset.js, byteLength.js )'.
!
readUIntBE: offset byteLength: byteLength
	^ Integer fromJs: INLINE 'this.js.readUIntBE( offset.js, byteLength.js )'.
!
readUIntLE: offset byteLength: byteLength
	^ Integer fromJs: INLINE 'this.js.readUIntLE( offset.js, byteLength.js )'.
!
readBigInt64BE: offset
	^ BigInt fromJs: INLINE 'this.js.readBigInt64BE( offset.js )'.
!
readBigInt64LE: offset
	^ BigInt fromJs: INLINE 'this.js.readBigInt64LE( offset.js )'.
!
readBigUInt64BE: offset
	^ BigInt fromJs: INLINE 'this.js.readBigUInt64BE( offset.js )'.
!
readBigUInt64LE: offset
	^ BigInt fromJs: INLINE 'this.js.readBigUInt64LE( offset.js )'.
!
readFloatBE: offset
	^ Float fromJs: INLINE 'this.js.readFloatBE( offset.js )'.
!
readFloatLE: offset
	^ Float fromJs: INLINE 'this.js.readFloatLE( offset.js )'.
!
readDoubleBE: offset
	^ Float fromJs: INLINE 'this.js.readDoubleBE( offset.js )'.
!
readDoubleLE: offset
	^ Float fromJs: INLINE 'this.js.readDoubleLE( offset.js )'.
!

"Writing numbers
 Return the offset plus the number of bytes written."

writeInt8: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeInt8( value.js, offset.js )'.
!
writeUInt8: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeUInt8( value.js, offset.js )'.
!
writeInt16BE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeInt16BE( value.js, offset.js )'.
!
writeInt16LE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeInt16LE( value.js, offset.js )'.
!
writeUInt16BE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeUInt16BE( value.js, offset.js )'.
!
writeUInt16LE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeUInt16LE( value.js, offset.js )'.
!
writeInt32BE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeInt32BE( value.js, offset.js )'.
!
writeInt32LE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeInt32LE( value.js, offset.js )'.
!
writeUInt32BE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeUInt32BE( value.js, offset.js )'.
!
writeUInt32LE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeUInt32LE( value.js, offset.js )'.
!
writeIntBE: value offset: offset byteLength: byteLength
	^ Integer fromJs: INLINE 'this.js.writeIntBE( value.js, offset.js, byteLength.js )'.
!
writeIntLE: value offset: offset byteLength: byteLength
	^ Integer fromJs: INLINE 'this.js.writeIntLE( value.js, offset.js, byteLength.js )'.
!
writeUIntBE: value offset: offset byteLength: byteLength
	^ Integer fromJs: INLINE 'this.js.writeUIntBE( value.js, offset.js, byteLength.js )'.
!
writeUIntLE: value offset: offset byteLength: byteLength
	^ Integer fromJs: INLINE 'this.js.writeUIntLE( value.js, offset.js, byteLength.js )'.
!
writeBigInt64BE: value offset: offset
	"Value can be a BigInt or an Integer."
	^ Integer fromJs: INLINE 'this.js.writeBigInt64BE( BigInt( value.js ), offset.js )'.
!
writeBigInt64LE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeBigInt64LE( BigInt( value.js ), offset.js )'.
!
writeBigUInt64BE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeBigUInt64BE( BigInt( value.js ), offset.js )'.
!
writeBigUInt64LE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeBigUInt64LE( BigInt( value.js ), offset.js )'.
!
writeFloatBE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeFloatBE( value.js, offset.js )'.
!
writeFloatLE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeFloatLE( value.js, offset.js )'.
!
writeDoubleBE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeDoubleBE( value.js, offset.js )'.
!
writeDoubleLE: value offset: offset
	^ Integer fromJs: INLINE 'this.js.writeDoubleLE( value.js, offset.js )'.
!
