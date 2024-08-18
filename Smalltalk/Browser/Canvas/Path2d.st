CLASS Path2d EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

CLASSMETHODS

new
	^ self fromJs: INLINE 'new Path2D()'.
!

METHODS

"Path"

addPath: path
	INLINE 'this.js.addPath( path.js )'.
!
addPath: path transform: domMatrix
	INLINE 'this.js.addPath( path.js, domMatrix.js )'.
!
closePath
	INLINE 'this.js.closePath()'.
!

"Lines"

moveTo: point
	INLINE 'this.js.moveTo( point.x.js, point.y.js )'.
!
lineTo: point
	INLINE 'this.js.lineTo( point.x.js, point.y.js )'.
!

"Rectangles"

roundRect: rect radius: radius
	INLINE 'this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radius.js )'.
!
roundRect: rect radii: radii
	INLINE 'this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radii.$toJs() )'.
!

"Curves"

arc: center radius: radius startAngle: startAngle endAngle: endAngle counterclockwise: counterclockwise
	INLINE 'this.js.arc( center.x.js, center.y.js, radius.js, startAngle.js, endAngle.js, counterclockwise.js )'.
!
arcTo: to1 to: to2 radius: radius
	INLINE 'this.js.arcTo( to1.x.js, to1.y.js, to2.x.js, to2.y.js, radius.js )'.
!
bezierCurveTo: to1 to: to2 end: end
	INLINE 'this.js.bezierCurveTo( to1.x.js, to1.y.js, to2.x.js, to2.y.js, end.x.js, end.y.js )'.
!
ellipse: center radii: radii rotation: rotation startAngle: startAngle endAngle: endAngle counterclockwise: counterclockwise
	INLINE 'this.js.ellipse( center.x.js, center.y.js , radii.x.js, radii.y.js, rotation.js, startAngle.js, endAngle.js, counterclockwise.js )'.
!
quadraticCurveTo: to end: end
	INLINE 'this.js.quadraticCurveTo( to.x.js, to.y.js, end.x.js, end.y.js )'.
!

