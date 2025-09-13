CLASS OsNetworkInterfaceInfo EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Common"

family
	^ String fromJs: INLINE 'this.js.family'.
!
address
	^ String fromJs: INLINE 'this.js.address'.
!
netmask
	^ String fromJs: INLINE 'this.js.netmask'.
!
mac
	^ String fromJs: INLINE 'this.js.mac'.
!
internal
	^ Boolean fromJs: INLINE 'this.js.internal'.
!

"IPv6"

scopeid
	^ Integer fromJs: INLINE 'this.js.scopeid'.
!
cidr
	^ String fromJs: INLINE 'this.js.cidr'.
!
