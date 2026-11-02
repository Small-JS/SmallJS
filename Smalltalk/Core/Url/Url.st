CLASS Url EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class: URL.
	 It works in browsers and in Node.js."

CLASSMETHODS

"Creating"

new
	self error: 'Create a new Url with: Url url:[base:]'.
!
url: url
	"Throws an error if url is not a valid absolute URL. Use parse: to get nil instead."
	^ self fromJs: INLINE 'new URL( url.js )'.
!
url: url base: base
	"Resolve url, which may be relative, against the base URL."
	^ self fromJs: INLINE 'new URL( url.js, base.js )'.
!
parse: url
	"Return nil if url is not a valid absolute URL."
	^ self fromJs: INLINE 'URL.parse( url.js )'.
!
parse: url base: base
	^ self fromJs: INLINE 'URL.parse( url.js, base.js )'.
!

"Testing"

canParse: url
	^ Boolean fromJs: INLINE 'URL.canParse( url.js )'.
!
canParse: url base: base
	^ Boolean fromJs: INLINE 'URL.canParse( url.js, base.js )'.
!

"Object URLs"

createObjectUrl: blob
	"Return a 'blob:' URL String referring to the Blob or File."
	^ String fromJs: INLINE 'URL.createObjectURL( blob.js )'.
!
revokeObjectUrl: url
	INLINE 'URL.revokeObjectURL( url.js )'.
!

METHODS

"Properties"

hash
	"Includes the leading '#', or is empty."
	^ String fromJs: INLINE 'this.js.hash'.
!
hash: hash
	INLINE 'this.js.hash = hash.js'.
!
host
	"The hostname followed by ':' and the port, if not the default port."
	^ String fromJs: INLINE 'this.js.host'.
!
host: host
	INLINE 'this.js.host = host.js'.
!
hostname
	^ String fromJs: INLINE 'this.js.hostname'.
!
hostname: hostname
	INLINE 'this.js.hostname = hostname.js'.
!
href
	"The complete URL."
	^ String fromJs: INLINE 'this.js.href'.
!
href: href
	INLINE 'this.js.href = href.js'.
!
origin
	"Read only."
	^ String fromJs: INLINE 'this.js.origin'.
!
password
	^ String fromJs: INLINE 'this.js.password'.
!
password: password
	INLINE 'this.js.password = password.js'.
!
pathname
	^ String fromJs: INLINE 'this.js.pathname'.
!
pathname: pathname
	INLINE 'this.js.pathname = pathname.js'.
!
port
	"A String, empty for the default port of the protocol."
	^ String fromJs: INLINE 'this.js.port'.
!
port: port
	INLINE 'this.js.port = port.$toJs()'.
!
protocol
	"Includes the trailing ':'."
	^ String fromJs: INLINE 'this.js.protocol'.
!
protocol: protocol
	INLINE 'this.js.protocol = protocol.js'.
!
search
	"Includes the leading '?', or is empty."
	^ String fromJs: INLINE 'this.js.search'.
!
search: search
	INLINE 'this.js.search = search.js'.
!
searchParams
	"Read only. Changes to the returned UrlSearchParams update this Url."
	^ UrlSearchParams fromJs: INLINE 'this.js.searchParams'.
!
username
	^ String fromJs: INLINE 'this.js.username'.
!
username: username
	INLINE 'this.js.username = username.js'.
!

"Converting"

toString
	"Return the complete URL, same as href."
	^ String fromJs: INLINE 'this.js.toString()'.
!
