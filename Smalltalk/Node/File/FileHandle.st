CLASS FileHandle EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Note: Node.js readable and writable streams are not implemented,
	because they duplicate browser stream functionality."

CLASSMETHODS

new
	self error: 'FileHandle instances are created with class methods: "open:*"'.
!

"Opening"

open: path flags: flags then: block error: errorBlock
	^ self open: path flags: flags mode: 438 then: block error: errorBlock.
!
open: path flags: flags mode: mode then: block error: errorBlock
	Fsp open: path flags: flags mode: mode then: block error: errorBlock.
!

METHODS

"Closing"

closeThen: block error: errorBlock
	INLINE 'this.js.close()
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Properties"

fd
	^ Integer fromJs: INLINE 'this.js.fd'.
!
statThen: block error: errorBlock
	INLINE 'this.js.stat()
		.then( jsStats => block.$value$( stFileStats$class.$fromJs$( jsStats ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Reading"

read: buffer offset: offset length: length position: position then: block error: errorBlock
	INLINE 'this.js.read( buffer.js, offset.js, length.js, position.js )
		.then( jsResult => block.$value$value$(
			stInteger$class.$fromJs$( jsResult.bytesRead ),
			stBuffer$class.$fromJs$( jsResult.buffer ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
readFileThen: block error: errorBlock
	INLINE 'this.js.readFile()
		.then( jsBuffer => block.$value$( stBuffer$class.$fromJs$( jsBuffer ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
readFile: options then: block error: errorBlock
	INLINE 'this.js.readFile( options.js )
		.then( jsResult => typeof jsResult === "string"
			? block.$value$( stString$class.$fromJs$( jsResult ) )
			: block.$value$( stBuffer$class.$fromJs$( jsResult ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Writing"

write: buffer offset: offset length: length position: position then: block error: errorBlock
	INLINE 'this.js.write( buffer.js, offset.js, length.js, position.js )
		.then( jsResult => block.$value$value$(
			stInteger$class.$fromJs$( jsResult.bytesWritten ),
			stBuffer$class.$fromJs$( jsResult.buffer ) ) )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
writeFile: data then: block error: errorBlock
	self writeFile: data options: nil then: block error: errorBlock.
!
writeFile: data options: options then: block error: errorBlock
	INLINE 'this.js.writeFile( data.js, options.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
truncate: len then: block error: errorBlock
	INLINE 'this.js.truncate( len.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"Access"

chmod: mode then: block error: errorBlock
	INLINE 'this.js.chmod( mode.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
chown: uid gid: gid then: block error: errorBlock
	INLINE 'this.js.chown( uid.js, gid.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
atime: atime mtime: mtime then: block error: errorBlock
	INLINE 'this.js.utimes( atime.js, mtime.js )
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

"System"

syncThen: block error: errorBlock
	INLINE 'this.js.sync()
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!
datasyncThen: block error: errorBlock
	INLINE 'this.js.datasync()
		.then( () => block.$value() )
		.catch( jsError => errorBlock.$value$( stError$class.$fromJs$( jsError ) ) )'.
!

