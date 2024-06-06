CLASS CssImportRule EXTENDS CssRule MODULE Browser CLASSVARS '' VARS ''

href
	^ String fromJs: INLINE 'this.js.href'.
!
media
	^ MediaList fromJs: INLINE 'this.js.media'.
!
styleSheet
	^ CssStyleSheet fromJs: INLINE 'this.js.styleSheet'.
!
