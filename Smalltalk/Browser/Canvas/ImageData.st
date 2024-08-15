CLASS ImageData EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Data
 The data array is always a multple of 4 bytes.
 A set of 4 bytes containting 4 bytes values for red, green, blue and alpha."

data
	^ Uint8Array fromJs: INLINE 'this.js.data'.
!
atPixel: index put: rgba
	| byteIndex |
	"rgba should by an array with RGBA byte values."
	self assert: [ rgba length = 4 ].
	byteIndex := index * 4.
	rgba do: [ :color |
		INLINE 'this.js.data[ byteIndex.js++ ] = color.js' ].
!
pixelLength
	^ self data length // 4.
!

"Dimensions"

width
	^ Integer fromJs: INLINE 'this.js.width'.
!
height
	^ Integer fromJs: INLINE 'this.js.height'.
!
extent
	^ self width @ self height.
!
