CLASS ProcessReport EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"This class is tested with TestProcers."

"Settings"

compact
	^ Boolean fromJs: INLINE 'this.js.compact'.
!
compact: compact
	INLINE 'this.js.compact = compact.js'.
!
directory
	^ String fromJs: INLINE 'this.js.directory'.
!
directory: directory
	INLINE 'this.js.directory = directory.js'.
!
filename
	^ String fromJs: INLINE 'this.js.filename'.
!
filename: filename
	INLINE 'this.js.filename = filename.js'.
!
excludeEnv
	^ Boolean fromJs: INLINE 'this.js.excludeEnv'.
!
excludeEnv: excludeEnv
	INLINE 'this.js.excludeEnv = excludeEnv.js'.
!
signal
	^ Integer fromJs: INLINE 'this.js.signal'.
!
signal: signal
	INLINE 'this.js.signal = signal.js'.
!


"Reporting"

getReport: error
	^ JsObject fromJs: INLINE 'this.js.getReport( error.js )'.
!
writeReport: filename error: error
	^ String fromJs: INLINE 'this.js.getReport( filename.js, error.js )'.
!

"Reporting events"

reportOnFatalError
	^ Boolean fromJs: INLINE 'this.js.reportOnFatalError'.
!
reportOnFatalError: reportOnFatalError
	INLINE 'this.js.reportOnFatalError = reportOnFatalError.js'.
!
reportOnSignal
	^ Boolean fromJs: INLINE 'this.js.reportOnSignal'.
!
reportOnSignal: reportOnSignal
	INLINE 'this.js.reportOnSignal = reportOnSignal.js'.
!
reportOnUncaughtException
	^ Boolean fromJs: INLINE 'this.js.reportOnUncaughtException'.
!
reportOnUncaughtException: reportOnUncaughtException
	INLINE 'this.js.reportOnUncaughtException = reportOnUncaughtException.js'.
!

