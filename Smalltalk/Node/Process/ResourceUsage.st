CLASS ResourceUsage EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

userCpuTime
	^ Integer fromJs: INLINE 'this.js.userCPUTime'.
!
systemCpuTime
	^ Integer fromJs: INLINE 'this.js.systemCPUTime'.
!
maxRss
	^ Integer fromJs: INLINE 'this.js.maxRSS'.
!
minorPageFault
	^ Integer fromJs: INLINE 'this.js.minorPageFault'.
!
majorPageFault
	^ Integer fromJs: INLINE 'this.js.majorPageFault'.
!
swappedOut
	^ Integer fromJs: INLINE 'this.js.swappedOut'.
!
fsRead
	^ Integer fromJs: INLINE 'this.js.fsRead'.
!
fsWrite
	^ Integer fromJs: INLINE 'this.js.fsWrite'.
!
ipcSent
	^ Integer fromJs: INLINE 'this.js.ipcSent'.
!
ipcReceived
	^ Integer fromJs: INLINE 'this.js.ipcReceived'.
!
signalsCount
	^ Integer fromJs: INLINE 'this.js.signalsCount'.
!
voluntaryContextSwitches
	^ Integer fromJs: INLINE 'this.js.voluntaryContextSwitches'.
!
involuntaryContextSwitches
	^ Integer fromJs: INLINE 'this.js.involuntaryContextSwitches'.
!
