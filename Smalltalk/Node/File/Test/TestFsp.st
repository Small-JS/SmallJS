CLASS TestFsp EXTENDS Test MODULE TestNode CLASSVARS ''
	VARS 'tempDirName subDirName tempFilePath'

"Also tests classes Dir, Dirent in async mode."

async test
	await self makeTemp.
	await self openClose.
	await self renameCopyRemove.
	await self properties.
	await self directories.
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
