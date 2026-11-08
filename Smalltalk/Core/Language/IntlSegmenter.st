CLASS IntlSegmenter EXTENDS IntlObject MODULE Core CLASSVARS '' VARS ''
	"This class encapsulates the JS class Intl.Segmenter.
	 It splits Strings into graphemes, words or sentences in a language.
	 The option 'granularity' is 'grapheme' (default), 'word' or 'sentence'."

CLASSMETHODS

jsConstructor
	^ JsObject fromJs: INLINE 'Intl.Segmenter'.
!

METHODS

segment: string
	"Return an Array of IntlSegments."
	^ Array fromJs: INLINE 'Array.from( this.js.segment( string.js ) )' elementClass: IntlSegment.
!
segment: string containing: index
	"Return the IntlSegment that contains the character at index, or nil if index is out of range."
	^ IntlSegment fromJs: INLINE 'this.js.segment( string.js ).containing( index.js )'.
!
