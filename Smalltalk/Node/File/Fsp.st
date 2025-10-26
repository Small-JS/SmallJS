CLASS Fsp EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

"This class implements the Node.js *promises* based filesystem API."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as fs$ from 'fs';'"
INLINE 'const fsp$ = await import( "node:fs/promises" );'

CLASSMETHODS

"Opening"

async open: path flags: flags
	^ INLINE 'stFileHandle$class.$fromJs$(
		await fsp$.open( path.js, flags.js ) )'.
!
async open: path flags: flags mode: mode
	^ INLINE 'stFileHandle$class.$fromJs$(
		await fsp$.open( path.js, flags.js, mode.js ) )'.
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
	^ INLINE 'stFileStats$class.$fromJs$(
		await fsp$.stat( path.js, ( options.js ? options.js : undefined ) ) )'.
!

"Reading"

async readFile: path options: options
	INLINE '
		let jsResult = await fsp$.readFile( path.js, options.js );
		return typeof jsResult === "string" ?
			stString$class.$fromJs$( jsResult ) :
			stBuffer$class.$fromJs$( jsResult )'.
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

"Directories"

async opendir: path options: options
	^ INLINE 'stDir$class.$fromJs$(
		await fsp$.opendir( path.js, options.js ) )'.
!
async readdir: path options: options
	^ INLINE 'stArray$class.$fromJsStrings$(
		await fsp$.readdir( path.js, options.js ) )'.
!
async glob: pattern options: options iterate: iterateBlock
	INLINE '
		let asyncIterator = fsp$.glob( pattern.js, ( options.js ? options.js : undefined ) );
  		for await ( const fileName of asyncIterator ) {
			iterateBlock.$value$( stString$class.$fromJs$( fileName ) ) }'.
!
async mkdir: path options: options
	INLINE 'await fsp$.mkdir( path.js, options.js )'.
!
async mkdtemp: prefix
	^ INLINE 'stString$class.$fromJs$(
		await fsp$.mkdtemp( prefix.js ) )'.
!
async mkdtempDisposable: prefix options: options
	^ INLINE 'stString$class.$fromJs$(
		await fsp$.mkdtempDisposable( prefix.js, options.js ) )'.
!
async rmdir: path options: options
	INLINE 'await fsp$.rmdir( path.js, ( options.js ? options.js : undefined ) )'.
!

"TODO:
Implement symbolic link operations:
	fsPromises.lchmod(path, mode)
	fsPromises.lchown(path, uid, gid)
	fsPromises.lutimes(path, atime, mtime)
	fsPromises.link(existingPath, newPath)
	fsPromises.lstat(path[, options])
	fsPromises.readlink(path[, options])
	fsPromises.symlink(target, path[, type])

And also:
	fsPromises.statfs(path[, options])
	fsPromises.watch(filename[, options])
"

