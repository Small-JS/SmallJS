CLASS HtmlOlElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLOListElement.
	 The deprecated property compact is not implemented."

METHODS

reversed
	"If true, the items are numbered from high to low."
	^ Boolean fromJs: INLINE 'this.js.reversed'.
!
reversed: reversed
	INLINE 'this.js.reversed = reversed.js'.
!
start
	"The number of the first item."
	^ Integer fromJs: INLINE 'this.js.start'.
!
start: start
	INLINE 'this.js.start = start.js'.
!
type
	"The numbering type, one of: '1', 'a', 'A', 'i', 'I'. Empty if not set, meaning '1'."
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js'.
!
