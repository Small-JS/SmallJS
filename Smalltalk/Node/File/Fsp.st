CLASS Fsp EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

"This class implements the Node.js *promises* based filesystem API."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as fs$ from 'fs';'"
INLINE 'const fsp$ = await import( "node:fs/promises" );'

CLASSMETHODS

"Opening"

open: path flags: flags mode: mode then: block error: errorBlock
	Error. 	"Force reference"
	INLINE 'fsp$.open( path.js, flags.js, mode.js )
		.then( jsFileHandle => block.$value$( stFileHandle$class.$fromJs$( jsFileHandle ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Removing"

unlink: path then: block error: errorBlock
	INLINE 'fsp$.unlink( path.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
rm: path options: options then: block error: errorBlock
	INLINE 'fsp$.rm( path.js, ( options.js ? options.js : undefined ) )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Properties"

stat: path  options: options then: block error: errorBlock
	INLINE 'fsp$.stat( path.js, ( options.js ? options.js : undefined ) )
		.then( ( jsStats ) => block.$value$( stFileStats$class.$fromJs$( jsStats ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Reading"

readFile: path options: options then: block error: errorBlock
	INLINE 'fsp$.readFile( path.js, options.js )
		.then( jsResult => typeof jsResult === "string"
			? block.$value$( stString$class.$fromJs$( jsResult ) )
			: block.$value$( stBuffer$class.$fromJs$( jsResult ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Writing"

appendFile: path data: data options: options then: block error: errorBlock
	INLINE 'fsp$.appendFile( path.js, data.js, options.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
truncate: path length: length then: block error: errorBlock
	INLINE 'fsp$.truncate( path.js, length.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
writeFile: path data: data options: options then: block error: errorBlock
	INLINE 'fsp$.writeFile( path.js, data.js, options.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Copying"

copyFile: src to: dest mode: mode then: block error: errorBlock
	INLINE 'fsp$.copyFile( src.js, dest.js, mode.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
cp: src to: dest options: options then: block error: errorBlock
	INLINE 'fsp$.cp( src.js, dest.js, ( options.js ? options.js : undefined ) )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Renaming"

rename: oldPath to: newPath then: block error: errorBlock
	INLINE 'fsp$.rename( oldPath.js, newPath.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Access"

access: path mode: mode then: block error: errorBlock
	INLINE 'fsp$.access( path.js, mode.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
chmod: path mode: mode then: block error: errorBlock
	INLINE 'fsp$.chmod( path.js, mode.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
chown: path uid: uid gid: gid then: block error: errorBlock
	INLINE 'fsp$.chown( path.js, uid.js, gid.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
utimes: path atime: atime mtime: mtime then: block error: errorBlock
	INLINE 'fsp$.utimes( path.js, atime.js, mtime.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Directories"

opendir: path options: options then: block error: errorBlock
	INLINE 'fsp$.opendir( path.js, options.js )
		.then( jsDir => block.$value$( stDir$class.$fromJs$( jsDir ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
readdir: path options: options then: block error: errorBlock
	INLINE 'fsp$.readdir( path.js, options.js )
		.then( jsFiles => block.$value$( stArray$class.$fromJsStrings$( jsFiles ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
glob: pattern options: options iterate: iterateBlock then: thenBlock error: errorBlock
	INLINE '
		let asyncIterator = fsp$.glob( pattern.js, ( options.js ? options.js : undefined ) );
		( async () => {
  			for await ( const fileName of asyncIterator ) {
				iterateBlock.$value$( stString$class.$fromJs$( fileName ) ) };
			thenBlock.$value() } ) ()'.
!
mkdir: path options: options then: block error: errorBlock
	INLINE 'fsp$.mkdir( path.js, options.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
mkdtemp: prefix then: block error: errorBlock
	INLINE 'fsp$.mkdtemp( prefix.js )
		.then( jsDirectoryName => block.$value$( stString$class.$fromJs$( jsDirectoryName ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
mkdtempDisposable: prefix options: options then: block error: errorBlock
	INLINE 'fsp$.mkdtempDisposable( prefix.js, options.js )
		.then( jsDirectoryName => block.$value$( stString$class.$fromJs$( jsDirectoryName ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
rmdir: path options: options then: block error: errorBlock
	INLINE 'fsp$.rmdir( path.js, ( options.js ? options.js : undefined ) )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
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


