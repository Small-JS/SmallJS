CLASS Fs EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as fs$ from 'fs';'"
INLINE 'const fs$ = await import( "fs" );'

CLASSMETHODS

"TODO: Add rest of FS interface. Add tests."

readFileSync: path
	^ String fromJs: INLINE 'fs$.readFileSync( path.js ).toString()'.
!
existsSync: path
	^ Boolean fromJs: INLINE 'fs$.existsSync( path.js )'.
!
