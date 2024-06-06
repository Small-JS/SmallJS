CLASS Location EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS Location class."

METHODS

"Properties."

host
	^ String fromJs: INLINE 'this.js.host'.
!
hostPath
	^ self protocol, '//', self host.
!
hostname
	^ String fromJs: INLINE 'this.js.hostname'.
!
href
	^ String fromJs: INLINE 'this.js.href'.
!
href: href
	INLINE 'this.js.href = href.js'.
!
origin
	^ String fromJs: INLINE 'this.js.origin'.
!
pathname
	^ String fromJs: INLINE 'this.js.pathname'.
!
protocol
	^ String fromJs: INLINE 'this.js.protocol'.
!
search
	^ String fromJs: INLINE 'this.js.search'.
!

"Methods."

assign: url
	INLINE 'this.js.assign( url.js )'.
!
reload
	INLINE 'this.js.reload()'.
!
replace: url
	INLINE 'this.js.replace( url.js )'.
!
toString
	^ String fromJs: INLINE 'this.js.toString()'.
!

