CLASS MyElectronWindowState EXTENDS Object MODULE MyElectronMain CLASSVARS ''
	VARS 'bounds maximized'

"Remembers the bounds and maximized state of a window in a JSON file,
 so the window can be restored to it the next time the app starts.
 The normal bounds are used, so a maximized window is restored to its size before maximizing."

CLASSMETHODS

fromWindow: window
	^ self new bounds: window normalBounds maximized: window maximized.
!
load: path
	"Returns nil if the file does not exist or does not contain a valid state."
	| text jsObject |
	( Fs existsSync: path ) ifFalse: [ ^ nil ].
	text := ( Fs readFileSync: path ) toString.
	jsObject := INLINE '( () => { try { return JSON.parse( text.js ) } catch { return null } } )()'.
	INLINE 'if( ![ "x", "y", "width", "height" ].every( key => Number.isInteger( jsObject?.[ key ] ) ) ) return stNil$'.
	INLINE 'if( jsObject.width <= 0 || jsObject.height <= 0 ) return stNil$'.
	^ self new
		bounds: ( Rect fromJs: jsObject )
		maximized: ( Boolean fromJs: INLINE 'jsObject.maximized === true' ).
!

METHODS

"Accessing"

bounds: aBounds maximized: aMaximized
	bounds := aBounds.
	maximized := aMaximized.
!
bounds
	^ bounds.
!
maximized
	^ maximized.
!

"Testing"

visibleIn: workArea
	"True if enough of the window overlaps the work area for the user to drag it back,
	 e.g. not when the display it was on has been removed."
	| left right top bottom |
	left := bounds origin x max: workArea origin x.
	right := ( bounds origin x + bounds extent x ) min: ( workArea origin x + workArea extent x ).
	top := bounds origin y max: workArea origin y.
	bottom := ( bounds origin y + bounds extent y ) min: ( workArea origin y + workArea extent y ).
	^ ( right - left >= self minimumVisible x ) & ( bottom - top >= self minimumVisible y ).
!
minimumVisible
	^ 100 @ 50.
!

"Saving & applying"

save: path
	Fs writeFileSync: path data: self toJson options: nil.
!
applyTo: window
	window bounds: bounds.
	maximized ifTrue: [ window maximize ].
!

"Converting"

toJson
	^ String fromJs: INLINE 'JSON.stringify( {
		x: this.bounds.$origin().$x().js, y: this.bounds.$origin().$y().js,
		width: this.bounds.$extent().$x().js, height: this.bounds.$extent().$y().js,
		maximized: this.maximized.js } )'.
!
