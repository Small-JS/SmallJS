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

"Drawing"

arc: center radius: radius startAngle: startAngle endAngle: endAngle counterclockwise: counterclockwise
	INLINE 'this.js.arc( center.x.js, center.y.js, radius.js, startAngle.js, endAngle.js, counterclockwise.js )'.
!
arcFrom: from to: to radius: radius
	INLINE 'this.js.arcTo( from.x.js, from.y.js, to.x.js, to.y.js, radius.js )'.
!
ellipse: center radii: radii rotation: rotation startAngle: startAngle endAngle: endAngle counterclockwise: counterclockwise
	INLINE 'this.js.ellipse( center.x.js, center.y.js , radii.x.js, radii.y.js, rotation.js, startAngle.js, endAngle.js, counterclockwise.js )'.
!
moveTo: point
	INLINE 'this.js.moveTo( point.x.js, point.y.js )'.
!
lineTo: point
	INLINE 'this.js.lineTo( point.x.js, point.y.js )'.
!
bezierCurveBetween: between1 and: between2 to: to
	INLINE 'this.js.bezierCurveTo( between1.x.js, between1.y.js, between2.x.js, between2.y.js, to.x.js, to.y.js )'.
!
quadraticCurveBetween: between to: to
	INLINE 'this.js.quadraticCurveTo( between.x.js, between.y.js, to.x.js, to.y.js )'.
!
rect: rectangle
	INLINE 'this.js.rect( rectangle.js )'.
!
roundRect: rectangle radii: radii
	INLINE 'this.js.roundRect( rectangle.x.js, rectangle.y.js, rectangle.width.js, rectangle.height.js, radii.js )'.
!
