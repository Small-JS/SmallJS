CLASS FileHandle EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Note: Node.js readable and writable streams are not implemented,
	because they duplicate browser stream functionality."

CLASSMETHODS

new
	self error: 'FileHandle instances are created with class methods: "open:*"'.
!

"Opening"

async open: path flags: flags
	^ FileHandle fromJs:
		INLINE 'await fsp$.open( path.js, flags.js )'.
!
async open: path flags: flags mode: mode
	^ FileHandle fromJs:
		INLINE 'await fsp$.open( path.js, flags.js, mode.js )'.
!

METHODS

"Closing"

async close
	INLINE 'await this.js.close()'.
!

"Properties"

fd
	^ Integer fromJs:
		INLINE 'this.js.fd'.
!
async stat
	^ FileStats fromJs:
		INLINE 'await this.js.stat()'.
!

"Reading"

async read: buffer offset: offset length: length position: position
	"This methods only returns the number of bytes read,
	 not also the (identical) buffer agrument."
	^ Integer fromJs:
		INLINE '( await this.js.read( buffer.js, offset.js, length.js, position.js ) ).bytesRead'.
!
async readFile
	^ Buffer fromJs:
		INLINE 'await this.js.readFile()'.
!
async readFile: options
	^ Buffer fromJs:
		INLINE 'await this.js.readFile( options.js )'.
!

"Writing"

async write: buffer offset: offset length: length position: position
	"This methods only returns the number of bytes written,
	 not also the (identical) buffer agrument."
	^ Integer fromJs:
		INLINE '( await this.js.write( buffer.js, offset.js, length.js, position.js ) ).bytesWritten'.
!
async writeFile: data
	await self writeFile: data options: nil.
!
async writeFile: data options: options
	INLINE 'await this.js.writeFile( data.js, options.js )'.
!
async truncate: length
	INLINE 'await this.js.truncate( length.js )'.
!

"Access"

async chmod: mode
	INLINE 'await this.js.chmod( mode.js )'.
!
async chown: uid gid: gid
	INLINE 'await this.js.chown( uid.js, gid.js )'.
!
async atime: atime mtime: mtime
	INLINE 'await this.js.utimes( atime.js, mtime.js )'.
!

"System"

async sync
	INLINE 'await this.js.sync()'.
!
async datasync
	INLINE 'await this.js.datasync()'.
!
