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
	INLINE 'if( ![ "x", "y", "width", "height" ].every( key => Number.isInteger( jsObject?.[ key ] ) ) ) return stNil'.
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
