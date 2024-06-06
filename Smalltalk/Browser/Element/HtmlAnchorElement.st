CLASS HtmlAnchorElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class HTMLinkElement,
	 of which variable js contains an instance."

METHODS

download
	^ String fromJs: INLINE 'this.js.download'.
!
download: download
	^ INLINE 'this.js.download = download.js'.
!
host
	^ String fromJs: INLINE 'this.js.host'.
!
host: host
	^ INLINE 'this.js.host = host.js'.
!
hostname
	^ String fromJs: INLINE 'this.js.hostname'.
!
hostname: hostname
	^ INLINE 'this.js.hostname = hostname.js'.
!
href
	^ String fromJs: INLINE 'this.js.href'.
!
href: href
	^ INLINE 'this.js.href = href.js'.
!
hreflang
	^ String fromJs: INLINE 'this.js.hreflang'.
!
hreflang: hreflang
	^ INLINE 'this.js.hreflang = hreflang.js'.
!
origin
	^ String fromJs: INLINE 'this.js.origin'.
!
password
	^ String fromJs: INLINE 'this.js.password'.
!
password: password
	^ INLINE 'this.js.password = password.js'.
!
pathname
	^ String fromJs: INLINE 'this.js.pathname'.
!
pathname: pathname
	^ INLINE 'this.js.pathname = pathname.js'.
!
port
	^ String fromJs: INLINE 'this.js.port'.
!
port: port
	^ INLINE 'this.js.port = port.js'.
!
protocol
	^ String fromJs: INLINE 'this.js.protocol'.
!
protocol: protocol
	^ INLINE 'this.js.protocol = protocol.js'.
!
referrerPolicy
	^ String fromJs: INLINE 'this.js.referrerPolicy'.
!
referrerPolicy: referrerPolicy
	^ INLINE 'this.js.referrerPolicy = referrerPolicy.js'.
!
rel
	^ String fromJs: INLINE 'this.js.rel'.
!
rel: rel
	^ INLINE 'this.js.rel = rel.js'.
!
relList
	^ DomTokenList fromJs: INLINE 'this.js.relList'.
!
search
	^ String fromJs: INLINE 'this.js.search'.
!
search: search
	^ INLINE 'this.js.search = search.js'.
!
target
	^ String fromJs: INLINE 'this.js.target'.
!
target: target
	^ INLINE 'this.js.target = target.js'.
!
text
	^ String fromJs: INLINE 'this.js.text'.
!
text: text
	^ INLINE 'this.js.text = text.js'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	^ INLINE 'this.js.type = type.js'.
!
username
	^ String fromJs: INLINE 'this.js.username'.
!
username: username
	^ INLINE 'this.js.username = username.js'.
!
toString
	^ String fromJs: INLINE 'this.js.toString()'.
!

