CLASS Worker EXTENDS EventEmitter MODULE Node1 CLASSVARS '' VARS ''

INLINE 'import { Worker } from "worker_threads";'

CLASSMETHODS

new: fileName
	^ self fromJs: INLINE 'new Worker( fileName.js )'.
!

METHODS

"Properties"

threadId
	^ Integer fromJs: INLINE 'this.js.threadId'.
!

"Process"

ref
	INLINE 'this.js.ref()'.
!
unref
	INLINE 'this.js.unref()'.
!
terminate
	INLINE 'this.js.terminate()'.
!

