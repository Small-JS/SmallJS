CLASS Path EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as path$ from 'path';'"
INLINE 'const path$ = await import( "node:path" );'

CLASSMETHODS

resolve: path
	^ String fromJs: INLINE 'path$.resolve( path.js )'.
!
join: path with: path2
	^ String fromJs: INLINE 'path$.join( path.js, path2.js )'.
!

"TODO: Add rest of PlatformPath interface. Add tests.
path.basename(path[, suffix])
path.delimiter
path.dirname(path)
path.extname(path)
path.format(pathObject)
path.matchesGlob(path, pattern)
path.isAbsolute(path)
path.join([...paths])
path.normalize(path)
path.parse(path)
path.posix
path.relative(from, to)
path.sep
path.toNamespacedPath(path)
path.win32
"
