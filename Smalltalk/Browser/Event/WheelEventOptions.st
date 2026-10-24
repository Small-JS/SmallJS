CLASS WheelEventOptions EXTENDS MouseEventOptions MODULE Browser CLASSVARS '' VARS ''

"Encapsulates the JS options object for creating a WheelEvent instance."

METHODS

"Wheel"

delta
	"Scroll amount as a Point3d: deltaX @ deltaY @ deltaZ, or nil if not set.
	 Values that are not set have the JS default value 0."
	INLINE 'if( this.js.deltaX == null && this.js.deltaY == null && this.js.deltaZ == null ) return stNil$'.
	^ Point3d
		x: ( Float fromJs: INLINE 'this.js.deltaX ?? 0' )
		y: ( Float fromJs: INLINE 'this.js.deltaY ?? 0' )
		z: ( Float fromJs: INLINE 'this.js.deltaZ ?? 0' ).
!
delta: point3d
	"Scroll amount as a Point3d: deltaX @ deltaY @ deltaZ."
	INLINE 'this.js.deltaX = point3d.x.js'.
	INLINE 'this.js.deltaY = point3d.y.js'.
	INLINE 'this.js.deltaZ = point3d.z.js'.
!
deltaMode
	^ Integer fromJs: INLINE 'this.js.deltaMode'.
!
deltaMode: deltaMode
	INLINE 'this.js.deltaMode = deltaMode.js'.
!
