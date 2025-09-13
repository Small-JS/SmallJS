CLASS Os EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

INLINE 'import * as os$ from "os";'

CLASSMETHODS

tmpdir
	^ String fromJs: INLINE 'os$.tmpdir()'.
!
eol
	^ String fromJs: INLINE 'os$.EOL'.
!
devNull
	^ String fromJs: INLINE 'os$.devNull'.
!

"User"

homedir
	^ String fromJs: INLINE 'os$.homedir()'.
!
userInfo
	^ OsUserInfo fromJs: INLINE 'os$.userInfo()'.
!

"Process"

getPriority: pid
	^ Integer fromJs: INLINE 'os$.getPriority( pid.js )'.
!
setPriority: pid to: priority
	INLINE 'os$.setPriority( pid.js, priority.js )'.
!
uptime
	^ Integer fromJs: INLINE 'os$.uptime()'.
!
loadavg
	^ Array fromJs: INLINE 'os$.loadavg()' elementClass: Float.
!
freemem
	^ Integer fromJs: INLINE 'os$.freemem()'.
!
totalmem
	^ Integer fromJs: INLINE 'os$.totalmem()'.
!

"OS"

type
	^ String fromJs: INLINE 'os$.type()'.
!
isWindows
	^ self type = 'Windows_NT'.
!
isLinux
	^ self type = 'Linux'.
!
isMacos
	^ self type = 'Darwin'.
!
platform
	^ String fromJs: INLINE 'os$.platform()'.
!
version
	^ String fromJs: INLINE 'os$.version()'.
!
release
	^ String fromJs: INLINE 'os$.release()'.
!

"Host"

hostname
	^ String fromJs: INLINE 'os$.hostname()'.
!
machine
	^ String fromJs: INLINE 'os$.machine()'.
!
networkInterfaces
	"Returns a map where each keys is an interface name
	 and each value is and array of associated OsNetworkInterfaceInfo objects
	 with differen addresses."
	| jsObject map infos |
	jsObject := JsObject fromJs: INLINE 'os$.networkInterfaces()'.

	map := Map new.
	jsObject ownJsPropertyNames do: [ :name |
		infos := Array fromJs: INLINE 'jsObject.js[ name.js ]' elementClass: OsNetworkInterfaceInfo.
		map set: name value: infos ].
	^ map.
!

"CPU"

arch
	^ String fromJs: INLINE 'os$.arch()'.
!
availableParallelism
	^ Integer fromJs: INLINE 'os$.availableParallelism()'.
!
cpus
	^ Array fromJs: INLINE 'os$.cpus()' elementClass: OsCpuInfo.
!
endianness
	^ String fromJs: INLINE 'os$.endianness()'.
!

