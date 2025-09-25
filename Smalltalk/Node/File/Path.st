CLASS Path EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Instances of Path encapsulate POSIX or Windows functionality, depending on their initialization.
 Class methods of the class Path encapsulate functionality of the OS it's running on."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as path$ from 'node:path';'"
INLINE 'const path$ = await import( "node:path" );'

CLASSMETHODS

"Creation"

new
	^ self default.
!
default
	^ self fromJs: INLINE 'path$'.
!
posix
	^ self fromJs: INLINE 'path$.posix'.
!
win32
	^ self fromJs: INLINE 'path$.win32'.
!
isWindows
	^ self default sep = '\\'.
!

"Operations on default (running) OS"

resolve: path
	^ self default resolve: path.
!
join: path with: path2
	^ self default join: path with: path2.
!
basename: path suffix: suffix
	^ self default basename: path suffix: suffix.
!
delimiter
	^ self default delimiter.
!
dirname: path
	^ self default dirname: path.
!
extname: path
	^ self default extname: path.
!
format: pathObject
	^ self default format: pathObject.
!
matches: path glob: pattern
	^ self default matches: path glob: pattern.
!
isAbsolute: path
	^ self default isAbsolute: path.
!
normalize: path
	^ self default normalize: path.
!
parse: path
	^ self default parse: path.
!
relativeFrom: from to: to
	^ self default relativeFrom: from to: to.
!
sep
	^ self default sep.
!
toNamespacedPath: path
	^ self default toNamespacedPath: path.
!

METHODS

resolve: path
	^ String fromJs: INLINE 'this.js.resolve( path.js )'.
!
join: path with: path2
	^ String fromJs: INLINE 'this.js.join( path.js, path2.js )'.
!
basename: path suffix: suffix
	^ String fromJs: INLINE 'this.js.basename( path.js, suffix.js )'.
!
delimiter
	^ String fromJs: INLINE 'this.js.delimiter'.
!
dirname: path
	^ String fromJs: INLINE 'this.js.dirname( path.js )'.
!
extname: path
	^ String fromJs: INLINE 'this.js.extname( path.js )'.
!
format: pathObject
	^ String fromJs: INLINE 'this.js.format( pathObject.js )'.
!
matches: path glob: pattern
	^ Boolean fromJs: INLINE 'this.js.matchesGlob( path.js, pattern.js )'.
!
isAbsolute: path
	^ Boolean fromJs: INLINE 'this.js.isAbsolute( path.js )'.
!
normalize: path
	^ String fromJs: INLINE 'this.js.normalize( path.js )'.
!
parse: path
	^ PathObject fromJs: INLINE 'this.js.parse( path.js )'.
!
relativeFrom: from to: to
	^ String fromJs: INLINE 'this.js.relative( from.js, to.js )'.
!
sep
	^ String fromJs: INLINE 'this.js.sep'.
!
toNamespacedPath: path
	^ String fromJs: INLINE 'this.js.toNamespacedPath( path.js )'.
!
posix
	^ Path fromJs: INLINE 'this.js.posix'.
!
win32
	^ Path fromJs: INLINE 'this.js.win32'.
!
