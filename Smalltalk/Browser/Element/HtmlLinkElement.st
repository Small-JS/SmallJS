CLASS HtmlLinkElement EXTENDS HtmlElement MODULE Browser CLASSVARS '' VARS ''
	"This class encasulates the JS class HTMLinkElement,
	 of which variable js contains an instance."

METHODS

as
	^ String fromJs: INLINE 'this.js.as'.
!
as: as
	INLINE 'this.js.as = as.js'.
!
crossOrigin
	^ String fromJs: INLINE 'this.js.crossOrigin'.
!
crossOrigin: crossOrigin
	INLINE 'this.js.crossOrigin = crossOrigin.js'.
!
disabled
	^ Boolean fromJs: INLINE 'this.js.disabled'.
!
disabled: disabled
	INLINE 'this.js.disabled = disabled.js'.
!
href
	^ String fromJs: INLINE 'this.js.href'.
!
href: href
	INLINE 'this.js.href = href.js'.
!
hreflang
	^ String fromJs: INLINE 'this.js.hreflang'.
!
hreflang: hreflang
	INLINE 'this.js.hreflang = hreflang.js'.
!
media
	^ String fromJs: INLINE 'this.js.media'.
!
media: media
	INLINE 'this.js.media = media.js'.
!
referrerPolicy
	^ String fromJs: INLINE 'this.js.referrerPolicy'.
!
referrerPolicy: referrerPolicy
	INLINE 'this.js.referrerPolicy = referrerPolicy.js'.
!
rel
	^ String fromJs: INLINE 'this.js.rel'.
!
rel: rel
	INLINE 'this.js.rel = rel.js'.
!
relList
	^ DomTokenList fromJs: INLINE 'this.js.relList'.
!
sizes
	^ DomTokenList fromJs: INLINE 'this.js.sizes'.
!
sheet
	^ CssStyleSheet fromJs: INLINE 'this.js.sheet'.
!
type
	^ String fromJs: INLINE 'this.js.type'.
!
type: type
	INLINE 'this.js.type = type.js'.
!
