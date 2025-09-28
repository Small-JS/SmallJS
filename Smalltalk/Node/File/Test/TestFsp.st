CLASS TestFsp EXTENDS Test MODULE TestNode CLASSVARS ''
	VARS 'tempDirName subDirName tempFilePath tempFilePath2
		tempFileFd'

"Also tests classes Dir, Dirent in async mode."

test
	| prefix |
	prefix := Path join: Os tmpDir with: 'smalljs-'.

	Fsp mkdtemp: prefix
		then: [ :dirName | self onMkdtemp: dirName ]
		error: [ :error | error throw ].
!
onMkdtemp: dirName
	| options |
	tempDirName := dirName.
	self assert: [ tempDirName includes: 'smalljs-' ].
	self assert: [ Fs existsSync: tempDirName ].

	"Create subdirectory"
	subDirName := Path join: tempDirName with: 'sub1/sub2'.
	options := FileMkdirOptions new recursive: true.
	Fsp mkdir: subDirName options: options
		then: [ self onMkdir ]
		error: [ :error | error throw ].
!
onMkdir
	self assert: [ Fs existsSync: subDirName ].

	"Create file"
	tempFilePath := Path join: tempDirName with: 'tempfile.tmp'.
	Fsp open: tempFilePath flags: 'w+' mode: 384
		then: [ :fileHandle | self onOpen: fileHandle ]
		error: [ :error | error throw ].
!
onOpen: fileHandle
	self assert: [ fileHandle fd >= 0 ].
	fileHandle closeThen: [ self onClose ]
		error: [ :error | error throw ].
!
onClose
	| mode |

	mode := FileConstants fileOk.
	Fsp access: tempFilePath mode: mode
		then: [ self onAccess ]
		error: [ :error | error throw ].
!
onAccess
	| buffer |
	buffer := Buffer from: 'abcd'.
	Fsp writeFile: tempFilePath data: buffer options: nil
		then: [ self onWriteFile ]
		error: [ :error | error throw ].
!
onWriteFile
	| buffer |
	buffer := Buffer from: '12'.
	Fsp appendFile: tempFilePath data: buffer options: nil
		then: [ self onAppendFile ]
		error: [ :error | error throw ].
!
onAppendFile
	Fsp readFile: tempFilePath options: nil
		then: [ :buffer | self onReadFile: buffer ]
		error: [ :error | error throw ].
!
onReadFile: buffer
	self assert: [ buffer toString = 'abcd12' ].

	tempFilePath2 := Path join: tempDirName with: 'tempfile2.tmp'.

	Fsp rename: tempFilePath to: tempFilePath2
		then: [ self onRename ]
		error: [ :error | error throw ].
!
onRename
	self assert: [ ( Fs existsSync: tempFilePath ) not ].
	self assert: [ Fs existsSync: tempFilePath2 ].

	Fsp copyFile: tempFilePath2 to: tempFilePath mode: nil
		then: [ self onCopyFile ]
		error: [ :error | error throw ].
!
onCopyFile
	self assert: [ Fs existsSync: tempFilePath ].

	Fsp unlink: tempFilePath
		then: [ self onUnlink ]
		error: [ :error | error throw ].
!
onUnlink
	self assert: [ ( Fs existsSync: tempFilePath ) not ].

	Fsp cp: tempFilePath2 to: tempFilePath options: nil
		then: [ self onCp ]
		error: [ :error | error throw ].
!
onCp
	self assert: [ Fs existsSync: tempFilePath ].

	Fsp unlink: tempFilePath2
		then: [ self onUnlink2 ]
		error: [ :error | error throw ].
!
onUnlink2
	| stats |

	Fsp utimes: tempFilePath atime: 2 mtime: 1
		then: [ self onUtimes ]
		error: [ :error | error throw ].
!
onUtimes
	 Fsp stat: tempFilePath options: nil
		then: [ :stats | self onStat: stats ]
		error: [ :error | error throw ].
!
onStat: stats
	self assert: [ stats atimeMs = 2000 ].
	self assert: [ stats mtimeMs = 1000 ].

	"chmod and chown do nothing on Windows,
	 so don't actually change them and can't check results."
	Fsp chmod: tempFilePath mode: stats mode
		then: [ self onChmod: stats ]
		error: [ :error | error throw ].
!
onChmod: stats
	"chmod and chown do nothing on Windows,
	 so don't actually change them and can't check results."
	Fsp chown: tempFilePath uid: stats uid gid: stats gid
		then: [ self onChown ]
		error: [ :error | error throw ].
!
onChown
	Fsp truncate: tempFilePath length: 2
		then: [ self onTruncate ]
		error: [ :error | error throw ].
!
onTruncate
	 Fsp stat: tempFilePath options: nil
		then: [ :stats | self onStat2: stats ]
		error: [ :error | error throw ].
!
onStat2: stats
	| pattern fileNames |
	self assert: [ stats size = 2 ].

	fileNames := #().
	pattern := Path join: tempDirName with: '**/**'.
	Fsp glob: pattern options: nil
		iterate: [ :fileName | fileNames add: fileName  ]
		then: [ self onGlob: fileNames ]
		error: [ :error | error throw ].
!
onGlob: fileNames
	self assert: [ fileNames length = 4 ].
	self assert: [ fileNames includes: tempDirName ].

	Fsp readdir: tempDirName options: nil
		then: [ :fileNames | self onReaddir: fileNames ]
		error: [ :error | error throw ].
!
onReaddir: fileNames
	self assert: [ fileNames length = 2 ].
	self assert: [ fileNames includes: 'sub1' ].

	Fsp opendir: tempDirName options: nil
		then: [ :dir | self onOpendir: dir fileNames: #() ]
		error: [ :error | error throw ].
!
onOpendir: dir fileNames: fileNames
	dir readThen: [ :dirent | self onDirRead: dir dirent: dirent fileNames: fileNames ]
		error: [ :error | error throw ].
!
onDirRead: dir dirent: dirent fileNames: fileNames
	dirent ifNil: [
		^ self onDirReadDone: dir fileNames: fileNames ].

	self checkDirent: dirent.

	fileNames add: dirent name.
	self onOpendir: dir fileNames: fileNames.
!
checkDirent: dirent
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
onDirReadDone: dir fileNames: fileNames
	self assert: [ fileNames length = 2 ].

	dir closeThen: [ self onDirClose ]
		error: [ :error | error throw ].
!
onDirClose
	Fsp unlink: tempFilePath
		then: [ self onUnlink3 ]
		error: [ :error | error throw ].
!
onUnlink3
	Fsp rmdir: subDirName options: nil
		then: [ self onRmdir ]
		error: [ :error | error throw ].
!
onRmdir
	| options |
	self assert: [ ( Fs existsSync: subDirName ) not ].

	options := FileRmOptions new recursive: true.
	Fsp rm: tempDirName options: options
		then: [ self onRm ]
		error: [ :error | error throw ].
!
onRm
	self assert: [ ( Fs existsSync: tempDirName ) not ].
!
