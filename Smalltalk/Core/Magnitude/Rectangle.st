CLASS Rectangle EXTENDS Object MODULE Core CLASSVARS '' VARS 'origin extent'
	"Implements a rectangle at point origin and with and hight in point extent.
	 Note coordinate system assumes origin at screen top-left with x positive to the right and u positive downwards."

CLASSMETHODS

origin: origin extent: extent
	^ self new origin: origin extent: extent.
!
fromJs: jsDomRect
	"Note: The argument should be a DOMRect, which is not available in Node.js."
	INLINE 'if( jsDomRect == null ) return stNil'.
	^ self
		origin: ( Point fromJsx: INLINE 'jsDomRect.x' y: INLINE 'jsDomRect.x' )
		extent: ( Point fromJsx: INLINE 'jsDomRect.width' y: INLINE 'jsDomRect.height' ).
!

METHODS

"Conversion."

toString
	^ 'Rectangle( ', origin toString, ' , ', extent toString, ' )'.
!

"Accessing."

origin: anOrigin extent: anExtent
	origin := anOrigin.
	extent := anExtent.
!
origin
	^ origin.
!
extent
	^ extent.
!
