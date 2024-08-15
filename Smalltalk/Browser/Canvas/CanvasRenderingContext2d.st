CLASS CanvasRenderingContext2d EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: CanvasRenderingContext2D"

"==== Properties"

canvas
	^ HtmlCanvasElement fromJs: INLINE 'this.js.canvas'.
!
direction
	^ String fromJs: INLINE 'this.js.direction'.
!
direction: direction
	INLINE 'this.js.direction = direction.js'.
!
fillStyle
	"Note: fillStyle currently only supports CSS color strings."
	^ String fromJs: INLINE 'this.js.fillStyle'.
!
fillStyle: fillStyle
	INLINE 'this.js.fillStyle = fillStyle.js'.
!
filter
	^ String fromJs: INLINE 'this.js.filter'.
!
filter: filter
	INLINE 'this.js.filter = filter.js'.
!
font
	^ String fromJs: INLINE 'this.js.font'.
!
font: font
	INLINE 'this.js.font = font.js'.
!
fontKerning
	^ String fromJs: INLINE 'this.js.fontKerning'.
!
fontKerning: fontKerning
	INLINE 'this.js.fontKerning = fontKerning.js'.
!
fontStretch
	^ String fromJs: INLINE 'this.js.fontStretch'.
!
fontStretch: fontStretch
	INLINE 'this.js.fontStretch = fontStretch.js'.
!
fontVariantCaps
	^ String fromJs: INLINE 'this.js.fontVariantCaps'.
!
fontVariantCaps: fontVariantCaps
	INLINE 'this.js.fontVariantCaps = fontVariantCaps.js'.
!
globalAlpha
	^ Float fromJs: INLINE 'this.js.globalAlpha'.
!
globalAlpha: globalAlpha
	INLINE 'this.js.globalAlpha = globalAlpha.js'.
!
globalCompositeOperation
	^ String fromJs: INLINE 'this.js.globalCompositeOperation'.
!
globalCompositeOperation: globalCompositeOperation
	INLINE 'this.js.globalCompositeOperation = globalCompositeOperation.js'.
!
imageSmoothingEnabled
	^ Boolean fromJs: INLINE 'this.js.imageSmoothingEnabled '.
!
imageSmoothingEnabled: imageSmoothingEnabled
	INLINE 'this.js.imageSmoothingEnabled = imageSmoothingEnabled.js'.
!
letterSpacing
	^ String fromJs: INLINE 'this.js.letterSpacing'.
!
letterSpacing: letterSpacing
	INLINE 'this.js.letterSpacing = letterSpacing.js'.
!
lineCap
	^ String fromJs: INLINE 'this.js.lineCap '.
!
lineCap: lineCap
	INLINE 'this.js.lineCap = lineCap .js'.
!
lineDashOffset
	^ Integer fromJs: INLINE 'this.js.lineDashOffset'.
!
lineDashOffset: lineDashOffset
	INLINE 'this.js.lineDashOffset = lineDashOffset.js'.
!
lineJoin
	^ String fromJs: INLINE 'this.js.lineJoin'.
!
lineJoin: lineJoin
	INLINE 'this.js.lineJoin = lineJoin.js'.
!
lineWidth
	^ Float fromJs: INLINE 'this.js.lineWidth'.
!
lineWidth: lineWidth
	INLINE 'this.js.lineWidth = lineWidth.js'.
!
miterLimit
	^ Float fromJs: INLINE 'this.js.miterLimit'.
!
miterLimit: miterLimit
	INLINE 'this.js.miterLimit = miterLimit.js'.
!
shadowBlur
	^ Float fromJs: INLINE 'this.js.shadowBlur'.
!
shadowBlur: shadowBlur
	INLINE 'this.js.shadowBlur = shadowBlur.js'.
!
shadowColor
	^ String fromJs: INLINE 'this.js.shadowColor'.
!
shadowColor: shadowColor
	INLINE 'this.js.shadowColor = shadowColor.js'.
!
shadowOffset
	^ Point jsX: INLINE 'this.js.shadowOffsetX' jsY: INLINE 'this.js.shadowOffsetY'.
!
shadowOffset: shadowOffset
	INLINE 'this.js.shadowOffsetX = shadowOffset.x.js'.
	INLINE 'this.js.shadowOffsetY = shadowOffset.y.js'.
!
strokeStyle
	^ String fromJs: INLINE 'this.js.strokeStyle'.
!
strokeStyle: strokeStyle
	INLINE 'this.js.strokeStyle = strokeStyle.js'.
!
textAlign
	^ String fromJs: INLINE 'this.js.textAlign'.
!
textAlign: textAlign
	INLINE 'this.js.textAlign = textAlign.js'.
!
textBaseline
	^ String fromJs: INLINE 'this.js.textBaseline'.
!
textBaseline: textBaseline
	INLINE 'this.js.textBaseline = textBaseline.js'.
!
textRendering
	^ String fromJs: INLINE 'this.js.textRendering'.
!
textRendering: textRendering
	INLINE 'this.js.textRendering = textRendering.js'.
!
wordSpacing
	^ String fromJs: INLINE 'this.js.wordSpacing'.
!
wordSpacing: wordSpacing
	INLINE 'this.js.wordSpacing = wordSpacing.js'.
!

"==== Methods"

"Path"

beginPath
	INLINE 'this.js.beginPath()'.
!
closePath
	INLINE 'this.js.closePath()'.
!
moveTo: point
	INLINE 'this.js.moveTo( point.x.js, point.y.js )'.
!
stroke
	INLINE 'this.js.stroke()'.
!
strokePath: path
	INLINE 'this.js.stroke( path.js )'.
!
fill
	INLINE 'this.js.fill()'.
!
fillRule: rule
	INLINE 'this.js.fill( rule.js )'.
!
fillPath: path
	INLINE 'this.js.fill( path.js )'.
!
fillPath: path rule: rule
	INLINE 'this.js.fill( path.js, rule.js )'.
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

"Rectangles"

rect: rect
	INLINE 'this.js.rect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
fillRect: rect
	INLINE 'this.js.fillRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
clearRect: rect
	INLINE 'this.js.clearRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
roundRect: rect radius: radius
	INLINE 'this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radius.js )'.
!
roundRect: rect radii: radii
	INLINE 'this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radii.$toJs() )'.
!
strokeRect: rect
	INLINE 'this.js.strokeRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!

"Clipping"

clip
	INLINE 'this.js.clip()'.
!

"Images"

drawImage: image dest: dest
	INLINE 'this.js.drawImage( image.js, dest.x.js, dest.y.js )'.
!
drawImage: image destRect: destRect
	INLINE 'this.js.drawImage( image.js, destRect.origin.x.js, destRect.origin.y.js, destRect.extent.x.js, destRect.extent.y.js )'.
!
drawImage: image sourceRect: sourceRect destRect: destRect
	INLINE 'this.js.drawImage( image.js,
		sourceRect.origin.x.js, sourceRect.origin.y.js, sourceRect.extent.x.js, sourceRect.extent.y.js,
		destRect.origin.x.js, destRect.origin.y.js, destRect.extent.x.js, destRect.extent.y.js )'.
!
createPattern: image repetition: repetition
	^ CanvasPattern fromJs: INLINE 'this.js.createPattern( image.js, repetition.js )'.
!

"ImageData"

createImageData: size	"Point"
	^ ImageData fromJs: INLINE 'this.js.createImageData( size.x.js, size.y.js )'.
!
getImageData: rect
	^ ImageData fromJs: INLINE 'this.js.getImageData( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
putImageData: imageData dest: dest
	INLINE 'this.js.putImageData( imageData.js, dest.x.js, dest.y.js )'.
!
putImageData: imageData dest: dest sourceRect: sourceRect
	INLINE 'this.js.putImageData( imageData.js, dest.x.js, dest.y.js, sourceRect.origin.x.js, sourceRect.origin.y.js, sourceRect.extent.x.js, sourceRect.extent.y.js )'.
!

"Gradients"

createLinearGradientFrom: from to: to
	^ CanvasGradient fromJs: INLINE 'this.js.createLinearGradient( from.x.js, from.y.js, to.x.js, to.y.js )'.
!
createRadialGradientFrom: from radius: fromRadius to: to radius: toRadius
	^ CanvasGradient fromJs: INLINE 'this.js.createRadialGradient( from.x.js, from.y.js, fromRadius.js, to.x.js, to.y.js, toRadius.js )'.
!

"Text"

fillText: text at: point
	INLINE 'this.js.fillText( text.js, point.x.js, point.y.js )'.
!
fillText: text at: point maxWidth: maxWidth
	INLINE 'this.js.fillText( text.js, point.x.js, point.y.js, maxWidth.js )'.
!
measureText: text
	^ TextMetrics fromJs: INLINE 'this.js.measureText( text.js )'.
!
strokeText: text at: point
	INLINE 'this.js.strokeText( text.js, point.x.js, point.y.js )'.
!
strokeText: text at: point maxWidth: maxWidth
	INLINE 'this.js.strokeText( text.js, point.x.js, point.y.js, maxWidth.js )'.
!

"Attributes"

getContextAttributes
	^ ContextAttributes fromJs: INLINE 'this.js.getContextAttributes()'.
!
isContextLost
	^ Boolean fromJs: INLINE 'this.js.isContextLost()'.
!

"Lines"

lineTo: point
	INLINE 'this.js.lineTo( point.x.js, point.y.js )'.
!
setLineDash: segments
	INLINE 'this.js.setLineDash( segments.$toJs() )'.
!
getLineDash
	^ Array fromJs: INLINE 'this.js.getLineDash()' elementClass: Integer.
!

"Collisions"

isPointInPath: point
	^ Boolean fromJs: INLINE 'this.js.isPointInPath( point.x.js, point.y.js )'.
!
isPointInStroke: point
	^ Boolean fromJs: INLINE 'this.js.isPointInStroke( point.x.js, point.y.js )'.
!

"State management"

reset
	INLINE 'this.js.reset()'.
!
save
	INLINE 'this.js.save()'.
!
restore
	INLINE 'this.js.restore()'.
!

"Transform"

getTransform
	^ DomMatrix fromJs: INLINE 'this.js.getTransform()'.
!
setTransform: matrix
	INLINE 'this.js.setTransform( matrix.js )'.
!
transform: matrix
	INLINE 'this.js.transform( matrix.js.a, matrix.js.b, matrix.js.c, matrix.js.d, matrix.js.e, matrix.js.f )'.
!
rotate: angle
	INLINE 'this.js.rotate( angle.js )'.
!
scale: point
	INLINE 'this.js.scale( point.x.js, point.y.js )'.
!
translate: point
	INLINE 'this.js.translate( point.x.js, point.y.js )'.
!
resetTransform
	INLINE 'this.js.resetTransform()'.
!

