CLASS TestOs EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

test
	| loadavg |

	self assert: [ Os tmpdir length > 0 ].
	self assert: [ #( '\n' '\r\n' ) includes: Os eol ].
	self assert: [ #( '/dev/null' '\\\\.\\nul' ) includes: Os devNull ].

	"User"

	self assert: [ Os homedir length > 0 ].
	self assert: [ Os userInfo class = OsUserInfo ].

	"Process"

	self checkPriority.
	self assert: [ Os uptime > 0 ].

	loadavg := Os loadavg.
	self assert: [ Os loadavg length = 3 ].
	self assert: [ Os loadavg first >= 0.0 ].

	self assert: [ Os freemem > 1000 ].
	self assert: [ Os totalmem > 1000 ].

	"OS"

	self assert: [ #( 'Windows_NT' 'Linux' 'Darwin' ) includes: Os type ].
	self assert: [ Os isWindows | Os isLinux | Os isMacos ].

	self assert: [ Os platform length > 0 ].
	self assert: [ Os version length > 0 ].
	self assert: [ Os release length > 0 ].

	"Host"

	self assert: [ Os hostname length > 0 ].
	self assert: [ Os machine length > 0 ].
	self assert: [ Os networkInterfaces values first first class = OsNetworkInterfaceInfo ].

	"CPU"

	self assert: [ Os arch length > 0 ].
	self assert: [ #( 'BE' 'LE' ) includes: Os endianness ].
	self assert: [ Os availableParallelism > 0 ].
	self assert: [ Os cpus first class = OsCpuInfo ].
!
checkPriority
	| normalPriority lowerPriority |

	normalPriority := OsConstants priority atJsProperty: 'PRIORITY_NORMAL'.
	self assert: [ ( Os getPriority: 0 ) = normalPriority ].

	"Linux and MacOS do not allow changing the process priority by default."
	Os isLinux | Os isMacos ifTrue: [ ^ self ].

	lowerPriority := OsConstants priority atJsProperty: 'PRIORITY_BELOW_NORMAL'.
	Os setPriority: 0 to: lowerPriority.
	self assert: [ ( Os getPriority: 0 ) = lowerPriority ].
	Os setPriority: 0 to: normalPriority.
!
