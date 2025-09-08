CLASS Os EXTENDS Object MODULE Node1 CLASSVARS '' VARS ''

INLINE 'import * as os$ from "os";'

CLASSMETHODS

tmpdir
	^ String fromJs: INLINE 'os$.tmpdir()'.
!

"TODO: Implement with tests:
os.EOL
os.availableParallelism()
os.arch()
os.constants
os.cpus()
os.devNull
os.endianness()
os.freemem()
os.getPriority([pid])
os.homedir()
os.hostname()
os.loadavg()
os.machine()
os.networkInterfaces()
os.platform()
os.release()
os.setPriority([pid, ]priority)
os.totalmem()
os.type()
os.uptime()
os.userInfo([options])
os.version()
"
