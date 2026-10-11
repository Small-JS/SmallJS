CLASS Fs EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

"This class only implements the *sync* API of the fs module.
 So the callback API is not implemented.
 Use the promises based class Fsp for async."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as fs$ from 'node:fs';'"
INLINE 'const fs$ = await import( "node:fs" );'

CLASSMETHODS

"Opening / closing / deleting"

openSync: path flags: flags mode: mode
	^ Integer fromJs:
		INLINE 'fs$.openSync( path.js, flags.js, mode.js )'.
!
closeSync: fd
	INLINE 'fs$.closeSync( fd.js )'.
!
unlinkSync: path
	INLINE 'fs$.unlinkSync( path.js )'.
!
rmSync: path options: options
	INLINE 'fs$.rmSync( path.js, options.js )'.
!

"Testing"

existsSync: path
	^ Boolean fromJs:
		INLINE 'fs$.existsSync( path.js )'.
!
accessSync: path mode: mode
	INLINE 'fs$.accessSync( path.js, mode.js )'.
!

"Reading"

readFileSync: path
	^ Buffer fromJs:
		INLINE 'fs$.readFileSync( path.js )'.
!
readSync: fd buffer: buffer options: options
	^ Integer fromJs:
		INLINE 'fs$.readSync( fd.js, buffer.js, options.js )'.
!
readvSync: fd buffers: buffers position: position
	"Read into an Array of Buffers sequentially. Return the total number of bytes read.
	 If position is nil, read from the current position."
	^ Integer fromJs:
		INLINE 'fs$.readvSync( fd.js, buffers.$toJs(), position.js )'.
!
readSync: fd buffer: buffer offset: offset length: length position: position
	^ Integer fromJs:
		INLINE 'fs$.readSync( fd.js, buffer.js, offset.js, length.js, position.js )'.
!

"Writing"

writeFileSync: file data: data options: options
	"Argument file can be path or file descriptor."
	^ Buffer fromJs:
		INLINE 'fs$.writeFileSync( file.js, data.js, options.js )'.
!
appendFileSync: path data: data options: options
	INLINE 'fs$.appendFileSync( path.js, data.js, options.js )'.
!
writeSync: fd buffer: buffer options: options
	^ Buffer fromJs:
		INLINE 'fs$.writeSync( fd.js, buffer.js, options.js )'.
!
writevSync: fd buffers: buffers position: position
	"Write an Array of Buffers sequentially. Return the total number of bytes written.
	 If position is nil, write at the current position."
	^ Integer fromJs:
		INLINE 'fs$.writevSync( fd.js, buffers.$toJs(), position.js )'.
!
writeSync: fd buffer: buffer offset: offset length: length position: position
	^ Buffer fromJs:
		INLINE 'fs$.writeSync( fd.js, buffer.js, offset.js, length.js, position.js )'.
!
truncateSync: path length: length
	INLINE 'fs$.truncateSync( path.js, length.js )'.
!
ftruncateSync: fd length: length
	INLINE 'fs$.ftruncateSync( fd.js, length.js )'.
!
fsyncSync: fd
	INLINE 'fs$.fsyncSync( fd.js )'.
!
fdatasyncSync: fd
	INLINE 'fs$.fdatasyncSync( fd.js )'.
!

"Copying / renaming"

copyFileSync: src to: dest mode: mode
	INLINE 'fs$.copyFileSync( src.js, dest.js, mode.js )'.
!
cpSync: src to: dest options: options
	INLINE 'fs$.cpSync( src.js, dest.js, ( options.js ? options.js : undefined ) )'.
!
renameSync: oldPath to: newPath
	INLINE 'fs$.renameSync( oldPath.js, newPath.js )'.
!

"Accessing"

utimesSync: path atime: atime mtime: mtime
	INLINE 'fs$.utimesSync( path.js, atime.js, mtime.js )'.
!
futimesSync: fd atime: atime mtime: mtime
	INLINE 'fs$.futimesSync( fd.js, atime.js, mtime.js )'.
!
chmodSync: path mode: mode
	INLINE 'fs$.chmodSync( path.js, mode.js )'.
!
fchmodSync: fd mode: mode
	INLINE 'fs$.fchmodSync( fd.js, mode.js )'.
!
chownSync: path uid: uid gid: gid
	INLINE 'fs$.chownSync( path.js, uid.js, gid.js )'.
!
fchownSync: fd uid: uid gid: gid
	INLINE 'fs$.fchownSync( fd.js, uid.js, gid.js )'.
!

"Properties"

statSync: path options: options
	^ FileStats fromJs:
		INLINE 'fs$.statSync( path.js, ( options.js ? options.js : undefined ) )'.
!
fstatSync: fd options: options
	^ FileStats fromJs:
		INLINE 'fs$.fstatSync( fd.js, ( options.js ? options.js : undefined ) )'.
!
statfsSync: path options: options
	"Return information about the file system containing path."
	^ FileStatFs fromJs:
		INLINE 'fs$.statfsSync( path.js, ( options.js ? options.js : undefined ) )'.
!
realpathSync: path options: options
	"Return the canonical absolute path, resolving ., .. and symbolic links."
	^ String fromJs:
		INLINE 'fs$.realpathSync( path.js, ( options.js ? options.js : undefined ) )'.
!
realpathNativeSync: path options: options
	"Like realpathSync:options:, but uses the native OS function."
	^ String fromJs:
		INLINE 'fs$.realpathSync.native( path.js, ( options.js ? options.js : undefined ) )'.
!

"Links
 The l* methods operate on a symbolic link itself, instead of on its target."

linkSync: existingPath to: newPath
	"Create a hard link."
	INLINE 'fs$.linkSync( existingPath.js, newPath.js )'.
!
symlinkSync: target path: path
	INLINE 'fs$.symlinkSync( target.js, path.js )'.
!
symlinkSync: target path: path type: type
	"Type is only used on Windows: 'file', 'dir' or 'junction'.
	 Junctions are for directories only, but don't require extra privileges."
	INLINE 'fs$.symlinkSync( target.js, path.js, type.js )'.
!
readlinkSync: path options: options
	"Return the target of the symbolic link."
	^ String fromJs:
		INLINE 'fs$.readlinkSync( path.js, ( options.js ? options.js : undefined ) )'.
!
lstatSync: path options: options
	^ FileStats fromJs:
		INLINE 'fs$.lstatSync( path.js, ( options.js ? options.js : undefined ) )'.
!
lchmodSync: path mode: mode
	"Only implemented on macOS."
	INLINE 'fs$.lchmodSync( path.js, mode.js )'.
!
lchownSync: path uid: uid gid: gid
	INLINE 'fs$.lchownSync( path.js, uid.js, gid.js )'.
!
lutimesSync: path atime: atime mtime: mtime
	INLINE 'fs$.lutimesSync( path.js, atime.js, mtime.js )'.
!

"Directories"

mkdirSync: path options: options
	^ String fromJs:
		INLINE 'fs$.mkdirSync( path.js, options.js )'.
!
mkdtempSync: prefix options: options
	^ String fromJs:
		INLINE 'fs$.mkdtempSync( prefix.js, options.js )'.
!
mkdtempDisposableSync: prefix options: options
	"Like mkdtempSync:options:, but return a DisposableTempDir that can remove itself."
	^ DisposableTempDir fromJs:
		INLINE 'fs$.mkdtempDisposableSync( prefix.js, ( options.js ? options.js : undefined ) )'.
!
opendirSync: path options: options
	^ Dir fromJs:
		INLINE 'fs$.opendirSync( path.js, options.js )'.
!
readdirSync: path options: options
	^ Array fromJsStrings:
		INLINE 'fs$.readdirSync( path.js, options.js )'.
!
globSync: pattern options: options
	^ Array fromJsStrings:
		INLINE 'fs$.globSync( pattern.js, ( options.js ? options.js : undefined ) )'.
!
rmdirSync: path
	INLINE 'fs$.rmdirSync( path.js )'.
!
