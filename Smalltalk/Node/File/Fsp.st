CLASS Fsp EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

"This class implements the Node.js *promises* based filesystem API."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as fsp$ from 'node:fs/promises';'"
INLINE 'const fsp$ = await import( "node:fs/promises" );'

CLASSMETHODS

"Opening"

async open: path flags: flags
	^ FileHandle fromJs:
		INLINE 'await fsp$.open( path.js, flags.js )'.
!
async open: path flags: flags mode: mode
	^ FileHandle fromJs:
		INLINE 'await fsp$.open( path.js, flags.js, mode.js )'.
!

"Removing"

async unlink: path
	INLINE 'await fsp$.unlink( path.js )'.
!
async rm: path options: options
	INLINE 'await fsp$.rm( path.js, ( options.js ? options.js : undefined ) )'.
!

"Properties"

async stat: path options: options
	^ FileStats fromJs:
		INLINE 'await fsp$.stat( path.js, ( options.js ? options.js : undefined ) )'.
!
async statfs: path options: options
	"Return information about the file system containing path."
	^ FileStatFs fromJs:
		INLINE 'await fsp$.statfs( path.js, ( options.js ? options.js : undefined ) )'.
!

"Reading"

async readFile: path options: options
	| resultClass |
	resultClass := ( options isNil or: [ options encoding isNil ] ) ifTrue: [ Buffer ] ifFalse: [ String ].
	^ resultClass fromJs:
		INLINE 'await fsp$.readFile( path.js, options.js )'.
!

"Writing"

async appendFile: path data: data options: options
	INLINE 'await fsp$.appendFile( path.js, data.js, options.js )'.
!
async truncate: path length: length
	INLINE 'await fsp$.truncate( path.js, length.js )'.
!
async writeFile: path data: data options: options
	INLINE 'await fsp$.writeFile( path.js, data.js, options.js )'.
!

"Copying"

async copyFile: src to: dest mode: mode
	INLINE 'await fsp$.copyFile( src.js, dest.js, mode.js )'.
!
async cp: src to: dest options: options
	INLINE 'await fsp$.cp( src.js, dest.js, ( options.js ? options.js : undefined ) )'.
!

"Renaming"

async rename: oldPath to: newPath
	INLINE 'await fsp$.rename( oldPath.js, newPath.js )'.
!

"Access"

async access: path mode: mode
	INLINE 'await fsp$.access( path.js, mode.js )'.
!
async chmod: path mode: mode
	INLINE 'await fsp$.chmod( path.js, mode.js )'.
!
async chown: path uid: uid gid: gid
	INLINE 'await fsp$.chown( path.js, uid.js, gid.js )'.
!
async utimes: path atime: atime mtime: mtime
	INLINE 'await fsp$.utimes( path.js, atime.js, mtime.js )'.
!

"Links
 The l* methods operate on a symbolic link itself, instead of on its target."

async link: existingPath to: newPath
	"Create a hard link."
	INLINE 'await fsp$.link( existingPath.js, newPath.js )'.
!
async symlink: target path: path
	INLINE 'await fsp$.symlink( target.js, path.js )'.
!
async symlink: target path: path type: type
	"Type is only used on Windows: 'file', 'dir' or 'junction'.
	 Junctions are for directories only, but don't require extra privileges."
	INLINE 'await fsp$.symlink( target.js, path.js, type.js )'.
!
async readlink: path options: options
	"Return the target of the symbolic link."
	^ String fromJs:
		INLINE 'await fsp$.readlink( path.js, ( options.js ? options.js : undefined ) )'.
!
async lstat: path options: options
	^ FileStats fromJs:
		INLINE 'await fsp$.lstat( path.js, ( options.js ? options.js : undefined ) )'.
!
async lchmod: path mode: mode
	"Only implemented on macOS."
	INLINE 'await fsp$.lchmod( path.js, mode.js )'.
!
async lchown: path uid: uid gid: gid
	INLINE 'await fsp$.lchown( path.js, uid.js, gid.js )'.
!
async lutimes: path atime: atime mtime: mtime
	INLINE 'await fsp$.lutimes( path.js, atime.js, mtime.js )'.
!

"Directories"

async opendir: path options: options
	^ Dir fromJs:
		INLINE 'await fsp$.opendir( path.js, options.js )'.
!
async readdir: path options: options
	"Return an Array of Strings, or of Dirents if options withFileTypes is true."
	^ Array fromJs: INLINE 'await fsp$.readdir( path.js, options.js )'
		elementClass: ( Fs entryClassFor: options ).
!
async glob: pattern options: options iterate: iterateBlock
	"IterateBlock is called with a String, or a Dirent if options withFileTypes is true."
	| entryClass |
	entryClass := Fs entryClassFor: options.
	INLINE '
		let asyncIterator = fsp$.glob( pattern.js, ( options.js ? options.js : undefined ) );
		for await ( const entry of asyncIterator ) {
			iterateBlock.$value$( entryClass.$fromJs$( entry ) ) }'.
!
async mkdir: path options: options
	INLINE 'await fsp$.mkdir( path.js, options.js )'.
!
async mkdtemp: prefix
	^ String fromJs:
		INLINE 'await fsp$.mkdtemp( prefix.js )'.
!
async mkdtempDisposable: prefix options: options
	"Like mkdtemp:, but return a DisposableTempDir that can remove itself."
	^ DisposableTempDir fromJs:
		INLINE 'await fsp$.mkdtempDisposable( prefix.js, ( options.js ? options.js : undefined ) )'.
!
async rmdir: path options: options
	INLINE 'await fsp$.rmdir( path.js, ( options.js ? options.js : undefined ) )'.
!

"Watching"

async watch: fileName options: options iterate: iterateBlock
	"Watch a file or directory for changes, until the options signal is aborted.
	 Options is a FileWatchOptions or nil (watch forever).
	 IterateBlock is called with 2 arguments for each change:
	 the event type ('rename' or 'change') and the file name (can be nil)."
	INLINE '
		try {
			const asyncIterator = fsp$.watch( fileName.js, ( options.js ? options.js : undefined ) );
			for await ( const event of asyncIterator ) {
				iterateBlock.$value$value$(
					stString$class.$fromJs$( event.eventType ),
					( event.filename == null ? stNil$ : stString$class.$fromJs$( event.filename ) ) ) }
		} catch( error ) {
			if( error.name !== "AbortError" ) throw error; }'.
!
