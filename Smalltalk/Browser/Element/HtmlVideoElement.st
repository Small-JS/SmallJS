CLASS HtmlVideoElement EXTENDS HtmlMediaElement MODULE Browser CLASSVARS '' VARS ''
	"This class encapsulates the JS class HTMLVideoElement.
	 Not implemented: requestPictureInPicture, because it requires user interaction."

METHODS

"Dimensions"

width
	^ Integer fromJs: INLINE 'this.js.width'.
!
width: width
	INLINE 'this.js.width = width.js'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
height: height
	INLINE 'this.js.height = height.js'.
!
size
	^ self width @ self height.
!
size: size
	self width: size x; height: size y.
!
videoWidth
	"The intrinsic width of the video. 0 if it is not known yet."
	^ Integer fromJs: INLINE 'this.js.videoWidth'.
!
videoHeight
	"The intrinsic height of the video. 0 if it is not known yet."
	^ Integer fromJs: INLINE 'this.js.videoHeight'.
!
videoSize
	^ self videoWidth @ self videoHeight.
!

"Other properties"

poster
	^ String fromJs: INLINE 'this.js.poster'.
!
poster: poster
	INLINE 'this.js.poster = poster.js'.
!
playsInline
	^ Boolean fromJs: INLINE 'this.js.playsInline'.
!
playsInline: playsInline
	INLINE 'this.js.playsInline = playsInline.js'.
!
