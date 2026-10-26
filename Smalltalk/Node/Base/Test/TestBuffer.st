CLASS TestBuffer EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

testCreation
	| buffer |

	self assert: [ Buffer new length = 0 ].
	self assert: [ ( Buffer new: 3 ) length = 3 ].
	self assert: [ ( Buffer new: 3 ) last = 0 ].
	self assert: [ ( Buffer with: 7 ) first = 7 ].
	self assert: [ ( Buffer with: 8 with: 9 ) last = 9 ].
	self assert: [ ( Buffer new: 3 ) class = Buffer ].

	buffer := Buffer from: 'abc'.
	self assert: [ ( buffer at: 1 ) = 98 ].
	self assert: [ ( Buffer from: ( Array with: 1 with: 2 ) ) last = 2 ].
	self assert: [ ( Buffer from: buffer ) toString = 'abc' ].
	buffer := Buffer encodeFromString: 'é'.
	self assert: [ Buffer isBuffer: buffer ].
	self assert: [ ( buffer toString: 'hex' ) = 'c3a9' ].

	self assert: [ ( Buffer new: 3 fill: 5 ) last = 5 ].
	self assert: [ ( Buffer new: 4 fill: 'ab' ) toString = 'abab' ].
	self assert: [ ( Buffer new: 2 fill: '4142' encoding: 'hex' ) toString = 'AB' ].
	self assert: [ ( Buffer allocUnsafe: 5 ) length = 5 ].
	self assert: [ ( Buffer allocUnsafeSlow: 5 ) length = 5 ].

	"Buffers created from an ArrayBuffer share its memory."
	buffer := Buffer buffer: ( Uint8Array new: 4 ) buffer.
	self assert: [ buffer length = 4 ].
	buffer := Buffer buffer: ( Uint8Array new: 4 ) buffer offset: 1.
	self assert: [ buffer length = 3 ].
	buffer := Buffer buffer: ( Uint8Array new: 4 ) buffer offset: 1 length: 2.
	self assert: [ buffer length = 2 ].
!
testEncoding
	| buffer |

	buffer := Buffer from: 'aGVsbG8=' encoding: 'base64'.
	self assert: [ buffer toString = 'hello' ].
	self assert: [ ( buffer toString: 'base64' ) = 'aGVsbG8=' ].
	self assert: [ ( buffer toString: 'hex' ) = '68656c6c6f' ].
	self assert: [ ( buffer toString: 'utf8' start: 1 end: 3 ) = 'el' ].
	self assert: [ ( Buffer from: '6869' encoding: 'hex' ) toString = 'hi' ].

	self assert: [ ( Buffer byteLength: 'abc' ) = 3 ].
	self assert: [ ( Buffer byteLength: 'é' ) = 2 ].
	self assert: [ ( Buffer byteLength: 'aGVsbG8=' encoding: 'base64' ) = 5 ].

	self assert: [ Buffer isEncoding: 'utf8' ].
	self assert: [ ( Buffer isEncoding: 'nonsense' ) not ].
	self assert: [ Buffer isUtf8: ( Buffer from: 'é' ) ].
	self assert: [ ( Buffer isUtf8: ( Buffer with: 255 ) ) not ].
	self assert: [ Buffer isAscii: ( Buffer from: 'abc' ) ].
	self assert: [ ( Buffer isAscii: ( Buffer from: 'é' ) ) not ].

	buffer := Buffer transcode: ( Buffer from: 'abc' ) from: 'utf8' to: 'utf16le'.
	self assert: [ buffer length = 6 ].
	self assert: [ ( buffer toString: 'utf16le' ) = 'abc' ].

	self assert: [ ( Buffer btoa: 'hello' ) = 'aGVsbG8=' ].
	self assert: [ ( Buffer atob: 'aGVsbG8=' ) = 'hello' ].

	self assert: [ ( buffer toJsonObject atJsProperty: 'type' ) = 'Buffer' ].
!
testTesting
	self assert: [ Buffer isBuffer: Buffer new ].
	self assert: [ ( Buffer isBuffer: Uint8Array new ) not ].
	self assert: [ ( Buffer isBuffer: 'abc' ) not ].
!
testProperties
	self assert: [ Buffer poolSize > 0 ].
	self assert: [ Buffer maxLength > 0 ].
	self assert: [ Buffer maxStringLength > 0 ].
	self assert: [ Buffer inspectMaxBytes > 0 ].
	self assert: [ ( Buffer resolveObjectURL: 'blob:nodedata:unknown' ) isNil ].
!
testConcat
	| buffers |

	buffers := Array with: ( Buffer from: 'ab' ) with: ( Buffer from: 'cd' ).
	self assert: [ ( Buffer concat: buffers ) toString = 'abcd' ].
	self assert: [ ( Buffer concat: buffers length: 3 ) toString = 'abc' ].
	self assert: [ ( Buffer concat: buffers ) class = Buffer ].
!
testCopyBytesFrom
	| bytes halfFloats |

	bytes := Uint8Array new: 3.
	bytes at: 0 put: 1; at: 1 put: 2; at: 2 put: 3.
	self assert: [ ( Buffer copyBytesFrom: bytes ) length = 3 ].
	self assert: [ ( Buffer copyBytesFrom: bytes offset: 1 ) first = 2 ].
	self assert: [ ( Buffer copyBytesFrom: bytes offset: 1 length: 1 ) length = 1 ].

	"Offset and length are in elements, not bytes."
	halfFloats := Float16Array new: 3.
	self assert: [ ( Buffer copyBytesFrom: halfFloats ) length = 6 ].
	self assert: [ ( Buffer copyBytesFrom: halfFloats offset: 1 ) length = 4 ].
	self assert: [ ( Buffer copyBytesFrom: halfFloats offset: 1 length: 1 ) length = 2 ].
!
testCopying
	| buffer copy target |

	buffer := Buffer from: 'abc'.

	"copy, slice: and slice:to: return copies, unlike Buffer.prototype.slice."
	copy := buffer copy.
	copy at: 0 put: 120.
	self assert: [ buffer toString = 'abc' ].
	copy := buffer slice: 1.
	self assert: [ copy toString = 'bc' ].
	copy at: 0 put: 120.
	self assert: [ buffer toString = 'abc' ].
	copy := buffer slice: 0 to: 2.
	self assert: [ copy toString = 'ab' ].
	self assert: [ copy class = Buffer ].
	copy at: 0 put: 120.
	self assert: [ buffer toString = 'abc' ].

	copy := buffer toReversed.
	self assert: [ copy toString = 'cba' ].
	self assert: [ Buffer isBuffer: copy ].
	copy at: 0 put: 120.
	self assert: [ buffer toString = 'abc' ].
	self assert: [ Buffer isBuffer: ( buffer slice: 1 ) ].

	"subarray: shares memory."
	( buffer subarray: 1 ) at: 0 put: 120.
	self assert: [ buffer toString = 'axc' ].

	buffer := Buffer from: 'abc'.
	target := Buffer new: 5 fill: '-'.
	self assert: [ ( buffer copyTo: target ) = 3 ].
	self assert: [ target toString = 'abc--' ].
	target := Buffer new: 5 fill: '-'.
	self assert: [ ( buffer copyTo: target targetStart: 2 ) = 3 ].
	self assert: [ target toString = '--abc' ].
	target := Buffer new: 5 fill: '-'.
	self assert: [ ( buffer copyTo: target targetStart: 1 sourceStart: 1 sourceEnd: 3 ) = 2 ].
	self assert: [ target toString = '-bc--' ].
!
testComparing
	| abc abd |

	abc := Buffer from: 'abc'.
	abd := Buffer from: 'abd'.
	self assert: [ abc equals: ( Buffer from: 'abc' ) ].
	self assert: [ ( abc equals: abd ) not ].
	self assert: [ abc = ( Buffer from: 'abc' ) ].

	self assert: [ ( abc compare: abd ) = -1 ].
	self assert: [ ( abd compare: abc ) = 1 ].
	self assert: [ ( abc compare: ( Buffer from: 'abc' ) ) = 0 ].
	self assert: [ ( abc compare: abd targetStart: 0 targetEnd: 2 sourceStart: 0 sourceEnd: 2 ) = 0 ].

	self assert: [ ( Buffer compare: abc with: abd ) = -1 ].
	self assert: [ ( Buffer compare: abd with: abc ) = 1 ].
!
testSearching
	| buffer |

	buffer := Buffer from: 'abcabc'.
	self assert: [ ( buffer indexOf: 98 ) = 1 ].
	self assert: [ ( buffer indexOf: 'bc' ) = 1 ].
	self assert: [ ( buffer indexOf: 'bc' offset: 2 ) = 4 ].
	self assert: [ ( buffer indexOf: '6263' offset: 2 encoding: 'hex' ) = 4 ].
	self assert: [ ( buffer indexOf: ( Buffer from: 'ca' ) ) = 2 ].
	self assert: [ ( buffer lastIndexOf: 'bc' ) = 4 ].
	self assert: [ ( buffer lastIndexOf: 'bc' offset: 3 ) = 1 ].
	self assert: [ ( buffer lastIndexOf: '6263' offset: 3 encoding: 'hex' ) = 1 ].
	self assert: [ buffer includes: 'ca' ].
	self assert: [ ( buffer includes: 'ab' offset: 4 ) not ].
	self assert: [ buffer includes: '6263' offset: 4 encoding: 'hex' ].
!
testModifying
	| buffer |

	buffer := Buffer new: 4.
	buffer fill: 'ab'.
	self assert: [ buffer toString = 'abab' ].
	buffer fill: 120.
	self assert: [ buffer toString = 'xxxx' ].
	buffer fill: '6162' encoding: 'hex'.
	self assert: [ buffer toString = 'abab' ].
	buffer fill: '7a' start: 1 end: 3 encoding: 'hex'.
	self assert: [ buffer toString = 'azzb' ].

	buffer := Buffer new: 6 fill: '-'.
	self assert: [ ( buffer write: 'ab' ) = 2 ].
	self assert: [ buffer toString = 'ab----' ].
	self assert: [ ( buffer write: '6364' encoding: 'hex' ) = 2 ].
	self assert: [ buffer toString = 'cd----' ].
	self assert: [ ( buffer write: 'xy' offset: 4 ) = 2 ].
	self assert: [ buffer toString = 'cd--xy' ].
	self assert: [ ( buffer write: 'pqr' offset: 1 length: 2 ) = 2 ].
	self assert: [ buffer toString = 'cpq-xy' ].
	self assert: [ ( buffer write: '6566' offset: 2 length: 1 encoding: 'hex' ) = 1 ].
	self assert: [ buffer toString = 'cpe-xy' ].

	buffer := Buffer from: '6162636465666768' encoding: 'hex'.
	buffer swap16.
	self assert: [ buffer toString = 'badcfehg' ].
	buffer swap16; swap32.
	self assert: [ buffer toString = 'dcbahgfe' ].
	buffer swap32; swap64.
	self assert: [ buffer toString = 'hgfedcba' ].
!
testIntegers
	| buffer |

	buffer := Buffer new: 8.
	self assert: [ ( buffer writeInt8: -2 offset: 0 ) = 1 ].
	self assert: [ ( buffer readInt8: 0 ) = -2 ].
	self assert: [ ( buffer writeUInt8: 254 offset: 1 ) = 2 ].
	self assert: [ ( buffer readUInt8: 1 ) = 254 ].

	self assert: [ ( buffer writeInt16BE: -300 offset: 0 ) = 2 ].
	self assert: [ ( buffer readInt16BE: 0 ) = -300 ].
	self assert: [ ( buffer writeInt16LE: -300 offset: 0 ) = 2 ].
	self assert: [ ( buffer readInt16LE: 0 ) = -300 ].
	self assert: [ ( buffer writeUInt16BE: 258 offset: 0 ) = 2 ].
	self assert: [ ( buffer readUInt16BE: 0 ) = 258 ].
	self assert: [ ( buffer readUInt16LE: 0 ) = 513 ].
	self assert: [ ( buffer writeUInt16LE: 258 offset: 0 ) = 2 ].
	self assert: [ ( buffer readUInt16LE: 0 ) = 258 ].

	self assert: [ ( buffer writeInt32BE: -70000 offset: 4 ) = 8 ].
	self assert: [ ( buffer readInt32BE: 4 ) = -70000 ].
	self assert: [ ( buffer writeInt32LE: -70000 offset: 4 ) = 8 ].
	self assert: [ ( buffer readInt32LE: 4 ) = -70000 ].
	self assert: [ ( buffer writeUInt32BE: 4000000000 offset: 4 ) = 8 ].
	self assert: [ ( buffer readUInt32BE: 4 ) = 4000000000 ].
	self assert: [ ( buffer writeUInt32LE: 4000000000 offset: 4 ) = 8 ].
	self assert: [ ( buffer readUInt32LE: 4 ) = 4000000000 ].

	self assert: [ ( buffer writeIntBE: -100000 offset: 0 byteLength: 3 ) = 3 ].
	self assert: [ ( buffer readIntBE: 0 byteLength: 3 ) = -100000 ].
	self assert: [ ( buffer writeIntLE: -100000 offset: 0 byteLength: 3 ) = 3 ].
	self assert: [ ( buffer readIntLE: 0 byteLength: 3 ) = -100000 ].
	self assert: [ ( buffer writeUIntBE: 1000000 offset: 0 byteLength: 3 ) = 3 ].
	self assert: [ ( buffer readUIntBE: 0 byteLength: 3 ) = 1000000 ].
	self assert: [ ( buffer writeUIntLE: 1000000 offset: 0 byteLength: 3 ) = 3 ].
	self assert: [ ( buffer readUIntLE: 0 byteLength: 3 ) = 1000000 ].
!
testBigInts
	| buffer |

	buffer := Buffer new: 8.
	self assert: [ ( buffer writeBigInt64BE: -5 toBigInt offset: 0 ) = 8 ].
	self assert: [ ( buffer readBigInt64BE: 0 ) class = BigInt ].
	self assert: [ ( buffer readBigInt64BE: 0 ) = -5 toBigInt ].
	self assert: [ ( buffer writeBigInt64LE: -5 offset: 0 ) = 8 ].
	self assert: [ ( buffer readBigInt64LE: 0 ) = -5 toBigInt ].
	self assert: [ ( buffer writeBigUInt64BE: 9007199254740993 offset: 0 ) = 8 ].
	self assert: [ ( buffer readBigUInt64BE: 0 ) = 9007199254740993 ].
	self assert: [ ( buffer writeBigUInt64LE: 7 offset: 0 ) = 8 ].
	self assert: [ ( buffer readBigUInt64LE: 0 ) = 7 toBigInt ].
!
testFloats
	| buffer |

	buffer := Buffer new: 8.
	self assert: [ ( buffer writeFloatBE: 1.5 offset: 0 ) = 4 ].
	self assert: [ ( buffer readFloatBE: 0 ) = 1.5 ].
	self assert: [ ( buffer writeFloatLE: -2.25 offset: 4 ) = 8 ].
	self assert: [ ( buffer readFloatLE: 4 ) = -2.25 ].
	self assert: [ ( buffer writeDoubleBE: 0.1 offset: 0 ) = 8 ].
	self assert: [ ( buffer readDoubleBE: 0 ) = 0.1 ].
	self assert: [ ( buffer writeDoubleLE: 0.1 offset: 0 ) = 8 ].
	self assert: [ ( buffer readDoubleLE: 0 ) = 0.1 ].
!
