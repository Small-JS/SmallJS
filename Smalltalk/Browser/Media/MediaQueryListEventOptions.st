CLASS MediaQueryListEventOptions EXTENDS EventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a MediaQueryListEvent instance."

METHODS

matches
	^ Boolean fromJs: INLINE 'this.js.matches'.
!
matches: matches
	INLINE 'this.js.matches = matches.js'.
!
media
	^ String fromJs: INLINE 'this.js.media'.
!
media: media
	INLINE 'this.js.media = media.js'.
!
