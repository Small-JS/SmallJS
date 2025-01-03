CLASS SqliteDatabaseOptions EXTENDS JsObject MODULE Database CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self newEmpty.
!

METHODS

open
	^ Boolean fromJs: INLINE 'this.js.open'.
!
open: open
	INLINE 'this.js.open = open.js'.
!
readOnly
	^ Boolean fromJs: INLINE 'this.js.readOnly'.
!
readOnly: readOnly
	INLINE 'this.js.readOnly = readOnly.js'.
!
enableForeignKeyConstraints
	^ Boolean fromJs: INLINE 'this.js.enableForeignKeyConstraints'.
!
enableForeignKeyConstraints: enableForeignKeyConstraints
	INLINE 'this.js.enableForeignKeyConstraints = enableForeignKeyConstraints.js'.
!
enableDoubleQuotedStringLiterals
	^ Boolean fromJs: INLINE 'this.js.enableDoubleQuotedStringLiterals'.
!
enableDoubleQuotedStringLiterals: enableDoubleQuotedStringLiterals
	INLINE 'this.js.enableDoubleQuotedStringLiterals = enableDoubleQuotedStringLiterals.js'.
!
allowExtension
	^ Boolean fromJs: INLINE 'this.js.allowExtension'.
!
allowExtension: allowExtension
	INLINE 'this.js.allowExtension = allowExtension.js'.
!
