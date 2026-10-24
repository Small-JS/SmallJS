CLASS ImageData EXTENDS JsObject MODULE Browser CLASSVARS '' VARS ''

"Data
 The data array length is always a multiple of 4 bytes.
 Each pixel is a set of 4 byte values for red, green, blue and alpha."

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
	| data index |
	self assert: [ rgba length = 4 ].
	data := self data.
	index := point y * self width + point x * 4.
	0 to: 3 do: [ :offset |
		data at: index + offset put: ( rgba at: offset ) ].
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
