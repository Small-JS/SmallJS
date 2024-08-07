CLASS CanvasRenderingContext2d EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class: CanvasRenderingContext2D"

"Properties"

canvas
	^ HtmlCanvasElement fromJs: INLINE 'this.js.canvas'.
!
direction
	^ String fromJs: INLINE 'this.js.direction'.
!
direction: direction
	INLINE 'this.js.direction = direction.js'.
!
"Note: fillStyle currently only supports CSS color strings."
fillStyle
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

"Methods"

arc: center radius: radius startAngle: startAngle endAngle: endAngle counterclockwise: counterclockwise
	INLINE 'this.js.arc( center.x.js, center.y.js, radius.js, startAngle.js, endAngle.js, counterclockwise.js )'.
!
arcFrom: from to: to radius: radius
	INLINE 'this.js.arcTo( from.x.js, from.y.js, to.x.js, to.y.js, radius.js )'.
!
beginPath
	INLINE 'this.js.beginPath()'.
!
bezierCurveBetween: between1 and: between2 to: to
	INLINE 'this.js.bezierCurveTo( between1.x.js, between1.y.js, between2.x.js, between2.y.js, to.x.js, to.y.js )'.
!
clearRect: rect
	INLINE 'this.js.clearRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
clip
	INLINE 'this.js.clip()'.
!
closePath
	INLINE 'this.js.closePath()'.
!
createImageData: dimensions	"Point"
	^ ImageData fromJs: INLINE 'this.js.createImageData( dimensions.x.js, dimensions.y.js )'.
!
createPattern: image repetition: repetition
	^ CanvasPattern fromJs: INLINE 'this.js.createPattern( image.js, repetition.js )'.
!
createLinearGradientFrom: from to: to
	^ CanvasGradient fromJs: INLINE 'this.js.createLinearGradient( from.x.js, from.y.js, to.x.js, to.y.js )'.
!
createRadialGradientFrom: from radius: fromRadius to: to radius: toRadius
	^ CanvasGradient fromJs: INLINE 'this.js.createRadialGradient( from.x.js, from.y.js, fromRadius.js, to.x.js, to.y.js, toRadius.js )'.
!
drawFocusIfNeeded: element
	INLINE 'this.js.drawFocusIfNeeded( element.js )'.
!
drawFocusIfNeeded: element path: path
	INLINE 'this.js.drawFocusIfNeeded( element.js, path.js )'.
!
drawImage: image
	INLINE 'this.js.drawImage( image.js )'.
!
drawImage: image destRect: destRect
	INLINE 'this.js.drawImage( image.js, destRect.x.js, destRect.y.js, destRect.width.js, destRect.height.js )'.
!
drawImage: image sourceRect: sourceRect destRect: destRect
	INLINE 'this.js.drawImage( image.js,
		sourceRect.x.js, sourceRect.y.js, sourceRect.width.js, sourceRect.height.js,
		destRect.x.js, destRect.y.js, destRect.width.js, destRect.height.js )'.
!
ellipse: center radii: radii rotation: rotation startAngle: startAngle endAngle: endAngle counterclockwise: counterclockwise
	INLINE 'this.js.ellipse( center.x.js, center.y.js , radii.x.js, radii.y.js, rotation.js, startAngle.js, endAngle.js, counterclockwise.js )'.
!
fill
	INLINE 'this.js.fill()'.
!
fillRule: fillRule
	INLINE 'this.js.fill( fillRule.js )'.
!
fillPath: path
	INLINE 'this.js.fill( path.js )'.
!
fillRect: rect
	INLINE 'this.js.fillRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
fillText: text at: point
	INLINE 'this.js.fillText( text.js, point.x.js, point.y.js )'.
!
fillText: text at: point maxWidth: maxWidth
	INLINE 'this.js.fillText( text.js, point.x.js, point.y.js, maxWidth.js )'.
!
getContextAttributes
	^ ContextAttributes fromJs: INLINE 'this.js.getContextAttributes()'.
!
getImageData: rect
	^ ImageData fromJs: INLINE 'this.js.getImageData( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
getLineDash
	^ Array fromJs: INLINE 'this.js.getLineDash()' elementClass: Integer.
!
getTransform
	^ DomMatrix fromJs: INLINE 'this.js.getTransform()'.
!
isContextLost
	"2024-08-07: Ubuntu Firefox 123.0 does not have this method"
	Window isLinux ifTrue: [ ^ false ].
	^ Boolean fromJs: INLINE 'this.js.isContextLost()'.
!
isPointInPath: point
	^ Boolean fromJs: INLINE 'this.js.isPointInPath( point.x.js, point.y.js )'.
!
isPointInStroke: point
	^ Boolean fromJs: INLINE 'this.js.isPointInStroke( point.x.js, point.y.js )'.
!
lineTo: point
	INLINE 'this.js.lineTo( point.x.js, point.y.js )'.
!
measureText: text
	^ TextMetrics fromJs: INLINE 'this.js.measureText( text.js )'.
!
moveTo: point
	INLINE 'this.js.moveTo( point.x.js, point.y.js )'.
!
getImageData: imageData at: point
	INLINE 'this.js.getImageData( imageData.js, point.x.js, point.y.js )'.
!
quadraticCurveBetween: between to: to
	INLINE 'this.js.quadraticCurveTo( between.x.js, between.y.js, to.x.js, to.y.js )'.
!
rect: rect
	INLINE 'this.js.rect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
reset
	INLINE 'this.js.reset()'.
!
resetTransform
	INLINE 'this.js.resetTransform()'.
!
restore
	INLINE 'this.js.restore()'.
!
rotate: angle
	INLINE 'this.js.rotate( angle.js )'.
!
roundRect: rect radii: radii
	INLINE 'this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radii.js )'.
!
save
	INLINE 'this.js.save()'.
!
scale: point
	INLINE 'this.js.scale( point.x.js, point.y.js )'.
!
setLineDash: segments
	INLINE 'this.js.setLineDash( segments.$toJs() )'.
!
setTransform: matrix
	INLINE 'this.js.setTransform( matrix.js )'.
!
stroke
	INLINE 'this.js.stroke()'.
!
strokePath: path
	INLINE 'this.js.stroke( path.js )'.
!
strokeRect: rect
	INLINE 'this.js.strokeRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js )'.
!
strokeText: text at: point maxWidth: maxWidth
	INLINE 'this.js.strokeText( text.js, point.x.js, point.y.js, maxWidth.js )'.
!
transformA: a  b: b  c: c  d: d  e: e  f: f
	INLINE 'this.js.transform( a.js, b.js, c.js, d.js, e.js, f.js )'.
!
translate: point
	INLINE 'this.js.translate( point.x.js, point.y.js )'.
!
