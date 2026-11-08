CLASS IntlSegment EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates a segment data object, returned by IntlSegmenter."

METHODS

segment
	"The String of this segment."
	^ String fromJs: INLINE 'this.js.segment'.
!
index
	"The index of this segment in the input."
	^ Integer fromJs: INLINE 'this.js.index'.
!
input
	"The whole String that was segmented."
	^ String fromJs: INLINE 'this.js.input'.
!
isWordLike
	"Only for granularity 'word': true if the segment is a word, false for spaces and punctuation.
	 nil for other granularities."
	^ Boolean fromJs: INLINE 'this.js.isWordLike'.
!
