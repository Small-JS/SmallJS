CLASS TestFs EXTENDS Test MODULE TestNode CLASSVARS ''
	VARS 'tempDirName subDirName tempFilePath tempFileFd'

"Also tests classes Dir, Dirent in sync mode."

test
	| prefix options mode |

	"Create temp directory"
	prefix := Path join: Os tmpDir with: 'smalljs-'.
	tempDirName := Fs mkdtempSync: prefix options: nil.
	self assert: [ tempDirName includes: 'smalljs-' ].
	self assert: [ Fs existsSync: tempDirName ].

	"Create subdirectory"
	subDirName := Path join: tempDirName with: 'sub1/sub2'.
	options := FileMkdirOptions new recursive: true.
	Fs mkdirSync: subDirName options: options.
	self assert: [ Fs existsSync: subDirName ].

	"Create file"
	tempFilePath := Path join: tempDirName with: 'tempfile.tmp'.
	tempFileFd := Fs openSync: tempFilePath flags: 'w+' mode: 384.
	self assert: [ tempFileFd >= 0 ].
	Fs closeSync: tempFileFd.

	mode := FileConstants fileOk.
	Fs accessSync: tempFilePath mode: mode.

	self writeReadFile.
!
writeReadFile
	| writeBuffer readBuffer |

	writeBuffer := Buffer from: 'abcd'.
	Fs writeFileSync: tempFilePath data: writeBuffer options: nil.

	writeBuffer := Buffer from: '12'.
	Fs appendFileSync: tempFilePath data: writeBuffer options: nil.

	readBuffer := Fs readFileSync: tempFilePath.
	self assert: [ readBuffer toString = 'abcd12' ].

	self writeReadBuffer.
!
writeReadBuffer
	| writeBuffer readBuffer bytesRead |

	tempFileFd := Fs openSync: tempFilePath flags: 'w+' mode: nil.
	writeBuffer := Buffer from: 'efgh'.
	Fs writeSync: tempFileFd buffer: writeBuffer options: nil.
	Fs closeSync: tempFileFd.

	tempFileFd := Fs openSync: tempFilePath flags: 'r+' mode: nil.
	readBuffer := Buffer new: 8.
	bytesRead := Fs readSync: tempFileFd buffer: readBuffer options: nil.
	self assert: [ bytesRead = 4 ].
	self assert: [ ( readBuffer subarray: 0 to: 4 ) toString = 'efgh' ].
	Fs closeSync: tempFileFd.

	self writeReadBufferPositioned.
!
writeReadBufferPositioned
	| writeBuffer readBuffer bytesRead |

	tempFileFd := Fs openSync: tempFilePath flags: 'w+' mode: nil.
	writeBuffer := Buffer from: 'ijklmn'.
	Fs writeSync: tempFileFd buffer: writeBuffer offset: 1 length: 4 position: nil.
	Fs closeSync: tempFileFd.

	tempFileFd := Fs openSync: tempFilePath flags: 'r+' mode: nil.
	readBuffer := Buffer new: 8.
	bytesRead := Fs readSync: tempFileFd buffer: readBuffer offset: 2 length: 2 position: 1.
	self assert: [ bytesRead = 2 ].
	self assert: [ ( readBuffer subarray: 2 to: 4 ) toString = 'kl' ].
	Fs closeSync: tempFileFd.

	self renameCopy.
!
renameCopy
	| tempFilePath2 |
	tempFilePath2 := Path join: tempDirName with: 'tempfile2.tmp'.

	Fs renameSync: tempFilePath to: tempFilePath2.
	self assert: [ ( Fs existsSync: tempFilePath ) not ].
	self assert: [ Fs existsSync: tempFilePath2 ].

	Fs copyFileSync: tempFilePath2 to: tempFilePath mode: nil.
	self assert: [ Fs existsSync: tempFilePath ].

	Fs unlinkSync: tempFilePath.
	Fs cpSync: tempFilePath2 to: tempFilePath options: nil.
	self assert: [ Fs existsSync: tempFilePath ].
	Fs unlinkSync: tempFilePath2.

	self accessPath.
!
accessPath
	| stats |

	Fs utimesSync: tempFilePath atime: 2 mtime: 1.
	stats := Fs statSync: tempFilePath options: nil.
	self assert: [ stats atimeMs = 2000 ].
	self assert: [ stats mtimeMs = 1000 ].

	"chmod and chown to nothing on Windows,
	 so don't actually change them and can't check results."
	Fs chmodSync: tempFilePath mode: stats mode.
	Fs chownSync: tempFilePath uid: stats uid gid: stats gid.

	self accessFd
!
accessFd
	| stats |

	tempFileFd := Fs openSync: tempFilePath flags: 'r+' mode: nil.
	Fs futimesSync: tempFileFd atime: 4 mtime: 3.
	stats := Fs fstatSync: tempFileFd options: nil.
	self assert: [ stats atimeMs = 4000 ].
	self assert: [ stats mtimeMs = 3000 ].

	"chmod and chown do nothing on Windows,
	 so don't actually change them and can't check results."
	Fs fchmodSync: tempFileFd mode: stats mode.
	Fs fchownSync: tempFileFd uid: stats uid gid: stats gid.
	Fs closeSync: tempFileFd.

	self truncate.
!
truncate
	| stats |
	Fs truncateSync: tempFilePath length: 2.
	stats := Fs statSync: tempFilePath options: nil.
	self assert: [ stats size = 2 ].

	tempFileFd := Fs openSync: tempFilePath flags: 'r+' mode: nil.
	Fs ftruncateSync: tempFileFd length: 0.
	stats := Fs fstatSync: tempFileFd options: nil.
	self assert: [ stats size = 0 ].

	Fs fsyncSync: tempFileFd.
	Fs fdatasyncSync: tempFileFd.

	self directory.
!
directory
	| pattern fileNames dir dirent |
	pattern := Path join: tempDirName with: '**/**'.
	fileNames := Fs globSync: pattern options: nil.
	self assert: [ fileNames length = 4 ].
	self assert: [ fileNames includes: tempDirName ].

	fileNames := Fs readdirSync: tempDirName options: nil.
	self assert: [ fileNames length = 2 ].
	self assert: [ fileNames includes: 'sub1' ].

	dir := Fs opendirSync: tempDirName options: nil.
	fileNames := #().
	[ ( dirent := dir readSync ) notNil ] whileTrue: [
		self dirent: dirent.
		fileNames add: dirent name ].
	self assert: [ fileNames length = 2 ].
	dir closeSync.

	self end.
!
dirent: dirent
	self assert: [ dirent parentPath = tempDirName ].

	#( 'sub1' 'tempfile.tmp' ) includes: dirent name.
	dirent name = 'tempfile.tmp' ifTrue: [
		self assert: [ dirent isFile ] ].
	dirent name = 'sub1' ifTrue: [
		self assert: [ dirent isDirectory ] ].

	self assert: [ dirent isCharacterDevice not ].
	self assert: [ dirent isBlockDevice not ].
	self assert: [ dirent isCharacterDevice not ].
	self assert: [ dirent isSymbolicLink not ].
	self assert: [ dirent isFifo not ].
	self assert: [ dirent isSocket not ].
!
end
	"Remove everything."
	| options |

	Fs unlinkSync: tempFilePath.
	self assert: [ ( Fs existsSync: tempFilePath ) not ].

	Fs rmdirSync: subDirName.
	self assert: [ ( Fs existsSync: subDirName ) not ].

	options := FileRmOptions new recursive: true.
	Fs rmSync: tempDirName options: options.
	self assert: [ ( Fs existsSync: tempDirName ) not ].
!
