CLASS TestFileHandle EXTENDS Test MODULE TestNode CLASSVARS '' VARS 'fileHandle'

"Also tests class: Stats"

test
	self assertError: [ FileHandle new ].
	FileHandle open: 'FileHandle.tmp' flags: 'w+'
		then: [ :aFileHandle | self onOpen: aFileHandle ]
		error: [ :error | error throw ].
!
onOpen: aFileHandle
	fileHandle := aFileHandle.
	self assert: [ fileHandle class = FileHandle ].
	self assert: [ fileHandle jsClassName = 'FileHandle' ].
	self assert: [ fileHandle fd >= 0 ].

	fileHandle statThen: [ :stats | self onStat: stats ]
		error: [ :error | error throw ].
!
onStat: stats
	| now |

	self assert: [ stats dev >= 1 ].
	self assert: [ stats ino >= 1 ].
	self assert: [ stats mode >= 1 ].
	self assert: [ stats nlink = 1 ].
	self assert: [ stats uid >= 0 ].
	self assert: [ stats gid >= 0 ].
	self assert: [ stats size = 0 ].
	self assert: [ stats blksize >= 512 ].

	now := Date now.
	self assert: [ now - stats ctime toMilliseconds < 5000 ].
	self assert: [ stats mtime = stats ctime ].
	self assert: [ stats atime = stats mtime ].
	self assert: [ stats birthtime toMilliseconds > 1756000000000 ].

	self assert: [ now - stats ctimeMs < 5000 ].
	self assert: [ stats mtimeMs = stats ctimeMs ].
	self assert: [ stats atimeMs = stats mtimeMs ].
	self assert: [ stats birthtimeMs > 1756000000000 ].

	self writeBuffer.
!
writeBuffer
	| writeBuffer |

	writeBuffer := Buffer new: 8.
	0 to: 7 do: [ :index |
		writeBuffer at: index put: 97 + index ].

	fileHandle write: writeBuffer offset: 2 length: 4 position: nil
		then: [ :bytesWritten :buffer | self onWriteBuffer: bytesWritten buffer: buffer ]
		error: [ :error | error throw ].
!
onWriteBuffer: bytesWritten buffer: writeBuffer
	| readBuffer |

	self assert: [ bytesWritten = 4 ].
	self assert: [ writeBuffer length = 8 ].

	readBuffer := Buffer new: 8.
	fileHandle read: readBuffer offset: 2 length: 4 position: 0
		then: [ :bytesRead :buffer | self onReadBuffer: bytesRead buffer: buffer ]
		error: [ :error | error throw ].
!
onReadBuffer: bytesRead buffer: readBuffer
	self assert: [ bytesRead = 4 ].
	self assert: [ readBuffer length = 8 ].
	self assert: [ ( readBuffer subarray: 2 to: 6 ) toArray = #( 99 100 101 102 ) ].

	"Must reopen file to test writeFile."
	fileHandle closeThen: [ self close2 ]
		error: [ :error | error throw ].
!
close2
	FileHandle open: 'FileHandle.tmp' flags: 'w+'
		then: [ :aFileHandle | self onOpen2: aFileHandle ]
		error: [ :error | error throw ].
!
onOpen2: aFileHandle
	| buffer |
	fileHandle := aFileHandle.
	buffer := Buffer from: 'abcd'.
	fileHandle writeFile: buffer
		then: [ self onWriteFile ]
		error: [ :error | error throw ].
!
onWriteFile
	"Must reopen file to test readFile."
	fileHandle closeThen: [ self close3 ]
		error: [ :error | error throw ].
!
close3
	FileHandle open: 'FileHandle.tmp' flags: 'r+'
		then: [ :aFileHandle | self onOpen3: aFileHandle ]
		error: [ :error | error throw ].
!
onOpen3: aFileHandle
	fileHandle := aFileHandle.
	fileHandle readFileThen: [ :buffer | self onReadFile: buffer ]
		error: [ :error | error throw ].
!
onReadFile: buffer
	self assert: [ buffer toString = 'abcd' ].

	fileHandle truncate: 2
		then: [ self onTruncate ]
		error: [ :error | error throw ].
!
onTruncate
	fileHandle statThen: [ :stats | self onStat2: stats ]
		error: [ :error | error throw ].
!
onStat2: stats
	| mode |
	self assert: [ stats size = 2 ].
	self assert: [ stats mode = 33206 ].

	fileHandle chmod: 33200
		then: [ self onChmod ]
		error: [ :error | error throw ].
!
onChmod
	fileHandle statThen: [ :stats | self onStat3: stats ]
		error: [ :error | error throw ].
!
onStat3: stats
	"On Windows chmod does work and stays 33206."

	self assert: [ #( 33200 33206 ) includes: stats mode ].

	fileHandle atime: 1 mtime: 2
		then: [ self onAmTimes ]
		error: [ :error | error throw ].
!
onAmTimes
	fileHandle statThen: [ :stats | self onStat4: stats ]
		error: [ :error | error throw ].
!
onStat4: stats
	self assert: [ stats atimeMs = 1000 ].
	self assert: [ stats mtimeMs = 2000 ].

	"Don't actually change the user and group,
	 just set the currrent uid and gid and see if the call executes."
	fileHandle chown: stats uid gid: stats gid
		then: [ self onChown ]
		error: [ :error | error throw ].
!
onChown
	fileHandle statThen: [ :stats | self onStat5: stats ]
		error: [ :error | error throw ].
!
onStat5: stats
	self assert: [ stats uid >= 0 ].
	self assert: [ stats gid >= 0 ].

	fileHandle syncThen: [ self onSync ]
		error: [ :error | error throw ].
!
onSync
	self assert: [ true ].
	fileHandle datasyncThen: [ self onDatasync ]
		error: [ :error | error throw ].
!
onDatasync
	self assert: [ true ].

	self close.
!
close
	fileHandle closeThen: [ self onClose ]
		error: [ :error | error throw ].
!
onClose
	self assert: [ true ].
!

