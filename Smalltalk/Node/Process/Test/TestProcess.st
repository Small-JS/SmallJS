CLASS TestProcess EXTENDS Test MODULE TestNode CLASSVARS '' VARS ''

METHODS

testArguments
	| temp |
	self assert: [ Process argv length >= 2 ].
	self assert: [ Process argv first includes: 'node' ].
	self assert: [ Process argv0 includes: 'node' ].
	self assert: [ Process execPath includes: 'node' ].
	self assert: [ Process execArgv length = 0 ].
!
testDirectory
	| cwd chdir |

	cwd := Process cwd.
	self assert: [ ( cwd includes: '/' ) | ( cwd includes: '\\' ) ].

	chdir := Path join: cwd with: 'out'.
	Process chdir: chdir.
	self assert: [ Process cwd = chdir ].

	Process chdir: cwd.
!
testExiting
	"Only test these manually, because they exit..."

	"Process exit: 9"
	"Process abort."
	"Process kill: Process pid signal: 15."

	"To test this in VSCode, in Run and Debug, Breakpoints: 'Uncaught Exceptions' must be unchecked"
	"Process uncaughtExceptionCaptureCallback:
		[ :error | self onUncaughtException: error ].
	self causeUncaughtException."
!
onUncaughtException: error
	Console log: 'TestProcess: My uncaught exception handler'.
	Process exit: 1.
!
testPlatform
	| platforms platform archs |

	platforms := #( 'aix' 'darwin' 'freebsd' 'linux' 'openbsd' 'sunos' 'win32' 'android' ).
	platform := Process platform.
	self assert: [ platforms includes: platform ].

	Process isWindows ifTrue: [ self assert: [ platform = 'win32' ] ].
	Process isLinux ifTrue: [ self assert: [ platform = 'linux' ] ].
	Process isMacos ifTrue: [ self assert: [ platform = 'darwin' ] ].

	archs := #( 'arm' 'arm64' 'ia32' 'loong64' 'mips' 'mipsel' 'ppc64' 'riscv64' 's390' 's390x' 'x64' ).
	self assert: [ archs includes: Process arch ].
!
testMemory
	self assert: [ Process availableMemory > 1000 ].
	self assert: [ Process constrainedMemory >= 0 ].
	self assert: [ Process memoryUsage class = MemoryUsage ].
!
testIpc
	self assert: [ Process connected isNil ].
	"Without IPC channel, these do nothing, but must not fail."
	Process channelRef.
	Process channelUnref.
	Process disconnect.
!
testPids
	self assert: [ Process pid > 0 ].
	self assert: [ Process ppid > 0 ].
!
testUids
	"Windows does not have these."
	Process isWindows ifTrue: [ ^ self ].

	"Setting UIDs and GIDs is not tested because it requires elevated rights."
	self assert: [ Process uid >= 0 ].
	self assert: [ Process euid >= 0 ].
	self assert: [ Process gid >= 0 ].
	self assert: [ Process egid >= 0 ].
	self assert: [ Process groups first class = Integer ].
!
testCpuUsage
	| threadUsage processUsage |
	self assert: [ Process cpuUsage class = CpuUsage ].
	self assert: [ Process threadCpuUsage class = CpuUsage ].

	"The main thread uses no more CPU time than the whole process.
	 Measure the thread first, so the process time cannot be older."
	threadUsage := Process threadCpuUsage.
	processUsage := Process cpuUsage.
	self assert: [ threadUsage user <= processUsage user ].
	self assert: [ threadUsage system <= processUsage system ].
!
testRef
	| timer |
	timer := JsObject fromJs: INLINE 'setTimeout( () => {}, 100000 )'.
	Process unref: timer.
	self assert: [ ( Boolean fromJs: INLINE 'timer.js.hasRef()' ) not ].
	Process ref: timer.
	self assert: [ Boolean fromJs: INLINE 'timer.js.hasRef()' ].
	INLINE 'clearTimeout( timer.js )'.
!
testReport
	| report path |
	report := Process report.
	self assert: [ report class = ProcessReport ].
	self assert: [ report compact class = Boolean ].
	self assert: [ ( report getReport: nil ) class = JsObject ].

	path := Os tmpPath: 'smalljs-report-'.
	self assert: [ ( report writeReport: path error: nil ) = path ].
	self assert: [ Fs existsSync: path ].
	Fs unlinkSync: path.
!
testMisc
	| nodeVersion |
	"Only test this manually, to prevent polluting debug output."
	"Process emitWarning: 'Careful, now...'."

	self assert: [ Process hrtime > 1000 ].
	self assert: [ Process uptime >= 0 ].
	self assert: [ Process hasPermission: 'fs.read' reference: '.' ].

	self assert: [ Process version startsWith: 'v' ].
	nodeVersion := Process versions atJsProperty: 'node'.
	self assert: [ nodeVersion = ( Process version slice: 1 ) ].

	self assert: [ Process title length > 0 ].
!
testUmask
	| oldUmask umask |
	"On Windows, 'umask' always returns 0"
	Process isWindows ifTrue: [ ^ self ].

	"Process umask returns the pevious umask."
	oldUmask := Process umask: 2.
	umask := Process umask: oldUmask.
	self assert: [ umask = 2 ].
!

