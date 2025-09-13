CLASS TestOsConstants EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	|  signals errno priority |

	signals := OsConstants signals.
	self assert: [ ( signals atJsProperty: 'SIGHUP' ) = 1 ].

	errno := OsConstants errno.
	self assert: [ ( errno atJsProperty: 'E2BIG' ) = 7 ].

	priority := OsConstants priority.
	self assert: [ ( priority atJsProperty: 'PRIORITY_NORMAL' ) = 0 ].
!
