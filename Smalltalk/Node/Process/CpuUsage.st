CLASS CpuUsage EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

user
	^ Integer fromJs: INLINE 'this.js.user'.
!
system
	^ Integer fromJs: INLINE 'this.js.system'.
!
