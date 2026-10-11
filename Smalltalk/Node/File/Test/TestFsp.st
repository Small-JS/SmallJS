CLASS TestFsp EXTENDS Test MODULE TestNode CLASSVARS ''
	VARS 'tempDirName subDirName tempFilePath'

"Also tests classes Dir, Dirent in async mode."

async test
	await self makeTemp.
	await self openClose.
	await self writeRead.
	await self renameCopyRemove.
	await self properties.
	await self directories.
	await self links.
	await self statfs.
	await self watch.
	await self tempDisposable.
	await self remove.
!
async makeTemp
	| prefix dirName options |

	"Create temp directory"
	prefix := Path join: Os tmpDir with: 'smalljs-tfsp-'.
	tempDirName := await Fsp mkdtemp: prefix.
	self assert: [ tempDirName includes: 'smalljs-' ].
	self assert: [ Fs existsSync: tempDirName ].

	"Create subdirectories"
	subDirName := Path join: tempDirName with: 'sub1/sub2'.
	options := FileMkdirOptions new recursive: true.
	await Fsp mkdir: subDirName options: options.
	self assert: [ Fs existsSync: subDirName ].
!
async openClose
	| fileHandle mode |
	tempFilePath := Path join: tempDirName with: 'tempfile.tmp'.
	fileHandle := await Fsp open: tempFilePath flags: 'w+' mode: 384.
	self assert: [ fileHandle fd >= 0 ].
	await fileHandle close.

	mode := FileConstants fileOk.
	await Fsp access: tempFilePath mode: mode.
!
async writeRead
	| buffer stats |
	buffer := Buffer from: 'abcd'.
	await Fsp writeFile: tempFilePath data: buffer options: nil.

	buffer := Buffer from: '12'.
	await Fsp appendFile: tempFilePath data: buffer options: nil.

	buffer := await Fsp readFile: tempFilePath options: nil.
	self assert: [ buffer toString = 'abcd12' ].

	await Fsp truncate: tempFilePath length: 2.
	stats := await Fsp stat: tempFilePath options: nil.
	self assert: [ stats size = 2 ].
!
async renameCopyRemove
	| tempFilePath2 |
	tempFilePath2 := Path join: tempDirName with: 'tempfile2.tmp'.
	await Fsp rename: tempFilePath to: tempFilePath2.
	self assert: [ ( Fs existsSync: tempFilePath ) not ].
	self assert: [ Fs existsSync: tempFilePath2 ].

	await Fsp copyFile: tempFilePath2 to: tempFilePath mode: nil.
	self assert: [ Fs existsSync: tempFilePath ].

	await Fsp unlink: tempFilePath.
	self assert: [ ( Fs existsSync: tempFilePath ) not ].

	await Fsp cp: tempFilePath2 to: tempFilePath options: nil.
	self assert: [ Fs existsSync: tempFilePath ].

	await Fsp unlink: tempFilePath2.
	self assert: [ ( Fs existsSync: tempFilePath2 ) not ].
!
async properties
	| stats |
	await Fsp utimes: tempFilePath atime: 2 mtime: 1.
	stats := await Fsp stat: tempFilePath options: nil.
	self assert: [ stats atimeMs = 2000 ].
	self assert: [ stats mtimeMs = 1000 ].

	"chmod and chown do nothing on Windows,
	 so don't actually change them and can't check for results."
	await Fsp chmod: tempFilePath mode: stats mode.
	await Fsp chown: tempFilePath uid: stats uid gid: stats gid.
!
async directories
	| fileNames pattern dir dirent |

	"Glob"

	fileNames := #().
	pattern := Path join: tempDirName with: '**/**'.
	await Fsp glob: pattern options: nil
		iterate: [ :fileName | fileNames add: fileName  ].
	self assert: [ fileNames length = 4 ].
	self assert: [ fileNames includes: tempDirName ].

	"Directory sync"


	"Directory async"
	fileNames := await Fsp readdir: tempDirName options: nil.
	self assert: [ fileNames length = 2 ].
	self assert: [ fileNames includes: 'sub1' ].

	fileNames := #().
	dir := await Fsp opendir: tempDirName options: nil.
	await dir read: [ :dirent |
		fileNames add: dirent name.
		self checkDirent: dirent ].
	self assert: [ fileNames length = 2 ].

	await dir close.
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
async links
	| linkPath junctionPath stats target |

	"Hard link"
	linkPath := Path join: tempDirName with: 'hardlink.tmp'.
	await Fsp link: tempFilePath to: linkPath.
	stats := await Fsp stat: tempFilePath options: nil.
	self assert: [ stats nlink = 2 ].
	self assert: [ stats isFile ].
	await Fsp unlink: linkPath.
	stats := await Fsp stat: tempFilePath options: nil.
	self assert: [ stats nlink = 1 ].

	"Symbolic link. Type junction doesn't need extra privileges on Windows,
	 and is ignored on other platforms."
	junctionPath := Path join: tempDirName with: 'junction'.
	await Fsp symlink: subDirName path: junctionPath type: 'junction'.
	stats := await Fsp lstat: junctionPath options: nil.
	self assert: [ stats isSymbolicLink ].
	self assert: [ stats isDirectory not ].
	stats := await Fsp stat: junctionPath options: nil.
	self assert: [ stats isSymbolicLink not ].
	self assert: [ stats isDirectory ].
	target := await Fsp readlink: junctionPath options: nil.
	self assert: [ target includes: 'sub2' ].

	await Fsp lutimes: junctionPath atime: 2 mtime: 1.
	stats := await Fsp lstat: junctionPath options: nil.
	self assert: [ stats mtimeMs = 1000 ].
	"lchown does nothing on Windows."
	await Fsp lchown: junctionPath uid: stats uid gid: stats gid.
	await self lchmod: junctionPath mode: stats mode.

	await Fsp unlink: junctionPath.
	self assert: [ ( Fs existsSync: junctionPath ) not ].
	self assert: [ Fs existsSync: subDirName ].
!
async lchmod: path mode: mode
	"lchmod is only implemented on macOS."
	Os isMacos ifFalse: [ ^ nil ].
	await Fsp lchmod: path mode: mode.
!
async statfs
	| stats |
	stats := await Fsp statfs: tempDirName options: nil.
	self assert: [ stats class = FileStatFs ].
	self assert: [ stats type >= 0 ].
	self assert: [ stats bsize > 0 ].
	self assert: [ stats frsize > 0 ].
	self assert: [ stats blocks > 0 ].
	self assert: [ stats bfree <= stats blocks ].
	self assert: [ stats bavail <= stats blocks ].
	self assert: [ stats files >= 0 ].
	self assert: [ stats ffree >= 0 ].
!
async watch
	| controller options fileNames watching filePath |
	controller := AbortController new.
	options := FileWatchOptions new.
	options signal: controller signal.
	fileNames := #().
	watching := Fsp watch: tempDirName options: options iterate: [ :eventType :fileName |
		self assert: [ #( 'rename' 'change' ) includes: eventType ].
		fileNames add: fileName.
		controller abort ].
	"Stop watching after a while, also if no events arrive."
	Timer timeout: 5000 then: [ controller abort ].

	"Give the watcher time to start."
	await Timer timeout: 100.
	filePath := Path join: tempDirName with: 'watched.tmp'.
	await Fsp writeFile: filePath data: 'Watched' options: nil.
	await watching.
	self assert: [ fileNames includes: 'watched.tmp' ].
	await Fsp unlink: filePath.
!
async tempDisposable
	| tempDir |
	tempDir := await Fsp mkdtempDisposable: ( Path join: Os tmpDir with: 'smalljs-tfspd-' ) options: nil.
	self assert: [ tempDir class = DisposableTempDir ].
	self assert: [ tempDir path includes: 'smalljs-tfspd-' ].
	self assert: [ Fs existsSync: tempDir path ].
	await Fsp writeFile: ( Path join: tempDir path with: 'file.tmp' ) data: 'Data' options: nil.
	await tempDir remove.
	self assert: [ ( Fs existsSync: tempDir path ) not ].
!
async remove
	| options |

	await Fsp unlink: tempFilePath.
	self assert: [ ( Fs existsSync: tempFilePath ) not ].

	await Fsp rmdir: subDirName options: nil.
	self assert: [ ( Fs existsSync: subDirName ) not ].

	options := FileRmOptions new recursive: true.
	await Fsp rm: tempDirName options: options.
	self assert: [ ( Fs existsSync: tempDirName ) not ].
!
