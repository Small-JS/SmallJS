CLASS HtmlAudioElement EXTENDS HtmlMediaElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLAudioElement.
	 It has no properties or methods of its own; they are inherited from HtmlMediaElement."

CLASSMETHODS

new
	"Create a new audio element, not yet connected to a document."
	^ self fromJs: INLINE 'new Audio()'.
!
src: src
	"Create a new audio element with the given source URL, not yet connected to a document.
	 The audio starts loading automatically."
	^ self fromJs: INLINE 'new Audio( src.js )'.
!
