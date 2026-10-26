CLASS ProcessReport EXTENDS JsObject MODULE Node1 CLASSVARS '' VARS ''

"Encapsulates the JS object 'process.report'. Get it with: Process report."

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
	"Error can be nil."
	^ JsObject fromJs: INLINE 'this.js.getReport( error.js ?? undefined )'.
!
writeReport: filename error: error
	"Write the report to a file. Return its file name.
	 If filename is nil, a name is generated."
	^ String fromJs: INLINE 'this.js.writeReport( filename.js ?? undefined, error.js ?? undefined )'.
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

