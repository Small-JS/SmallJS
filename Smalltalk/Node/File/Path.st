CLASS Path EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

INLINE 'import * as path$ from "path";'

CLASSMETHODS

"TODO: Add rest of PlatformPath interface. Add tests."

resolve: path
	^ String fromJs: INLINE 'path$.resolve( path.js )'.
!
