CLASS Dir EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Properties"

path
	^ String fromJs: INLINE 'this.js.path'.
!

"Sync operations"

readSync
	^ Dirent fromJs: INLINE 'this.js.readSync()'.
!
closeSync
	INLINE 'this.js.closeSync()'.
!

"Async operations"

async close
	INLINE 'await this.js.close()'.
!
async read: block
	"Evaluates 'block' with 'Dirent' entries from self."
	INLINE '
		let dirent;
		while( dirent = await this.js.read() )
			block.$value$( stDirent$class.$fromJs$( dirent ) );'
!
