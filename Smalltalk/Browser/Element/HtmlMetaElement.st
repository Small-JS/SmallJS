CLASS HtmlMetaElement EXTENDS HtmlElement MODULE DOM CLASSVARS '' VARS ''

METHODS

charset
	^ String fromJs: INLINE 'this.js.charset'.
!
charset: charset
	INLINE 'this.js.charset = charset.js'.
!
content
	^ String fromJs: INLINE 'this.js.content'.
!
content: content
	INLINE 'this.js.content = content.js'.
!
httpEquiv
	^ String fromJs: INLINE 'this.js.httpEquiv'.
!
httpEquiv: httpEquiv
	INLINE 'this.js.httpEquiv = httpEquiv.js'.
!
media
	^ String fromJs: INLINE 'this.js.media'.
!
media: media
	INLINE 'this.js.media = media.js'.
!
name
	^ String fromJs: INLINE 'this.js.name'.
!
name: name
	INLINE 'this.js.name = name.js'.
!

