CLASS Process EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''


"Environment 'env' functionality is implemented in the Environment class."

"Use the second import form, because it's compatible with NW.js."
"INLINE 'import * as process$ from 'node:process';'"
INLINE 'const process$ = await import( "node:process" );'

CLASSMETHODS

"Arguments"

argv
	^ Array fromJsStrings: INLINE 'process$.argv'
!
execArgv
	^ Array fromJsStrings: INLINE 'process$.execArgv'
!
argv0
	^ String fromJs: INLINE 'process$.argv0'.
!
execPath
	^ String fromJs: INLINE 'process$.execPath'
!

"Directory"

cwd
	^ String fromJs: INLINE 'process$.cwd()'.
!
chdir: directory
	INLINE 'process$.chdir( directory.js )'.
!

"Process"

config
	^ ProcessConfig fromJs: INLINE 'process$.config'.
!
exit: code
	INLINE 'process$.exit( code.js )'.
!
abort
	INLINE 'process$.abort()'.
!
kill: pid signal: signal
	INLINE 'process$.kill( pid.js, signal.js )'.
!
uncaughtExceptionCaptureCallback: block
	INLINE 'process$.setUncaughtExceptionCaptureCallback(
		error => block.$value$( stError$class.$fromJs$( error ) ) )'.
!

"Platform"

platform
	^ String fromJs: INLINE 'process$.platform'.
!
isWindows
	^ self platform = 'win32'.
!
isLinux
	^ self platform = 'linux'.
!
isMacos
	^ self platform = 'darwin'.
!
arch
	^ String fromJs: INLINE 'process$.arch'.
!

"Memory"

availableMemory
	^ Integer fromJs: INLINE 'process$.availableMemory()'.
!
constrainedMemory
	^ Integer fromJs: INLINE 'process$.constrainedMemory()'.
!
memoryUsage
	^ MemoryUsage fromJs: INLINE 'process$.memoryUsage()'.
!

"IPC channel"

connected
	^ Boolean fromJs: INLINE 'process$.connected'.
!
disconnect
	"Close the IPC channel to the parent process. Does nothing without IPC channel."
	INLINE 'process$.disconnect?.()'.
!
channelRef
	"Does nothing without IPC channel."
	INLINE 'process$.channel?.ref()'.
!
channelUnref
	"Does nothing without IPC channel."
	INLINE 'process$.channel?.unref()'.
!

"IDs"

pid
	^ Integer fromJs: INLINE 'process$.pid'.
!
ppid
	^ Integer fromJs: INLINE 'process$.ppid'.
!

"User IDs"

uid
	^ Integer fromJs: INLINE 'process$.getuid()'.
!
uid: uid
	INLINE 'process$.setuid( uid.js )'.
!
euid
	^ Integer fromJs: INLINE 'process$.geteuid()'.
!
euid: euid
	INLINE 'process$.seteuid( euid.js )'.
!
gid
	^ Integer fromJs: INLINE 'process$.getgid()'.
!
gid: gid
	INLINE 'process$.setgid( gid.js )'.
!
egid
	^ Integer fromJs: INLINE 'process$.getegid()'.
!
egid: egid
	INLINE 'process$.setegid( egid.js )'.
!
groups
	"Not available on Windows."
	^ Array fromJs: INLINE 'process$.getgroups()' elementClass: Integer.
!
groups: gids
	INLINE 'process$.setgroups( gids.$toJs() )'.
!

"CPU"

cpuUsage
	^ CpuUsage fromJs: INLINE 'process$.cpuUsage()'.
!
threadCpuUsage
	"CPU usage of the current thread only."
	^ CpuUsage fromJs: INLINE 'process$.threadCpuUsage()'.
!

"New - to categorize"

emitWarning: warning
	INLINE 'process$.emitWarning( warning.js )'.
!
hrtime
	^ BigInt fromJs: INLINE 'process$.hrtime.bigint()'.
!
permissionEnabled
	^ Boolean fromJs: INLINE 'process$.permission !== undefined'.
!
hasPermission: scope reference: reference
	"Note: Node must be started with the --permission flag to enable this."
	self permissionEnabled ifFalse: [ ^ true ].
	^ Boolean fromJs: INLINE 'process$.permission.has( scope.js, reference.js )'.
!
ref: jsObject
	INLINE 'process$.ref( jsObject.js )'.
!
unref: jsObject
	INLINE 'process$.unref( jsObject.js )'.
!
report
	^ ProcessReport fromJs: INLINE 'process$.report'.
!
resourceUsage
	^ ResourceUsage fromJs: INLINE 'process$.resourceUsage()'.
!
title
	^ String fromJs: INLINE 'process$.title'.
!
umask: umask
	^ Integer fromJs: INLINE 'process$.umask( umask.js )'.
!
uptime
	^ Integer fromJs: INLINE 'process$.uptime()'.
!
version
	^ String fromJs: INLINE 'process$.version'.
!
versions
	^ JsObject fromJs: INLINE 'process$.versions'.
!

"Not implemented yet:
process.send(message[, sendHandle[, options]][, callback])
process.finalization.register(ref, callback)
process.finalization.registerBeforeExit(ref, callback)
process.finalization.unregister(ref)
process.getActiveResourcesInfo()
process.getBuiltinModule(id)
process.stderr
process.stderr.fd
process.stdin
process.stdin.fd
process.stdout
process.stdout.fd
"
