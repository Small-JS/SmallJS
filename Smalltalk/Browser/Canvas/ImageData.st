CLASS ImageData EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Data
 The data array is always a multple of 4 bytes.
 A set of 4 bytes containting 4 bytes values for red, green, blue and alpha."

data
	^ Uint8Array fromJs: INLINE 'this.js.data'.
!
atPixel: point
	"Return rgba value at point as a 4 byte array"
	| data index rgba  |
	data := self data.
	rgba := Array new: 4.
	index := point y * self width + point x * 4.
	rgba at: 0 put: ( data at: index ).
	rgba at: 1 put: ( data at: index + 1 ).
	rgba at: 2 put: ( data at: index + 2 ).
	rgba at: 3 put: ( data at: index + 3 ).
	^ rgba.
!
atPixel: point put: rgba
	"rgba should by an array with RGBA byte values."
	| index |
	self assert: [ rgba length = 4 ].
	index := point y * self width + point x * 4.
	rgba do: [ :color |
		INLINE 'this.js.data[ index.js++ ] = color.js' ].
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
