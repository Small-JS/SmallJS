CLASS TestFileHandle EXTENDS Test MODULE TestNode CLASSVARS '' VARS 'fileName fileHandle'

"Also tests class: FileStats"

async test
	await self open.
	await self stat.
	await self writeRead.
	await self properties.
	await self closeRemove.
!
async open
	fileName := Os tmpPath: 'smalljs-tfh-'.
	fileHandle := await FileHandle open: fileName flags: 'w+'.
	self assert: [ fileHandle class = FileHandle ].
	self assert: [ fileHandle jsClassName = 'FileHandle' ].
	self assert: [ fileHandle fd >= 0 ].
!
async stat
	| stats now |

	stats := await fileHandle stat.
	self assert: [ stats dev >= 1 ].
	self assert: [ stats ino >= 1 ].
	self assert: [ #( 33188 33204 33206 ) includes: stats mode ].
	self assert: [ stats nlink = 1 ].
	self assert: [ stats uid >= 0 ].
	self assert: [ stats gid >= 0 ].
	self assert: [ stats size = 0 ].
	self assert: [ stats blksize >= 512 ].

	now := Date now.
	self assert: [ ( now - stats ctime toMilliseconds ) abs < 300000 ].
	self assert: [ ( now - stats mtime toMilliseconds ) abs < 300000].
	self assert: [ ( now - stats atime toMilliseconds ) abs < 300000 ].

	self assert: [ ( now - stats ctimeMs ) abs < 300000 ].
	self assert: [ ( now - stats mtimeMs ) abs < 300000 ].
	self assert: [ ( now - stats atimeMs ) abs < 300000 ].
!
async writeRead
	| writeBuffer bytesWritten readBuffer bytesRead buffer stats |
	writeBuffer := Buffer new: 8.
	0 to: 7 do: [ :index |
		writeBuffer at: index put: 97 + index ].

	bytesWritten := await fileHandle write: writeBuffer offset: 2 length: 4 position: nil.
	self assert: [ bytesWritten = 4 ].

	readBuffer := Buffer new: 8.
	bytesRead := await fileHandle read: readBuffer offset: 2 length: 4 position: 0.
	self assert: [ bytesRead = 4 ].
	self assert: [ readBuffer length = 8 ].
	self assert: [ ( readBuffer subarray: 2 to: 6 ) toArray = #( 99 100 101 102 ) ].

	"Must reopen file to test writeFile."
	await fileHandle close.
	fileHandle := await FileHandle open: fileName flags: 'w+'.
	buffer := Buffer from: 'abcd'.
	await fileHandle writeFile: buffer.

	"Must reopen file to test readFile."
	await fileHandle close.
	fileHandle := await FileHandle open: fileName flags: 'r+'.
	buffer := await fileHandle readFile.
	self assert: [ buffer toString = 'abcd' ].

	await fileHandle truncate: 2.
	stats := await fileHandle stat.
	self assert: [ stats size = 2 ].

	await fileHandle sync.
	await fileHandle datasync.
!
async properties
	| stats |
	await fileHandle chmod: 33200.
	stats := await fileHandle stat.
	"On Windows chmod does work and stays 33206."
	self assert: [ #( 33200 33206 ) includes: stats mode ].

	"Don't actually change the user and group because we probably don't have permission.
	 Just set the currrent uid and gid and see if the call executes."
	await fileHandle chown: stats uid gid: stats gid.
	stats := await fileHandle stat.
	self assert: [ stats uid >= 0 ].
	self assert: [ stats gid >= 0 ].

	await fileHandle atime: 1 mtime: 2.
	stats := await fileHandle stat.
	self assert: [ stats atimeMs = 1000 ].
	self assert: [ stats mtimeMs = 2000 ].
!
async closeRemove
	await fileHandle close.
	Fs unlinkSync: fileName.
!
