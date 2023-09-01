CLASS TestConsole EXTENDS Test MODULE TestCore CLASSVARS '' VARS ''

"The JS console object produces only output / side effects that cannot be read back.
 So the tests in this class should be visually isnpected.
 And de test are disabled by default, so the don't mess up other logging.
 Enable tests by replacing 'noTest' with 'test' or by calling 'noTest' explicitly."

METHODS

noTest
	| label |

	Console log: 'This log message should be cleared.'.
	Console clear.
	Console assert: false message: 'This assert message should be shown.'.
	Console assert: true message: 'This assert message should NOT be shown.'.
	Console assert: true message: 'This assert message should NOT be shown.'.
	Console debug: 'Debug mesage.'.
	Console error: 'Error message.'.
	Console info: 'Info message.'.
	Console log: 'Log message.'.
	Console warn: 'Warning message.'.

	label := 'label3'.
	Console count: label.
	Console countReset: label.
	Console count: label.
	Console count: label.
	Console count: label.

	Console dir: 'aString'.
	Console dirxml: 'anXmlString'.
	Console table: #( 'A' 'B' 'C' ).

	label := 'groupLabel'.
	Console group: label.
	Console log: 'At level 1'.
	Console groupCollapsed: label.
	Console log: 'Collapsed at level 2'.
	Console groupEnd: label.
	Console groupEnd: label.
	Console log: 'Back at level 0'.

	label := 'timeLabel'.
	Console time: label.
	Console timeStamp: label.
	Console timeLog: label.
	Console timeEnd: label.

	Console log: 'The following stack trace is explicitly requested:'.
	Console trace.
!
