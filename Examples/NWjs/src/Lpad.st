CLASS Lpad EXTENDS Object MODULE MyNwApp CLASSVARS '' VARS ''

"Encapsulates the infamous npm package 'lpad',
to show how to import an external npm package in NWjs.
2025-09-23: Options using 'import' forms are currently not working,
	one must use 'require()' with a relative path to the main file."

INLINE 'const lpad$ = require( "../node_modules/lpad/index.js" );'

CLASSMETHODS

leftPad: string with: prefix
	^ String fromJs: INLINE 'lpad$.default( string.js , prefix.js )'
!
