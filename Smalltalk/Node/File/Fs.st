CLASS Fs EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

INLINE 'import * as fs$ from "fs";'

CLASSMETHODS

"TODO: Add rest of FS interface. Add tests."

readFileSync: path
	^ String fromJs: INLINE 'fs$.readFileSync( path.js ).toString()'.
!
existsSync: path
	^ Boolean fromJs: INLINE 'fs$.existsSync( path.js )'.
!
