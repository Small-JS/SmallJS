CLASS Dir EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Properties"

path
	^ String fromJs: INLINE 'this.js.path'.
!

"Async operations"

closeThen: block error: errorBlock
	INLINE 'this.js.close()
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
readThen: block error: errorBlock
	INLINE 'this.js.read()
		.then( jsDirent => block.$value$( stDirent$class.$fromJs$( jsDirent ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Sync operations"

readSync
	^ Dirent fromJs: INLINE 'this.js.readSync()'.
!
closeSync
	INLINE 'this.js.closeSync()'.
!
