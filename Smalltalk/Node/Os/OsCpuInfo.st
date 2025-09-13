CLASS OsCpuInfo EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''


model
	^ String fromJs: INLINE 'this.js.model'.
!
speed
	^ Integer fromJs: INLINE 'this.js.speed'.
!

"Times"

user
	^ Integer fromJs: INLINE 'this.js.times.user'.
!
nice
	^ Integer fromJs: INLINE 'this.js.times.nice'.
!
sys
	^ Integer fromJs: INLINE 'this.js.times.sys'.
!
idle
	^ Integer fromJs: INLINE 'this.js.times.idle'.
!
irq
	^ Integer fromJs: INLINE 'this.js.times.irq'.
!
